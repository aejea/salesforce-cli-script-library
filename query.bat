:: ===============
:: ||--[Query]--||
:: ===============

@echo off
cd ..\salesforce-devops-center

:: ==================
:: = Get User Input =
:: ==================

set /p QUERY=Query: 

:: ==============
:: = Make Query =
:: ==============

call sf data query --query "%QUERY%"

pause