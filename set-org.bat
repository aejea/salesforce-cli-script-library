:: ==========================
:: ||--[Set Org]--||
:: ==========================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops=center

:: ==================
:: = Get User Input =
:: ==================

set /p TARGET-ORG=Org alias:

:: ==================================
:: = Set the Default Salesforce Org =
:: ==================================

echo Setting Default Salesforce Org to %TARGET-ORG%...
call sf config set target-org=%TARGET-ORG%

pause