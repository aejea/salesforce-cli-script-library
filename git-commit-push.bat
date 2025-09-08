:: ===========================
:: ||--[Git - Commit/Push]--||
:: ===========================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops=center

:: ==================
:: = Get User Input =
:: ==================

set /p BRANCH_NAME=Which branch? (leave empty for current branch):
set /p MESSAGE=What is the commit message? (must not be blank):
set /p DO_PUSH=Do you wish to push to the remote branch? (leave empty for no):

:: =============================
:: = Bounce is message is null =
:: =============================

if "%MESSAGE%"=="" (
    echo You must enter a message to proceed. Please try again.
    pause
    exit /b
)

:: =======================================
:: = Remove "" from message if necessary =
:: =======================================

set MESSAGE=%MESSAGE:"=%

:: ==============================
:: = Run git commit (and push?) =
:: ==============================

call git status
if "%BRANCH_NAME%"=="" (
    call git add .
    call git commit -m "%MESSAGE%"
    pause
) else (
    call git checkout %BRANCH_NAME%
    if errorlevel 1 (
        echo ⚠️ Branch '%BRANCH_NAME%' does not exist or failed to checkout.
        pause
        exit /b
    )
    call git add .
    call git commit -m "%MESSAGE%"
    pause
)
if not "%DO_PUSH%"=="" (
    call git push
    pause
)
set /p CHECKOUT_DEV=Do you wish to checkout the dev branch? (leave empty for no)
if not "%CHECKOUT_DEV%"=="" (
    call git checkout dev
    pause
)
call git status
pause