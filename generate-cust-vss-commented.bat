@echo off
REM -----------------------------------------------------------------------------
REM Batch file to generate custom Vehicle Signal Specification (VSS) JSON output
REM -----------------------------------------------------------------------------

REM 1. Check if the Python virtual environment (.venv) exists
REM    - If not, create it using the system's Python installation
REM    - This ensures all dependencies are isolated and do not affect global Python
IF NOT EXIST .venv (
    echo [INFO] Python virtual environment not found. Creating .venv...
    REM You can specify a different Python version if needed (e.g., python3.10 -m venv .venv)
    python -m venv .venv
    IF %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Failed to create virtual environment. Ensure Python is installed and in your PATH.
        exit /b 1
    )
    echo [INFO] Virtual environment created successfully.
)

REM 2. (Optional) Install required Python packages if requirements.txt exists
REM    - This step ensures all dependencies are installed in the virtual environment
IF EXIST requirements.txt (
    echo [INFO] Installing required Python packages from requirements.txt...
    .venv\Scripts\python.exe -m pip install --upgrade pip
    .venv\Scripts\python.exe -m pip install -r requirements.txt
    IF %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Failed to install required packages. Check requirements.txt and your internet connection.
        exit /b 1
    )
    echo [INFO] Python packages installed successfully.
)

REM 3. Run the vspec2json.py script to generate the custom VSS JSON
REM    - .venv\Scripts\python.exe: Uses the Python interpreter from the local virtual environment
REM    - .venv\Scripts\vspec2json.py: The script to convert VSS to JSON
REM    - -I spec: Sets the input directory for VSS spec files
REM    - -u spec\units.yaml: Specifies the units definition file
REM    - -vt overlays\extensions\types\fault_management_types.vspec: Adds custom VSS type definitions
REM    - -o overlays\extensions\fault_management_struct.vspec: Output VSS structure file
REM    - spec\VehicleSignalSpecification.vspec: Main VSS specification file
REM    - spec\cust_fault_management_struct_vss_4.0.json: Output JSON file for custom signals

.venv\Scripts\python.exe .venv\Scripts\vspec2json.py ^
    -I spec ^
    -u spec\units.yaml ^
    -vt overlays\extensions\types\fault_management_types.vspec ^
    -o overlays\extensions\fault_management_struct.vspec ^
    spec\VehicleSignalSpecification.vspec ^
    spec\cust_fault_management_struct_vss_4.0.json

REM -----------------------------------------------------------------------------
REM End of script
REM -----------------------------------------------------------------------------
