REM Title Card
:: ===========================
:: ||--[Retrieve Manifest]--||
:: ===========================

REM Setup
@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops-center

REM Get User Input
set /p ORG_ALIAS=Org alias:
set /p TYPE=Is this a bugfix, story, or task? (example: story):
set /p MESSAGE=Briefly describe the work being retrieved:
set /p PULLREQUEST=Will you be making a GitHub pull request? (yes/no):
set /p MANIFEST=Manifest name (example: se-1234):

REM Retrieve XML Logic
git checkout dev
cls
git checkout -b feature/%TYPE%/%MANIFEST%
cls
git checkout feature/%TYPE%/%MANIFEST%
cls
echo Retrieving from %ORG_ALIAS%...
call sf project retrieve start --ignore-conflicts --target-org %ORG_ALIAS% --manifest manifest\%MANIFEST%.xml
pause
cls
git status
pause
call git add .
call git commit -m "%MESSAGE%"
call git push --set-upstream origin feature/story/%MANIFEST%
git push
pause
if "%PULLREQUEST%"=="yes" (
    start https://github.com/American-Equity-Life/salesforce-devops-center/compare/dev...feature/story/%MANIFEST%?expand=1
)