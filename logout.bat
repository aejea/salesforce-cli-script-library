:: ======================
:: ||--[Logout]--||
:: ======================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p ORG_ALIAS=Org alias to logout of:

:: ==========
:: = Logout =
:: ==========

call sf org logout --no-prompt --target-org %ORG_ALIAS%

pause