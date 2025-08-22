REM Title Card
:: ==================================
:: ||-- Make Destructive Changes --||
:: ==================================

REM Initial Setup
@echo off
title Destructive Deployment Utility
cd C:\Users\aejea\bin\salesforce-devops-center
cls

REM Get User Input
set /p ALIAS=What is the Salesforce org alias that you will make these destructive changes in?:
set /p JIRA=What is the card name? (sal-1234):
echo.
echo What type of destructive change do you want to make?
echo.
echo 1. pre-destructive
echo 2. post-destructive
echo 3. both
echo.

choice /C 123 /M "Select an option"
if errorlevel 3 set TYPE=both
if errorlevel 2 set TYPE=post
if errorlevel 1 set TYPE=pre

REM Confirm inputs
cls
echo You selected %TYPE%
echo.
choice /M "Proceed with destructive changes (%TYPE%) for %JIRA% in the %ALIAS% org?"
if errorlevel 2 goto end-no-changes
if errorlevel 1 goto run

REM Switch on TYPE
:run
cls
REM Perform required checks
if not exist manifest\%JIRA%\package.xml (
    echo ERROR: Manifest file not found.
    pause
    goto end-no-changes
)
if "%TYPE%"=="pre" (
    if not exist manifest\%JIRA%\destructiveChangesPre.xml (
        echo ERROR: Pre-destructive changes file not found.
        pause
        goto end-no-changes
    )
    goto pre
)
if "%TYPE%"=="post" (
    if not exist manifest\%JIRA%\destructiveChangesPost.xml (
        echo ERROR: Post-destructive changes file not found.
        pause
        goto end-no-changes
    )
    goto post
)
if "%TYPE%"=="both" (
    if not exist manifest\%JIRA%\destructiveChangesPre.xml (
        echo ERROR: Pre-destructive changes file not found.
        pause
        goto end-no-changes
    )
    if not exist manifest\%JIRA%\destructiveChangesPost.xml (
        echo ERROR: Post-destructive changes file not found.
        pause
        goto end-no-changes
    )
    goto both
)
goto fail

REM Fail softly if no TYPE match
:fail
cls
echo Invalid input - %TYPE%
echo Please enter either "pre", "post", or "both"
pause
goto end-no-changes

REM Deploy Pre-Destructive Changes
:pre
cls
echo Deploying destructive changes (pre)...
call sf project deploy start ^
--ignore-warnings ^
--ignore-conflicts ^
--manifest manifest\%JIRA%\package.xml ^
--pre-destructive-changes manifest\%JIRA%\destructiveChangesPre.xml ^
--target-org %ALIAS%
pause
goto end

REM Deploy Post-Destructive Changes
:post
cls
echo Deploying destructive changes (post)...
call sf project deploy start ^
--ignore-warnings ^
--ignore-conflicts ^
--manifest manifest\%JIRA%\package.xml ^
--post-destructive-changes manifest\%JIRA%\destructiveChangesPost.xml ^
--target-org %ALIAS%
pause
goto end

REM Deploy both Pre-Destructive and Post-Destructive Changes
:both
cls
echo Deploying destructive changes (both)...
call sf project deploy start ^
--ignore-warnings ^
--ignore-conflicts ^
--pre-destructive-changes manifest\%JIRA%\destructiveChangesPre.xml ^
--manifest manifest\%JIRA%\package.xml ^
--post-destructive-changes manifest\%JIRA%\destructiveChangesPost.xml ^
--target-org %ALIAS%
pause
goto end

REM End section for successful decision destinations
:end
cls
echo Destructive script complete!
pause
goto finish

REM End section if there were no changes or for soft fails
:end-no-changes
cls
echo No destructive changes were made.
echo.
pause

:finish