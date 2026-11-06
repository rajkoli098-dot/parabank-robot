"""Read and write Excel cells by column name, for Robot Framework.

Row 1 of the sheet holds the column names. Every other row is one record,
found by the value in its key column ("Sr No." by default).
"""

from pathlib import Path

from openpyxl import load_workbook


def get_cell_value(path, sheet, row_id, column_name, key_column="Sr No."):
    """Returns the text in ``column_name`` for the row whose ``key_column`` equals ``row_id``.

    Example: ``Get Cell Value    ${FILE}    Sheet1    1    First Name``
    """
    workbook, worksheet = _open(path, sheet, values_only=True)
    try:
        row = _row_number(worksheet, key_column, row_id)
        column = _column_number(worksheet, column_name)
        return _as_text(worksheet.cell(row=row, column=column).value)
    finally:
        workbook.close()


def get_row_as_dictionary(path, sheet, row_id, key_column="Sr No."):
    """Returns the whole row as a dictionary, e.g. ``{'First Name': 'RFT', 'City': 'TWRT'}``.

    Keys are the column names without the trailing colon.
    """
    workbook, worksheet = _open(path, sheet, values_only=True)
    try:
        row = _row_number(worksheet, key_column, row_id)
        data = {}
        for header in worksheet[1]:
            if header.value is None:
                continue
            data[_display_name(header.value)] = _as_text(
                worksheet.cell(row=row, column=header.column).value
            )
        return data
    finally:
        workbook.close()


def set_cell_value(path, sheet, row_id, column_name, value, key_column="Sr No."):
    """Writes ``value`` into ``column_name`` of the matching row and saves the file."""
    workbook, worksheet = _open(path, sheet, values_only=False)
    row = _row_number(worksheet, key_column, row_id)
    worksheet.cell(row=row, column=_column_number(worksheet, column_name), value=value)
    _save(workbook, path)


def save_credentials(path, sheet, row_id, username, password, key_column="Sr No."):
    """Writes ``username`` and ``password`` into the Username and Password columns, then saves."""
    workbook, worksheet = _open(path, sheet, values_only=False)
    row = _row_number(worksheet, key_column, row_id)
    worksheet.cell(row=row, column=_column_number(worksheet, "Username"), value=username)
    worksheet.cell(row=row, column=_column_number(worksheet, "Password"), value=password)
    _save(workbook, path)


# ---- Helpers: names start with "_", so Robot does NOT turn them into keywords ----


def _open(path, sheet, values_only):
    file = Path(path)
    if not file.exists():
        raise FileNotFoundError(f"Excel file not found: {file.resolve()}")
    # values_only=True reads the RESULT of formulas; False keeps formulas so saving does not lose them.
    workbook = load_workbook(file, data_only=values_only)
    if sheet not in workbook.sheetnames:
        workbook.close()
        raise ValueError(f"Sheet '{sheet}' not found. Sheets in this file: {workbook.sheetnames}")
    return workbook, workbook[sheet]


def _clean(name):
    """'  First Name: ' -> 'first name', so the lookup ignores spaces, colon and capitals."""
    return str(name).strip().rstrip(":").strip().lower()


def _display_name(name):
    """'First Name:' -> 'First Name' (keeps the capitals, drops the colon)."""
    return str(name).strip().rstrip(":").strip()


def _as_text(value):
    """Excel gives numbers as 554 or 554.0 and empty cells as None. Robot wants plain text."""
    if value is None:
        return ""
    if isinstance(value, float) and value.is_integer():
        return str(int(value))
    return str(value).strip()


def _column_number(worksheet, column_name):
    wanted = _clean(column_name)
    for cell in worksheet[1]:
        if cell.value is not None and _clean(cell.value) == wanted:
            return cell.column
    headers = [cell.value for cell in worksheet[1] if cell.value is not None]
    raise ValueError(f"Column '{column_name}' not found. Columns in row 1: {headers}")


def _row_number(worksheet, key_column, key_value):
    key = _column_number(worksheet, key_column)
    for row in range(2, worksheet.max_row + 1):
        if _as_text(worksheet.cell(row=row, column=key).value) == _as_text(key_value):
            return row
    raise ValueError(f"No row where '{key_column}' is '{key_value}'.")


def _save(workbook, path):
    try:
        workbook.save(path)
    except PermissionError:
        raise PermissionError(
            f"Cannot save '{path}'. Close the file in Excel and run again."
        ) from None
    finally:
        workbook.close()