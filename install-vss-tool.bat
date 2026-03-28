REM VSS guideline : https://github.com/COVESA/vehicle_signal_specification/blob/master/BUILD.md
REM VSS tool guideline:   https://github.com/COVESA/vss-tools

@echo off

REM - configuration
SET PATH=%PATH%;C:\toolbase\python\3.11.4.2
SET VENV_DIR=.venv
SET VSS_VERSION=4.0
SET VSS_TOOL_VERSION=4.2

REM set /p VSS_VER=<VERSION


REM Step 2. Get all submodules (git submodule update --init)
git submodule update --init

REM Step 3. Install the VSS tool

REM Check if the .venv directory exists
IF EXIST "%VENV_DIR%\" (
    REM Check if the Scripts\activate.bat file exists inside .venv
    IF EXIST "%VENV_DIR%\Scripts\activate.bat" (
        echo Virtual environment already exists.
    ) ELSE (
        echo .venv folder exists but doesn't seem to be a valid virtual environment.
    )
) ELSE (
    echo Virtual environment not found. Create one
    python -m venv .venv
)

REM call the activate.bat file
call .venv\Scripts\activate

python -c "import sys; print('Using:', sys.executable)"

for /f "tokens=2" %%v in ('python -m pip show vss-tools ^| findstr "^Version:"') do set VERSION=%%v

if "%VERSION%"=="%VSS_TOOL_VERSION%" (
    echo vss-tools==%VSS_TOOL_VERSION% is already installed.
) else (
    echo Installing vss-tools==%VSS_TOOL_VERSION%...
    python -m pip install vss-tools==%VSS_TOOL_VERSION%
)
