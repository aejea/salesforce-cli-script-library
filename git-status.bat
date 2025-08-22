:: ====================
:: ||--[Git Status]--||
:: ====================

@echo off
cd C:\Users\aejea\bin\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p BRANCH-NAME=Branch name: 

:: ===============================================================
:: = Run git status for the specified branch;                    =
:: = If that branch is not "dev", switch back to "dev" afterward =
:: ===============================================================

call git checkout %BRANCH-NAME%
pause

if /I not "%BRANCH-NAME%" == "dev" (
    call git checkout dev
    call git status
    pause
)