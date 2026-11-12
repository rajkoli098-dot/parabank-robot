*** Settings ***
Documentation    Guru99 settings for Level 8. Credentials come from Windows never from Git


*** Variables ***
${GURU99_URL}    https://demo.guru99.com/V4/
${GURU99_USER}    %{GURU99_USER}
${GURU99_PASSWORD: Secret}    %{GURU99_PASSWORD}
