:: ==========================
:: ||--[SObject Describe]--||
:: ==========================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p ORG-ALIAS=Org alias:
set /p SOBJECT-NAME=SObject name:
set /p FILTER=Filter criteria:

:: ========================
:: = Describe the SObject =
:: ========================

call sf sobject describe --sobject "%SOBJECT-NAME%" --target-org %ORG-ALIAS% | FINDSTR "%FILTER%"

pause