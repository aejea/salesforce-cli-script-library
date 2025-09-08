:: ===========================
:: ||--[Deploy Manifest]--||
:: ===========================

@echo off
cd C:\Users\%USERNAME%\bin\salesforce-devops=center

:: ==================
:: = Get User Input =
:: ==================

set /p ORG_ALIAS=Org alias:
set /p MANIFEST=Jira Requirement (example: se-1234):
set /p RUN_UNIT_TESTS=Run local tests? (yes or no):
set /p DRY_RUN=Is this a dry run? (yes or no):

:: =======================
:: = Deploy the manifest =
:: =======================

if /i "%RUN_UNIT_TESTS%"=="no" (
    if /i "%DRY_RUN%"=="no" (
        echo Deploying %MANIFEST% to %ORG_ALIAS%...
        call sf project deploy start ^
        --ignore-conflicts ^
        --target-org %ORG_ALIAS% ^
        --manifest C:\Users\%USERNAME%\bin\salesforce-devops-center\manifest\%MANIFEST%.xml

        pause
    )
)

:: ========================
:: = Dry Run the manifest =
:: ========================

if /i "%RUN_UNIT_TESTS%"=="no" (
    if /i "%DRY_RUN%"=="yes" (
        echo Dry run %MANIFEST% to %ORG_ALIAS%...
        call sf project deploy start ^
        --ignore-conflicts ^
        --target-org %ORG_ALIAS% ^
        --manifest C:\Users\%USERNAME%\bin\salesforce-devops-center\manifest\%MANIFEST%.xml ^
        --dry-run

        pause
    )
)

:: ============================
:: = Deploy Manifest and Test =
:: ============================

if /i "%RUN_UNIT_TESTS%"=="yes" (
    if /i "%DRY_RUN%"=="no" (
        echo Deploying %MANIFEST% to %ORG_ALIAS% and running unit tests...
        call sf project deploy start ^
        --test-level RunLocalTests ^
        --ignore-conflicts ^
        --target-org %ORG_ALIAS% ^
        --manifest C:\Users\%USERNAME%\bin\salesforce-devops-center\manifest\%MANIFEST%.xml

        pause
    )
)

:: =============================
:: = Dry Run Manifest and Test =
:: =============================

if /i "%RUN_UNIT_TESTS%"=="yes" (
    if /i "%DRY_RUN%"=="yes" (
        echo Dry run %MANIFEST% to %ORG_ALIAS% and running unit tests...
        call sf project deploy start ^
        --test-level RunLocalTests ^
        --ignore-conflicts ^
        --target-org %ORG_ALIAS% ^
        --manifest C:\Users\%USERNAME%\bin\salesforce-devops-center\manifest\%MANIFEST%.xml ^
        --dry-run

        pause
    )
)