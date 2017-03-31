@echo off
  setlocal

  echo %~n0 v2.45 (for PT 8.54, 8.55)
  echo See http://aseng-wiki.us.oracle.com/asengwiki/x/WQGawf----8 for updates.

  set CYGWIN=%CYGWIN% nodosfilewarning

  rem recognize the help request
  if /I 1%1 == 1/? goto :USAGE

  rem Process parameters
  set FO_CXS_PROVIDED=N
  set FO_CLEAN=N
  set FO_XLAT=N
  set FO_SCAN=N
  set FO_DEBUG=N
  set FO_SERIAL=N
  set FO_METHOD=03
  set FO_BLDPLAT=S
  set FO_BLDCHARSET=U
  set FO_BLDBITS=64

  set TOKEN_NO=1
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -CLEAN set FO_CXS_PROVIDED=Y
    if /I %%P == -CLEAN set FO_CLEAN=Y
    if /I %%P == -CLEAN set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -XLAT set FO_CXS_PROVIDED=Y
    if /I %%P == -XLAT set FO_XLAT=Y
    if /I %%P == -XLAT set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -SCAN set FO_CXS_PROVIDED=Y
    if /I %%P == -SCAN set FO_SCAN=Y
    if /I %%P == -SCAN set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -DEBUGLOG set FO_DEBUG=Y
    if /I %%P == -DEBUGLOG set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -SERIAL set FO_SERIAL=Y
    if /I %%P == -SERIAL set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -METHOD1 set FO_METHOD=01
    if /I %%P == -METHOD1 set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -METHOD2 set FO_METHOD=02
    if /I %%P == -METHOD2 set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -METHOD3 set FO_METHOD=03
    if /I %%P == -METHOD3 set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -METHOD4 set FO_METHOD=04
    if /I %%P == -METHOD4 set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -CLIENT set FO_BLDPLAT=C
    if /I %%P == -CLIENT set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -SERVER set FO_BLDPLAT=S
    if /I %%P == -SERVER set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -ANSI set FO_BLDCHARSET=A
    if /I %%P == -ANSI set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -UNICODE set FO_BLDCHARSET=U
    if /I %%P == -UNICODE set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -32BITS set FO_BLDBITS=32
    if /I %%P == -32BITS set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    if /I %%P == -64BITS set FO_BLDBITS=64
    if /I %%P == -64BITS set /a TOKEN_NO=TOKEN_NO + 1
    )
  for /F "tokens=%TOKEN_NO%" %%P in ("%1 %2 %3 %4 %5 %6 %7 %8 %9 **END**") do (
    set FBUILDID=%%P
    )

  if %FO_CXS_PROVIDED% == N (
    set FO_CLEAN=Y
    set FO_XLAT=Y
    set FO_SCAN=Y
    )

  if %FBUILDID% == **END** (
    echo ERROR.  Fortify build ID must be provided.
    goto :USAGE
    )

  rem Report what parameters were found (for debugging)
  if 1 == 0 (
    echo FO_CXS_PROVIDED=%FO_CXS_PROVIDED%
    echo FO_CLEAN=%FO_CLEAN%
    echo FO_XLAT=%FO_XLAT%
    echo FO_SCAN=%FO_SCAN%
    echo FO_DEBUG=%FO_DEBUG%
    echo FO_SERIAL=%FO_SERIAL%
    echo FO_METHOD=%FO_METHOD%
    echo FO_BLDPLAT=%FO_BLDPLAT%
    echo FO_BLDCHARSET=%FO_BLDCHARSET%
    echo FO_BLDBITS=%FO_BLDBITS%
    echo FBUILDID=%FBUILDID%
    )

  if %FO_CXS_PROVIDED% == N goto :NOCONFIRM
  set FO_OPTSTRING=
  if %FO_CLEAN% == Y set FO_OPTSTRING=%FO_OPTSTRING% CLEAN
  if %FO_XLAT%  == Y set FO_OPTSTRING=%FO_OPTSTRING% XLAT
  if %FO_SCAN%  == Y set FO_OPTSTRING=%FO_OPTSTRING% SCAN
  set FO_BLDSTRING=
  if %FO_BLDPLAT% == C    set FO_BLDSTRING=%FO_BLDSTRING% CLIENT
  if %FO_BLDPLAT% == S    set FO_BLDSTRING=%FO_BLDSTRING% SERVER
  if %FO_BLDCHARSET% == A set FO_BLDSTRING=%FO_BLDSTRING% ANSI
  if %FO_BLDCHARSET% == U set FO_BLDSTRING=%FO_BLDSTRING% UNICODE
  if %FO_BLDBITS% == 32   set FO_BLDSTRING=%FO_BLDSTRING% 32BITS
  if %FO_BLDBITS% == 64   set FO_BLDSTRING=%FO_BLDSTRING% 64BITS

  echo Preparing to perform operations '%FO_OPTSTRING% '
  echo            for modules matching '%FO_BLDSTRING%'
  echo             on Fortify Build ID '%FBUILDID%'
  goto :NOCONFIRM
  set /P FO_CONFIRM=  Do you want to continue [Y,N]?
  if /i ~%FO_CONFIRM% == ~N goto :END
:NOCONFIRM

  rem assign 1 to FORTIFY_DEBUG to get Fortify debug logging
  set FORTIFY_DEBUG=1
  rem set FORTIFY_DEBUG=
  if %FO_DEBUG% == Y set FORTIFY_DEBUG=1

  rem Create user-specific SCA results directory on alternate drive
  for %%D in ("D:\MyDocs" "E:\MyDocs") do (
    if exist %%D if not exist %%D\"%USERNAME%\FortifySoftware\sca\Results" md %%D\"%USERNAME%\FortifySoftware\sca\Results"
    )

  rem Locate Fortify Results directory
  set FRESULTDIR="C:\fengl\fortify\Results"
  if not exist %FRESULTDIR% (
    echo Can't find Fortify results directory.
    echo Look at '%~f0' for possible locations.
    echo Search of 'FRESULTDIR'.
    echo Aborting.
    goto :END
    )
  for %%D in (%FRESULTDIR%) do set FRESULTDIR_LFN=%%~fD
  for %%D in (%FRESULTDIR%) do set FRESULTDIR=%%~sD

  rem Create the path to Fortify's ProjectRoot (where the .NST files will go)
  for %%D in ("%FRESULTDIR_LFN%\..\..\ProjRoot") do set FPROJECTDIR_LFN=%%~fD
  for %%D in ("%FRESULTDIR_LFN%\..\..\ProjRoot") do set FPROJECTDIR=%%~sD
  if not exist %FPROJECTDIR% md %FPROJECTDIR%
  if not exist %FPROJECTDIR% (
    echo Can't locate the Fortify project directory.
    echo Looking for "%FPROJECTDIR_LFN%"
    echo Aborting.
    goto :END
    )
  set FPROJECTROOT=-Dcom.fortify.sca.ProjectRoot=%FPROJECTDIR%

  rem construct the proper debug logging switches
  set FDEBUG_LOG_FN=%FRESULTDIR%\debuglog_%FBUILDID%.log
  set FDEBUG_LOG=-debug -verbose -logfile %FDEBUG_LOG_FN%
  set FDEBUG_LOG=-debug -logfile %FDEBUG_LOG_FN%
  if not defined FORTIFY_DEBUG set FDEBUG_LOG=

  rem Locate Fortify program directory (first found wins)
  set FPGMDIR=
      call :FIND_FORTIFY_PGMDIR v16.20 "HPE Security Fortify SCA and Applications 16.20 16.20"
      call :FIND_FORTIFY_PGMDIR v4.21  "HP Fortify SCA and Applications 4.21 4.21"
      call :FIND_FORTIFY_PGMDIR v4.1   "HP Fortify SCA and Applications 4.10 4.10"
      call :FIND_FORTIFY_PGMDIR v4.0   "HP Fortify SCA and Applications 4.00 4.00"
      call :FIND_FORTIFY_PGMDIR v3.8   "HP Fortify SCA and Applications 3.80 3.80"
      call :FIND_FORTIFY_PGMDIR v3.6   {15951EFC-3646-41D2-8484-4060A7766507}
      call :FIND_FORTIFY_PGMDIR v3.5   {24BF18BF-3505-4212-83B3-2FD5B2E35817}
      call :FIND_FORTIFY_PGMDIR v3.4   {945899E4-57F5-47D2-B66A-17D9AD5146CE}
      call :FIND_FORTIFY_PGMDIR v3.2   {BA86E251-12B7-4FD7-A0E5-57E9A8C741AF}
      call :FIND_FORTIFY_PGMDIR v3.1   {913F5662-CFE1-4879-98D6-0D8350D4ECFE}
      call :FIND_FORTIFY_PGMDIR v3.0   {A83ED490-8F5D-4659-9A2B-C497BDC612FD}
      call :FIND_FORTIFY_PGMDIR v2.6.5 {3170C129-D2A1-494C-A9B8-B0AAF9B92061}
      call :FIND_FORTIFY_PGMDIR v2.5.0 {08C6ACF8-C653-4BB8-AA37-51D26D5588F0}
  if not defined FPGMDIR (
    echo Can't find Fortify program directory.
    echo Aborting.
    goto :END
    )
  for %%D in ("%FPGMDIR%") do set FPGMDIR_LFN=%%~fD
  for %%D in ("%FPGMDIR%") do set FPGMDIR=%%~sD
  echo Fortify %FPGMVER% installation found.

  rem Locate Fortify SCA's sourceanalyzer.exe program
  for %%D in ("%FPGMDIR_LFN%\bin\sourceanalyzer.exe") do set FSCA_LFN=%%~fD
  for %%D in ("%FPGMDIR%\bin\sourceanalyzer.exe") do set FSCA=%%~fD
  if not exist %FSCA% (
    echo Can't find Fortify SCA's sourceanalyzer.exe program.
    echo Looking for "%FSCA_LFN%"
    echo Aborting.
    goto :END
    )

  rem Should we use Fortify's 64-bit JRE?
  set CUSEF64=
  if /i 1%PROCESSOR_ARCHITECTURE% == 1AMD64 set CUSEF64=-64
  if /i 1%PROCESSOR_ARCHITEW6432% == 1AMD64 set CUSEF64=-64

  rem Override -64 and always use Fortify's 32-bit JRE
  rem set CUSEF64=
  rem set SCA_VM_OPTS=-Xmx1200m

  rem Set Fortify SCA v2.6.5's session file maximum size
  rem   com.fortify.sca.IncrementFileMaxSizeMB
  rem Doing this speeds up C/C++ translation time
  rem Learned via Fortify Tech Support case # 00030123
  set FSESSIONSIZE=
  set FSESSIONSIZE=-Dcom.fortify.sca.IncrementFileMaxSizeMB=1024

  rem Assemble all of the Fortify SCA command line options together
  set FSCA_OPTS=%CUSEF64% %FPROJECTROOT% %FDEBUG_LOG% %FSESSIONSIZE% -b %FBUILDID%

  rem Locate optional command line timer program
                                              set TIMETHIS=
  for %%I in (DTimeThis.exe) do               set TIMETHIS=%%~fs$PATH:I
  if defined TIMETHIS if not exist %TIMETHIS% set TIMETHIS=

  rem hacky way to add a single blank to the end of %TIMETHIS%
  if defined TIMETHIS set TIMETHIS=%TIMETHIS% $
  if defined TIMETHIS set TIMETHIS=%TIMETHIS:~0,-1%
  rem echo TIMETHIS is '%TIMETHIS%'

  if not defined PS_HOME (
    echo PS_HOME env var must be defined.  Aborting.
    goto :END
    )

  rem Ensure any old scan results don't exist.
  rem I do this to ensure the user hasn't accidentally used the wrong
  rem Fortify build id.
  if %FO_SCAN% == Y if exist %FRESULTDIR%\%FBUILDID%.fpr (
    echo.
    echo An old scan results file still exists.  You must remove the old
    echo scan results file manually before running this job.
    echo Looking for "%FRESULTDIR_LFN%\%FBUILDID%.fpr"
    echo Aborting.
    start "" Explorer /n,/select,"%FRESULTDIR_LFN%\%FBUILDID%.fpr"
    goto :END
    )

  rem Report the SCA_VM_OPTS setting
  echo.
  if not defined SCA_VM_OPTS (
    echo *** The environment variable SCA_VM_OPTS is not set.  You should determine
    echo *** the amount of memory you want to dedicate to SCA and set it into
    echo *** SCA_VM_OPTS using -Xmx[SIZE], e.g. set SCA_VM_OPTS=-Xmx1024M
  ) else (
    echo *** Using SCA_VM_OPTS of '%SCA_VM_OPTS%'
    )

  rem Report when Fortify debug logging is enabled
  if defined FDEBUG_LOG (
    echo *** Fortify debug logging is enabled.
    )

  rem Remove all prior Fortify debug logging files
                             if exist %FDEBUG_LOG_FN%     del %FDEBUG_LOG_FN%
  for /L %%N in (20,-1,0) do if exist %FDEBUG_LOG_FN%.%%N del %FDEBUG_LOG_FN%.%%N

  echo.

  if %FO_CLEAN% == N goto :NOCLEAN
  rem Remove all leftover intermediate files
  echo *** Cleaning out any prior Fortify intermediate files . . .
  %FSCA% %FSCA_OPTS% -clean
  echo *** Cleaning out any prior Fortify intermediate files. DONE.
:NOCLEAN

  if %FO_XLAT% == N goto :NOXLAT

  set GMAKE_BUILD=%PS_HOME%\psconfig.bat
  set NMAKE_BUILD=%PS_HOME%\build\bat\EnvSet.bat
  if exist %GMAKE_BUILD% goto :BUILD_USING_GMAKE
  if exist %NMAKE_BUILD% goto :BUILD_USING_NMAKE
  rem Assume GMAKE build (it will probably fail anyway)
  goto :BUILD_USING_GMAKE


:BUILD_USING_NMAKE
  set CMODS_DIR=C:\User\BAT
  set CMODS=%CMODS_DIR%\cmpmods.bat
  set CMODS_SAVE=%CMODS_DIR%\cmpmods_%RANDOM%.bat
  set CMODS_BUILDID=%~dp0%FBUILDID%.cmpmods
  for %%D in (%CMODS_BUILDID%) do set CMODS_BUILDID=%%~fD

  rem Ensure this specific directory exists
  if not exist %CMODS_DIR% md %CMODS_DIR%

  rem Ensure CMODS_BUILDID file for this build is present
  if not exist %CMODS_BUILDID% (
    echo Can't find CMPMODS.BAT for this build ID.
    echo Looking for %CMODS_BUILDID%
    echo Aborting.
    goto :END
    )

  rem Remove any old cmpall output
  if exist %TEMP%\*.cmp del %TEMP%\*.cmp

  rem Move any existing cmpmods.bat out of the way and setup ours
  if exist %CMODS_SAVE% del %CMODS_SAVE%
  if exist %CMODS% move %CMODS% %CMODS_SAVE%
  echo @rem %~f0             > %CMODS%
  echo @rem %CMODS_BUILDID% >> %CMODS%
  echo.                     >> %CMODS%
  type %CMODS_BUILDID%      >> %CMODS%

  rem Fortify translate the build id by building the modules
  echo *** %~n0 : Running the build . . .
  pushd %PS_HOME%\src
  %TIMETHIS%%FSCA% %FSCA_OPTS% touchless cmpall cmpmods nommk server unicode /a
  popd
  echo *** %~n0 : Running the build. DONE.

  rem Clean up
  del %CMODS%
  if exist %CMODS_SAVE% move %CMODS_SAVE% %CMODS%
  goto :xMAKE_DONE


:BUILD_USING_GMAKE
  set GCMP_PROJECTLIST=%~dp0projects_%FBUILDID%.txt
  for %%D in (%GCMP_PROJECTLIST%) do set GCMP_PROJECTLIST_LFN=%%~fD
  for %%D in (%GCMP_PROJECTLIST%) do set GCMP_PROJECTLIST=%%~sD

  rem Ensure GCMP_PROJECTLIST file for this build is present
  if not exist %GCMP_PROJECTLIST_LFN% (
    echo Can't find GMAKE project list file for this build ID.
    echo Looking for %GCMP_PROJECTLIST_LFN%
    echo Aborting.
    goto :END
    )

  rem Add Fortify program directory to the PATH
  set PATH_FSAVE=%PATH%
  PATH %FPGMDIR%;%PATH%

  rem Invoke the chosen translation hook method
  echo.
  goto :GMAKE_METHOD_%FO_METHOD%

:GMAKE_METHOD_01
  rem Use Fortify's touchless feature (very inefficiently!)
  echo *** Using translation hook method 1
  set PSVSUTILS_SHELL32=%TIMETHIS%%FSCA% %FSCA_OPTS% touchless *BUILD32*
  set PSVSUTILS_SHELL64=%TIMETHIS%%FSCA% %FSCA_OPTS% touchless *BUILD64*
  set PSVSUTILS_SHELL=

  rem Fortify translate the build id by building the modules
  if %FO_SERIAL% EQU Y %TIMETHIS%call %~dp0XLAT_gmake_serial.bat   %GCMP_PROJECTLIST%
  if %FO_SERIAL% NEQ Y %TIMETHIS%call %~dp0XLAT_gmake_parallel.bat %GCMP_PROJECTLIST%
  goto :GMAKE_METHOD_JOIN

:GMAKE_METHOD_02
  rem Avoid Fortify's touchless feature
  echo *** Using translation hook method 2
  set FSCA_CMDLINE=%FSCA% %FSCA_OPTS%
  set PSVSUTILS_SHELL32=%TIMETHIS%%ComSpec% /C %~dp0PSVSUTILS_Fortify.bat *BUILD32*
  set PSVSUTILS_SHELL64=%TIMETHIS%%ComSpec% /C %~dp0PSVSUTILS_Fortify.bat *BUILD64*
  set PSVSUTILS_SHELL=

  rem Fortify translate the build id by building the modules
  if %FO_SERIAL% EQU Y %TIMETHIS%call %~dp0XLAT_gmake_serial.bat   %GCMP_PROJECTLIST%
  if %FO_SERIAL% NEQ Y %TIMETHIS%call %~dp0XLAT_gmake_parallel.bat %GCMP_PROJECTLIST%
  goto :GMAKE_METHOD_JOIN

:GMAKE_METHOD_03
  rem Use Fortify's touchless feature efficiently
  echo *** Using translation hook method 3
  set PSVSUTILS_SHELL32=%TIMETHIS%%ComSpec% /C %~dp0PSVSUTILS_Fortify_touchless.bat *BUILD32*
  set PSVSUTILS_SHELL64=%TIMETHIS%%ComSpec% /C %~dp0PSVSUTILS_Fortify_touchless.bat *BUILD64*
  set PSVSUTILS_SHELL=

  rem psvscmd in 8.54-803-I1+ doesn't use /ps:vc:xxx parameter.  See whether we need it now.
  set VCPARM=/ps:vc:110
  psvscmd %VCPARM% /ps:abi:x86 %ComSpec% /c exit /b 43154 >NUL 2>&1
  if %ERRORLEVEL% NEQ 43154 set VCPARM=

  rem Fortify translate the build id by building the modules
                         set PSVSOPTS=%VCPARM% /ps:abi:x86
  if %FO_BLDBITS% EQU 64 set PSVSOPTS=%VCPARM% /ps:abi:x86_64
  set VCPARM=
  if %FO_SERIAL% EQU Y %TIMETHIS%psvscmd.exe %PSVSOPTS% %FSCA% %FSCA_OPTS% touchless %ComSpec% /c %~dp0XLAT_gmake_serial.bat   %GCMP_PROJECTLIST%
  if %FO_SERIAL% NEQ Y %TIMETHIS%psvscmd.exe %PSVSOPTS% %FSCA% %FSCA_OPTS% touchless %ComSpec% /c %~dp0XLAT_gmake_parallel.bat %GCMP_PROJECTLIST%
  goto :GMAKE_METHOD_JOIN

:GMAKE_METHOD_04
  rem gmake only without any Fortify translation; scan is disabled
  echo *** Using translation hook method 4
  set PSVSUTILS_SHELL32=%TIMETHIS%%ComSpec% /C %~dp0PSVSUTILS_Fortify_touchless.bat *BUILD32*
  set PSVSUTILS_SHELL64=%TIMETHIS%%ComSpec% /C %~dp0PSVSUTILS_Fortify_touchless.bat *BUILD64*
  set PSVSUTILS_SHELL=

  rem Force bypass of the Fortify scan phase
  set FO_SCAN=N

  rem Fortify translate the build id by building the modules
  if %FO_SERIAL% EQU Y %TIMETHIS%%~dp0XLAT_gmake_serial.bat   %GCMP_PROJECTLIST%
  if %FO_SERIAL% NEQ Y %TIMETHIS%%~dp0XLAT_gmake_parallel.bat %GCMP_PROJECTLIST%
  goto :GMAKE_METHOD_JOIN

:GMAKE_METHOD_JOIN
  rem Clean up
  set PATH=%PATH_FSAVE%
  goto :xMAKE_DONE


:xMAKE_DONE
  echo.
  echo.
:NOXLAT

  if %FO_SCAN% == N goto :NOSCAN
  rem Remove any old scan results
  if exist %FRESULTDIR%\%FBUILDID%.fpr del %FRESULTDIR%\%FBUILDID%.fpr
  rem Fortify scan the build id
  echo *** %~n0 : Executing the Fortify project scan . . .
  %TIMETHIS%%FSCA% %FSCA_OPTS% -scan -build-label %PS_HOME% -f %FRESULTDIR%\%FBUILDID%.fpr
  echo *** %~n0 : Executing the Fortify project scan. DONE.
  echo.
  echo.
:NOSCAN

  goto :END


:FIND_FORTIFY_PGMDIR
  rem Command Line:      %0      %1      %2
  rem Command Line:  BatchName Version RegKey

  rem Don't look further if a Fortify program directory was already found
  if defined FPGMDIR goto :END

  set RegKey=%2
  set RegKey=%RegKey:"=%

  rem echo ...Looking for Fortify %1 . . .
  for /F "usebackq tokens=2*" %%A in (`%ComSpec% /c ^"reg query ^"HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\%RegKey%^" /v InstallLocation 2^>nul ^| grep REG_SZ^"`) do set FPGMDIR=%%B
  for /F "usebackq tokens=2*" %%A in (`%ComSpec% /c ^"reg query ^"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%RegKey%^"             /v InstallLocation 2^>nul ^| grep REG_SZ^"`) do set FPGMDIR=%%B
  if not defined FPGMDIR goto :END

  rem Remember the found Fortify's version
  set FPGMVER=%1
  rem echo ...Fortify %FPGMVER% found in %FPGMDIR%
  goto :END


:USAGE
  echo.
  echo USAGE:
  echo   %~n0 [/?] [OPTIONS]... BuildID
  echo where OPTIONS are
  echo.  /?        - show these help instructions
  echo   -clean    - remove all prior translation (.NST) files
  echo   -xlat     - run Fortify's translation step to create intermediat .NST files
  echo   -scan     - run Fortify's scan step to create the final .FPR file
  echo   -debuglog - run Fortify's with its debug logging enabled
  echo   -serial   - use serial build for gmake builds (default is parallel)
  echo   -method1  - use translation hook method 1
  echo   -method2  - use translation hook method 2
  echo   -method3  - use translation hook method 3 (default)
  echo   -method4  - use translation hook method 4
  echo   -client   - build only CLIENT modules
  echo   -server   - build only SERVER modules (default)
  echo   -ansi     - build only ANSI modules
  echo   -unicode  - build only UNICODE modules (default)
  echo   -32bits   - build only 32 bit modules
  echo   -64bits   - build only 64 bit modules (default)
  echo   BuildId   - the name for the Fortify build ID (required)
  echo.
  echo When no optional parameters are provided, the default is
  echo     "-clean -xlat -scan -method3 -server -unicode -64bits"
  echo.
  goto :END


:END
