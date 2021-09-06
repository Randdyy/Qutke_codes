@echo off&setlocal enabledelayedexpansion
for %%a in (C:\export_data\historydata\wind\***.dmp) do (
    imp WIND/wind@52.80.136.220/PDB_FOF file=%%a full=y ignore=y
)
pause


imp WIND/wind@52.80.136.220/PDB_FOF  file=C:\export_data\historydata\wind\cbondvaluation.dmp full=y ignore=y;
