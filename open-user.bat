:: ===================
:: ||--[Open User]--||
:: ===================

@echo off
cd ..\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p ORG_ALIAS=Org alias: 
set /p USER_ID=User Id: 

:: ===========================
:: = Open User Detail Record =
:: ===========================

if %ORG_ALIAS%==prod (
    start "" https://americanequity.lightning.force.com/lightning/setup/ManageUsers/page?address=/%USER_ID%?noredirect=1&isUserEntityOverride=1&retURL=/setup/home
) else (
    echo %ORG_ALIAS%
    start "" https://americanequity--%ORG_ALIAS%.sandbox.my.salesforce-setup.com/lightning/setup/ManageUsers/page?address=/%USER_ID%?noredirect=1&isUserEntityOverride=1&retURL=/setup/home
)