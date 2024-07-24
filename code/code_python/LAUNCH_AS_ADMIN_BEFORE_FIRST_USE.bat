echo off
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

echo Note: Python-derived functionalities (Namely export to 3D file and CSV normalisation) are restricted to MatLab R2020b and newer.

:VERSION
echo.
echo Are you using a MatLab version older than MatLab 2023b? (y/n)

set /p answer=

if %answer% == y goto py381
if %answer% == n goto py311
echo.
echo Please only answer through y (Yes) or n (No).
goto VERSION

:py381
echo.
echo An older MatLab version is used. Installing Python 3.8.10 and the corresponding libraries.
choco install python --version=3.8.10 -y --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python38'"
python -m pip install --upgrade pip
py -3.8 -m pip install coloraide
py -3.8 -m pip install numpy
py -3.8 -m pip install opencv-python
py -3.8 -m pip install pandas
py -3.8 -m pip install Pillow
py -3.8 -m pip install scipy
py -3.8 -m pip install Tk
echo Moving some tkinter folders around to accomodate MatLab looking for them in the wrong space.
powershell -command "Xcopy C:\Python38\tcl\tcl8.6 C:\Python38\lib\tcl8.6 /v /i /e"
powershell -command "Xcopy C:\Python38\tcl\tk8.6 C:\Python38\lib\tk8.6 /v /i /e"
goto END

:py311
echo.
echo A newer MatLab version is used. Installing Python 3.11 and the corresponding libraries.A newer version is used. Installing Python 3.11 and the corresponding libraries
choco install python --version=3.11 -y --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python311'"
python -m pip install --upgrade pip
py -3.11 -m pip install coloraide
py -3.11 -m pip install numpy
py -3.11 -m pip install opencv-python
py -3.11 -m pip install pandas
py -3.11 -m pip install Pillow
py -3.11 -m pip install scipy
py -3.11 -m pip install Tk
echo Moving some tkinter folders around to accomodate MatLab looking for them in the wrong space.
powershell -command "Xcopy C:\Python311\tcl\tcl8.6 C:\Python311\lib\tcl8.6 /v /i /e"
powershell -command "Xcopy C:\Python311\tcl\tk8.6 C:\Python311\lib\tk8.6 /v /i /e"
goto END

:END
echo.
echo Done! Start this program over if some libraries did not install as expected.
pause