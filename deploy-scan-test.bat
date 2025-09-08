:: ==========================
:: ||--[Deploy-Scan-Test]--||
:: ==========================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops=center

:: ==================
:: = Get User Input =
:: ==================

set /p TARGET-ORG=Org alias:
set /p CLASS-NAME=Enter the name of the Apex Class you wish to deploy-scan-test:
set /p TEST-CLASS-NAME=Enter the name of the Apex Test Class you wish to deploy-scan-test:

:: ===============
:: = Deploy Code =
:: ===============

echo Deploying %CLASS-NAME% to %TARGET-ORG%...
call sf project deploy start --ignore-conflicts --target-org %TARGET-ORG% --metadata ApexClass:%CLASS-NAME%

pause

:: ===============
:: = Deploy Test =
:: ===============

echo Deploying %TEST-CLASS-NAME% to %TARGET-ORG%...
call sf project deploy start --ignore-conflicts --target-org %TARGET-ORG% --metadata ApexClass:%TEST-CLASS-NAME%

pause

:: ==============
:: = Scan Class =
:: ==============

echo Scanning Local %CLASS-NAME%...
call sf code-analyzer run --target C:\Users\%USERNAME%\bin\salesforce-devops-center\ae\main\default\classes\%CLASS-NAME%.cls

pause

:: =============
:: = Scan Test =
:: =============

echo Scanning Local %TEST-CLASS-NAME%...
call sf code-analyzer run --target C:\Users\%USERNAME%\bin\salesforce-devops-center\ae\main\default\classes\%TEST-CLASS-NAME%.cls

pause

:: =============
:: = Test Code =
:: =============

echo Testing %TEST-CLASS-NAME% on %TARGET-ORG%...
call sf apex test run --result-format human --target-org %TARGET-ORG% --class-names %TEST-CLASS-NAME% --synchronous --code-coverage | FINDSTR %CLASS-NAME%

pause