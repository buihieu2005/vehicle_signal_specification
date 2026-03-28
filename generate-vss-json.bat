@echo off


@REM get VSS version from respo
set /p VSS_VER=<VERSION

@REM set BASE_DIR=C:\SDV\VSS\vehicle_signal_specification-%VSS_VER%

set BASE_DIR=%CD%/..

start cmd /k "cd /d %BASE_DIR% && call .venv/Scripts/activate && python .venv/Scripts/vspec2json.py spec/VehicleSignalSpecification.vspec spec/cust_vss_%VSS_VER%.json"

echo The cust_vss_%VSS_VER%.json located in spec\cust_vss_%VSS_VER%.json