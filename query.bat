:: ===============
:: ||--[Query]--||
:: ===============

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p QUERY=Query:

:: ==============
:: = Make Query =
:: ==============

call sf data query --query "%QUERY%"

pause