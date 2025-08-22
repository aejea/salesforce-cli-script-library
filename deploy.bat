:: ==========================
:: ||--[Deploy]--||
:: ==========================

@echo off
cd ..\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p TARGET-ORG=Org alias: 
set /p COMPONENT-TYPE=Enter the component type: 
set /p COMPONENT-NAME=Enter the component name: 

:: ===============
:: = Deploy =
:: ===============

echo Deploying %COMPONENT-TYPE%:%COMPONENT-NAME% to %TARGET-ORG%
call sf project deploy start --ignore-conflicts --target-org %TARGET-ORG% --metadata %COMPONENT-TYPE%:%COMPONENT-NAME%

pause