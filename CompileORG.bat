//Compile.bat => Compile FolderName ProjectName
@ECHO OFF
CLS
IF "%2"=="" GOTO EXIT_ERROR

SET D7InstPath=C:\Borland\Delphi 7

SET OldPath=%Path%
PATH "%D7InstPath%\Bin";%PATH%

ECHO Converting all DFM to binaries
CD ""
CONVERT -i -s -b "%D7InstPath%\*.dfm" >nul:
CONVERT -i -s -b "C:\VCL\*.dfm" >nul:
CONVERT -i -s -b "C:\Source\V5_Released\*.dfm" >nul:
ECHO DFM converted

CD "C:\Source\V5_Released\%1"
ECHO Deleting DCUs from source folder ...
DEL *.DCU
ECHO DCUs deleted

ECHO Building resources ...
"BRCC32.exe" -32 "%2.rc" >nul:
ECHO Resource built

ECHO Building program ...
"DCC32.exe" -B "%2.dpr" >"C:\Source\V5_Released\EXE\BuildLog%2.txt"
ECHO program built

CD "%D7InstPath%"
GOTO END
:EXIT_ERROR
ECHO Compile FolderName ProjectName
ECHO   FolderName=path from C:\Source\V5_Released (ie "Back Office\autofloor")
ECHO   ProjectName = project name without extention (ie "Autofloor")
:END
