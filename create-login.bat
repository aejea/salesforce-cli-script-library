:: ======================
:: ||--[Create Login]--||
:: ======================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops=center

:: ==================
:: = Get User Input =
:: ==================

set /p SANDBOX-NAME=Sandbox name:
set /p ALIAS=Desired sandbox alias:

:: =====================
:: = Kickoff Web Login =
:: =====================

call sf org login web --alias %ALIAS% --instance-url https://americanequity--%SANDBOX-NAME%.sandbox.my.salesforce.com