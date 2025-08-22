:: ================================
:: ||--[Salesforce CLI Utility]--||
:: ================================

@echo off

:menu
cls
echo ============================
echo = Salesforce CLI Utilities =
echo ============================
echo.
echo -=Apex=-
echo 1.  Create Apex Class
echo 2.  Verify Apex Code - (Deploy, Scan, and Test)
echo 3.  Run Anonymous Apex Code in the Current Org Context
echo -=Salesforce Orgs=-
echo 4.  Open a List of Available Salesforce Orgs
echo 5.  Create Salesforce Login
echo 6.  Logout of a Salesforce Org
echo 7.  Login to a Salesforce Org (by Org alias)
echo -=Release Management=-
echo 8.  Retrieve a Metadata Component
echo 9.  Retrieve a Metadata Manifest
echo 10. Deploy a Metadata Component
echo 11. Deploy a Metadata Manifest (XML)
echo 12. Perform a Destructive Change
echo 13. Create Rehearse/Rollback Sandbox
echo -=SOQL=-
echo 14. Set the Current Org Context
echo 15. Perform a SOQL Query in the Current Org Context
echo -=MISC=-
echo 16. Open a User Record
echo 17. SObject Describe Analysis (search the schema)
echo.

set /p CHOICE=Select a utility by number [1-17]:

if "%CHOICE%"=="1" goto :CREATE_APEX_CLASS
if "%CHOICE%"=="2" goto :DEPLOY_SCAN_TEST
if "%CHOICE%"=="3" goto :RUN_APEX
if "%CHOICE%"=="4" goto :ORG_LIST
if "%CHOICE%"=="5" goto :CREATE_LOGIN
if "%CHOICE%"=="6" goto :LOGOUT
if "%CHOICE%"=="7" goto :LOGIN
if "%CHOICE%"=="8" goto :RETRIEVE
if "%CHOICE%"=="9" goto :RETRIEVE_MANIFEST
if "%CHOICE%"=="10" goto :DEPLOY
if "%CHOICE%"=="11" goto :DEPLOY_MANIFEST
if "%CHOICE%"=="12" goto :DESTRUCTIVE
if "%CHOICE%"=="13" goto :CREATE_DEV_SANDBOX
if "%CHOICE%"=="14" goto :SET_ORG
if "%CHOICE%"=="15" goto :QUERY
if "%CHOICE%"=="16" goto :OPEN_USER
if "%CHOICE%"=="17" goto :SOBJECT_DESCRIBE

:CREATE_APEX_CLASS
cd C:\Users\aejea\bin\scripts
cls
call create-apex.bat
goto :menu

:DEPLOY_SCAN_TEST
cd C:\Users\aejea\bin\scripts
cls
call deploy-scan-test.bat
goto :menu

:RUN_APEX
cd C:\Users\aejea\bin\scripts
cls
call run-apex.bat
goto :menu

:ORG_LIST
cd C:\Users\aejea\bin\scripts
cls
call org-list.bat
goto :menu

:CREATE_LOGIN
cd C:\Users\aejea\bin\scripts
cls
call create-login.bat
goto :menu

:LOGOUT
cd C:\Users\aejea\bin\scripts
cls
call logout.bat
goto :menu

:LOGIN
cd C:\Users\aejea\bin\scripts
cls
call open-org.bat
goto :menu

:RETRIEVE
cd C:\Users\aejea\bin\scripts
cls
call retrieve.bat
goto :menu

:RETRIEVE_MANIFEST
cd C:\Users\aejea\bin\scripts
cls
call retrieve-manifest.bat
goto :menu

:DEPLOY
cd C:\Users\aejea\bin\scripts
cls
call deploy.bat
goto :menu

:DEPLOY_MANIFEST
cd C:\Users\aejea\bin\scripts
cls
call deploy-manifest.bat
goto :menu

:DESTRUCTIVE
cd C:\Users\aejea\bin\scripts
cls
call destructive.bat
goto :menu

:CREATE_DEV_SANDBOX
cd C:\Users\aejea\bin\scripts
cls
call create-sandbox.bat
goto :menu

:SET_ORG
cd C:\Users\aejea\bin\scripts
cls
call set-org.bat
goto :menu

:QUERY
cd C:\Users\aejea\bin\scripts
cls
call query.bat
goto :menu

:OPEN_USER
cd C:\Users\aejea\bin\scripts
cls
call open-user.bat
goto :menu

:SOBJECT_DESCRIBE
cd C:\Users\aejea\bin\scripts
cls
call sobject-describe.bat
goto :menu
