:: ===================
:: ||--[Open Apex]--||
:: ===================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops-center\ae\main\default\classes

:: ==================
:: = Get User Input =
:: ==================

set /p CLASS-NAME=Apex class:

:: ======================
:: = Open the Apex Code =
:: ======================

echo opening %CLASS-NAME% in VS-Code...
call code %CLASS-NAME%.cls