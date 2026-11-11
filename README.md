# ParaBank Robot Framework Quest

Hands-on Robot Framework + SeleniumLibrary practice on the ParaBank demo bank.

## Tools

- Python 3.12
- Robot Framework 7.5
- SeleniumLibrary 6.9.0
- PyCharm with the RobotCode plugin

## Setup

1. Create a virtual environment: `python -m venv .venv`
2. Activate it (Windows): `.venv\Scripts\activate`
3. Install packages: `pip install -r requirements.txt`

## How to run

```text
robot --outputdir results results
```

## Planned folder structure

```text
parabank-robot/
├── requirements.txt      # pip packages
├── README.md             # this file
├── Tests/             # All The Tests Suites
│   └── <subfolder>/      # <what lives here>
├── Resources/             # One Resource File is One Web Page
├── Config/
    └── settings.py        # Py file to stored variables
└── results/              # run output, ignored by Git

```

## Why this structure

<2–3 sentences: how your folders keep tests, page keywords, locators,
data and config apart (rules 1–4 in the quest doc)>

## Progress

- [x] Level 0 — Opening Day
- [ ] Level 1 — First Customer at the Counter
- [ ] Level 2 — The XPath Dojo