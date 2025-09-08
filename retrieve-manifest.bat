:: ===========================
:: ||--[Retrieve Manifest]--||
:: ===========================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p ORG_ALIAS=Org alias:
set /p TYPE=Is this a bugfix, story, or task? (example: story)
set /p MANIFEST=Manifest name (example: se-1234):

:: =========================
:: = Retrieve the manifest =
:: =========================

git checkout -b feature/%TYPE%/%MANIFEST%
IF %ERRORLEVEL% NEQ 0 (
    echo Branch exists. Checking it out...
    git checkout feature/%TYPE%/%MANIFEST%
    IF %ERRORLEVEL% NEQ 0 (
        echo Failed to checkout existing branch.
        pause
        goto :end
    )
)
pause
cls
call sf project retrieve start --ignore-conflicts --target-org %ORG_ALIAS% --manifest manifest\%MANIFEST%.xml
pause

:end