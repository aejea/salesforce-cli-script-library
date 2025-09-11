:: ==================
:: ||--[Retrieve]--||
:: ==================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p TARGET-ORG=Org alias:
set /p COMPONENT-TYPE=Component type:
set /p COMPONENT-NAME=Component name:

:: ============
:: = Retrieve =
:: ============

echo Retrieving %COMPONENT-TYPE%:%COMPONENT-NAME% from %TARGET-ORG%
call sf project retrieve start --ignore-conflicts --target-org %TARGET-ORG% --metadata %COMPONENT-TYPE%:%COMPONENT-NAME%

pause