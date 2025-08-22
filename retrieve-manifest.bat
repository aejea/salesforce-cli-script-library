:: ===========================
:: ||--[Retrieve Manifest]--||
:: ===========================

@echo off
cd ..\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p ORG_ALIAS=Org alias: 
set /p MANIFEST=Manifest name (example: se-1234):

:: =========================
:: = Retrieve the manifest =
:: =========================

call sf project retrieve start --ignore-conflicts --target-org %ORG_ALIAS% --manifest manifest\%MANIFEST%.xml

pause