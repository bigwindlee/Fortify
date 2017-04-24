@echo off
  setlocal
 
  rem -------------------------------------------------------------------------------------------------------------
  rem 1. Locate in the WLS domain home directory aka %DOMAIN_HOME%, e.g. C:\WLS1213J7_domains\FortifySSC_v4.21.  
  rem    This is the same place you find startWebLogic.cmd.  
  rem 2. These 2 scripts can be used unchanged for any and all WLS domains because they derive the information
  rem    they need based on their location within the directory structure.
  rem 3. Run the command prompt as an Administrator.
  rem -------------------------------------------------------------------------------------------------------------
  
  rem Run the domain's setDomainEnv.cmd
  call "%~dp0\bin\setDomainEnv.cmd"
 
  rem Set needed environment vars not set by the domain's setDomainEnv.cmd
  set USERDOMAIN_HOME=%DOMAIN_HOME%
  if not defined DOMAIN_NAME call :SPLIT %~dp0
 
  rem Get the needed user credentials from the user running this script
  set /p WLS_USER=Please Type WebLogic Username:
  set /p WLS_PW=Please Type the Password:
 
  rem Create the autoboot service process
  call "%WL_HOME%\server\bin\installSvc.cmd"
 
  rem Start the autoboot service process
  net start "wlsvc %DOMAIN_NAME%_%SERVER_NAME%"
 
  endlocal
  goto :eof
 
 
:SPLIT
  set list=%1
  for /f "tokens=1* delims=\" %%A in ("%list%") do (
     set DOMAIN_NAME=%%A
     if not "%%B" == "" call :SPLIT %%B
  )
  goto :eof
 
