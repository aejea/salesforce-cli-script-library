:: =====================
:: ||--[Create Apex]--||
:: =====================

@echo off
cd ..\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p CLASS-NAME=State the name of the new Apex Class: 

:: =======================
:: = Create Apex Classes =
:: =======================

call sf apex generate class --name %CLASS-NAME% --output-dir ae\main\default\classes

pause
