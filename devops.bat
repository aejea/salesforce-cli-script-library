@echo off
REM Title Card
:: =============================
:: = Salesforce DevOps Utility =
:: =============================

REM Set the Release Date
for /f %%D in ('powershell -command ^
    "$d=Get-Date; while ($d.DayOfWeek -ne 'Thursday') { $d = $d.AddDays(1) }; $d.ToString('yyyy-MM-dd')"') do set "releaseDate=%%D"

REM Menu
:menu
cls
echo ===========================
echo = Salesforce DevOps Panel =
echo ===========================
echo.
echo -=Planning=-
echo 1.  Inspect Salesforce Releases Dashboard
echo 2.  Create Teams Post in DevOps Channel: "Release Readiness"
echo 3.  Perform Quality Assurance on a Release Candidate
echo 4.  Post C.A.B. readiness in "Release Readiness"
echo.
echo -=On C.A.B. Day=-
echo 5.  Post C.A.B. Approval for Release Candidates
echo.
echo -=On Release Day=-
echo 6.  Create ROLLBACK Sandbox
echo 7.  Create REHEARSE Sandbox
echo 8.  Authenticate REHEARSE Sandbox
echo 9.  Create Release Manifest
echo 10. Perform Dry-Run to PROD
echo 11. Perform Deployment to REHEARSE
echo 12. Coordinate with Developers for Sign-Off
echo 13. Identify Jira Release Subtasks and Assign Yourself
echo 14. Post Ready for Release in "Release Readiness"
echo.
echo -=On Release Evening=-
echo 15. Perform Release to PROD
echo 16. Mark Jira Issues as "Done"
echo 17. Post Release Success in "Release Readiness"
echo 18. Post Release Success in "Salesforce Universe"
echo 19. Update Source Control
echo 20. Delete Local Manifests
echo.

REM Get User Input
set /p CHOICE=Select a utility by number [1-5]:

REM Choices
if "%CHOICE%"=="0" goto :cleanup
if "%CHOICE%"=="1" goto :inspect
if "%CHOICE%"=="2" goto :createPost
if "%CHOICE%"=="3" goto :performQA
if "%CHOICE%"=="4" goto :postCABReadiness
if "%CHOICE%"=="5" goto :postCABApproval
if "%CHOICE%"=="6" goto :createRollbackSandbox
if "%CHOICE%"=="7" goto :createRehearseSandbox
if "%CHOICE%"=="8" goto :authenticateRehearseSandbox
if "%CHOICE%"=="9" goto :createReleaseManifest
if "%CHOICE%"=="10" goto :performDryRun
if "%CHOICE%"=="11" goto :performRehearseDeployment
if "%CHOICE%"=="12" goto :coordinateWithDevelopers
if "%CHOICE%"=="13" goto :assignJiraSubtasks
if "%CHOICE%"=="14" goto :postReadyForRelease
if "%CHOICE%"=="15" goto :performProdDeployment
if "%CHOICE%"=="16" goto :markJiraIssuesDone
if "%CHOICE%"=="17" goto :postSuccessDevOps
if "%CHOICE%"=="18" goto :postSuccessUniverse
if "%CHOICE%"=="19" goto :updateSourceControl
if "%CHOICE%"=="20" goto :deleteLocalManifests

REM Delete ROLLBACK Sandbox
:cleanup
cls
1. Delete the ROLLBACK Sandbox
2. Delete the REHEARSE Sandbox
3. Delete the release.xml (manifest\release.xml)
goto :menu

REM Inspect Salesforce Releases Dashboard
:inspect
start https://aecollab.atlassian.net/jira/dashboards/10935
goto :menu

REM Create Teams Post
:createPost
cls
echo Loading...
:continueCreatePost
cls
echo Copy for Subject:
echo.
echo "Salesforce Release Readiness - %releaseDate%"
echo.
pause
cls
echo Copy for Message:
echo.
echo "The following release candidates are scheduled to be released on %releaseDate%:"
echo.
pause
cls
echo Copy and paste urls from the Salesforce Releases Dashboard.
echo.
pause
goto :menu

REM Perform Quality Assurance
:performQA
cls
echo The Jira candidate should have a "Resolution and Technical Notes" section in the description.
echo This section should summarize the actual solution used to complete the work.
echo.
pause
cls
echo The Jira candidate should, where necessary, have one or more Manifests in XML format.
echo The manifest should be a package manifest that lists the metadata components included with the candidate.
echo.
pause
cls
echo The Jira candidate shoud have the "Release" subtab filled in with a link to the release docs in Confluence.
echo The preferred url is: "https://aecollab.atlassian.net/wiki/x/PIDJ1Q".
echo.
pause
goto :menu

REM Post C.A.B. Readiness
:postCABReadiness
cls
echo Post as a reply to "Release Readiness":
echo.
echo "I have evaluated all release candidates and am ready for C.A.B."
echo.
echo This should be posted before end of business on the Monday of release week.
echo.
pause
goto :menu

REM Post C.A.B. Approval
:postCABApproval
cls
echo Post as a reply to "Release Readiness":
echo.
echo "I attended C.A.B. today and the following release candidates were approved:"
echo.
echo Include the URLs of each Jira Release Candidate that was approved in C.A.B.
echo.
pause
goto :menu

REM Create ROLLBACK Sandbox
:createRollbackSandbox
cls
cd C:\Users\%USERNAME%\bin\salesforce-devops-center
call sf org create sandbox --alias ROLLBACK --async --license-type Developer --name rollback --target-org prod
pause
goto :menu

REM Create REHEARSE Sandbox
:createRehearseSandbox
cls
cd C:\Users\%USERNAME%\bin\salesforce-devops-center
call sf org create sandbox --alias REHEARSE --async --license-type Developer --name rehearse --target-org prod
pause
goto :menu

REM Authenticate REHEARSE Sandbox
:authenticateRehearseSandbox
cls
call sf org login web --alias REHEARSE --instance-url https://americanequity--rehearse.sandbox.my.salesforce.com
pause
goto :menu

REM Create Release Manifest
:createReleaseManifest
cls
(
echo ^<?xml version="1.0" encoding="UTF-8" standalone="yes"?^>
echo ^<!--MANUAL PRE-DEPLOYMENT STEPS--^>
echo ^<!-- --^>
echo ^<Package xmlns="http://soap.sforce.com/2006/04/metadata"^>
echo     ^<version^>64^</version^>
echo ^</Package^>
echo ^<!--MANUAL POST-DEPLOYMENT STEPS--^>
echo ^<!-- --^>
) > C:\Users\%USERNAME%\bin\salesforce-devops-center\manifest\release.xml
call code C:\Users\%USERNAME%\bin\salesforce-devops-center\manifest\release.xml
goto :menu

REM Perform a Dry-Run Validation to PROD
:performDryRun
cls
cd C:\Users\%USERNAME%\bin\salesforce-devops-center
call sf project deploy start --ignore-conflicts --manifest manifest\release.xml --test-level RunLocalTests --target-org prod --dry-run
pause
goto :menu

REM Perform a Deployment to Rehearse
:performRehearseDeployment
cls
echo Perform all manual pre-deployment steps.
pause
cls
cd C:\Users\%USERNAME%\bin\salesforce-devops-center
call sf project deploy start --ignore-conflicts --manifest manifest\release.xml --target-org REHEARSE
pause
cls
echo Now perform all manual post-deployment steps.
pause
goto :menu

REM Authenticate Developers in Rehearse
:authenticateDevelopersInRehearse
cls
echo "Once logged into REHEARSE, make sure each Salesforce Developer is activated with the correct email and has a password reset".
echo.
pause
call sf org open --target-org REHEARSE
goto :menu

REM Coordinate with Developers
:coordinateWithDevelopers
cls
echo Request developer sign-off in "Release Readiness":
echo.
echo "The deployment to REHEARSE is complete.  Please verify the release candidates and sign off in this thread."
echo.
pause
goto :menu

REM Identify Jira Release Subtasks and Assign Yourself
:assignJiraSubtasks
cls
echo On the following Jira Dashboard, find all Salesforce work for release and assign yourself to the subtasks for deployment.
echo.
pause
start https://aecollab.atlassian.net/jira/dashboards/12225
goto :menu

REM Post Ready for Release
:postReadyForRelease
cls
echo Post Release Ready in "Release Readiness":
echo.
echo "The release has been verified in PROD, has been deployed to REHEARSE, and has been verified by all Developers."
echo "The release is ready for deployment to PROD as of %TIME% on %releaseDate%."
echo.
pause
goto :menu

REM Perform Release to PROD
:performProdDeployment
cls
echo Perform all manual pre-deployment steps.
echo.
pause
call sf project deploy start --ignore-conflicts --manifest manifest\release.xml --target-org prod
pause
echo Now perform all manual post-deployment steps.
echo.
pause
goto :menu

REM Mark Jira Release Issues as Done
:markJiraIssuesDone
cls
echo Marking Subtasks as "Done" will automatically update Release Candidates to "Post Implementation".
echo Starting from the "Release Cards for Today" Dashboard, mark subtasks as "Done", then navigate to parents, refresh, and mark as "Done".
echo.
pause
start https://aecollab.atlassian.net/jira/dashboards/10935
goto :menu

REM Post Release Success in DevOps
:postSuccessDevOps
cls
echo Post in "Release Readiness":
echo.
echo "The following Release Candidates were successfully deployed to Production:"
echo.
pause
cls
echo Copy and Paste the URLs of all deployed Release Candidates.
echo.
pause
cls
echo @Mention Stacey Waters
echo.
pause
goto :menu

REM Post Release Success in DevOps
:postSuccessUniverse
cls
echo Post in "Salesforce Universe":
echo.
pause
cls
echo Subject: "SALESFORCE RELEASE - %releaseDate%"
echo.
pause
cls
echo Message: "The following Release Candidates were successfully deployed to Production:"
echo.
pause
cls
echo Copy and Paste the URLs of all deployed Release Candidates.
echo.
pause
cls
echo @Mention Stacey Waters, Derrick Aldridge, and Curtis Lawhorn
echo.
pause
goto :menu

REM Update Source Control
:updateSourceControl
cls
cd C:\Users\%USERNAME%\bin\salesforce-devops-center
git checkout main
call sf project retrieve start --ignore-conflicts --manifest manifest\release.xml --target-org prod
git add .
git commit -m "RELEASE--%releaseDate%"
git push
git checkout dev
pause
goto :menu

REM Delete Local Manifests
:deleteLocalManifests
cls
echo In the "manifests" subfolder, delete any Release Candidate XML files
echo.
pause
goto :menu