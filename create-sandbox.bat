:: ========================
:: ||--[Create Sandbox]--||
:: ========================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops=center

:: ==================
:: = Get User Input =
:: ==================

set /p SANDBOX-ALIAS=Sandbox alias:
set /p SANDBOX-NAME=Sandbox name (must be 10 characters or less):

:: ==================
:: = Create Sandbox =
:: ==================

call sf org create sandbox --alias %SANDBOX-ALIAS% --async --license-type Developer --name %SANDBOX-NAME% --target-org prod