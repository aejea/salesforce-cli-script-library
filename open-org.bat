REM Title Card
:: ==================
:: ||--[Open Org]--||
:: ==================

REM Initial Setup
@echo off
title Login to Salesforce Org
cd C:\Users\%USERNAME%\bin\salesforce-devops=center
cls

REM Get User Input
set /p ORG-NAME=Org name:

REM Run
call sf org open --target-org %ORG-NAME%
exit