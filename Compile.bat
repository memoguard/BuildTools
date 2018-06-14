REM Compile.bat => Compile FolderName ProjectName
@ECHO OFF
CLS
IF "%2"=="" GOTO EXIT_ERROR

SET D7InstPath=C:\Temp\BuildTools

SET OldPath=%Path%
PATH "%D7InstPath%";%PATH%

REM ECHO Converting all DFM to binaries
REM CD ""
REM CONVERT -i -s -b "%D7InstPath%\*.dfm" >nul:
REM CONVERT -i -s -b "C:\VCL\*.dfm" >nul:
REM CONVERT -i -s -b "C:\Source\V5_Released\*.dfm" >nul:
REM ECHO DFM converted

CD "%1"
ECHO Deleting DCUs from source folder ...
DEL *.DCU
ECHO DCUs deleted

REM ECHO Building resources ...
REM "BRCC32.exe" -32 "%2.rc" >nul:
REM ECHO Resource built

ECHO Building program ... with Force ReBuild option
"DCC32.exe" -B "%2.dpr" > "C:\Temp\BuildLog\BuildLog_%2.txt"
ECHO program built OK

ECHO Including mab file
"map2mab.exe"  "%1\%2.exe" 
ECHO mab included OK

REM CD "%D7InstPath%"

SET PATH=%OLDPATH%

GOTO END
:EXIT_ERROR
ECHO Compile FolderName ProjectName
ECHO   FolderName=path from C:\Temp\BuildSrc (ie "FleetWash")
ECHO   ProjectName = project name without extension (ie "FleetWash_Transfer")
:END
