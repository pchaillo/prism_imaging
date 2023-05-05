@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install python --version=3.8.10 
python -m pip install --upgrade pip
py -3.8 -m pip install pandas
py -3.8 -m pip install Tk
py -3.8 -m pip install numpy
py -3.8 -m pip install coloraide
py -3.8 -m pip install Pillow
py -3.8 -m pip install opencv-python
py -3.8 -m pip install scipy
pause
powershell -command "Xcopy C:\Python38\tcl\tcl8.6 C:\Python38\lib\tcl8.6 /v /i /e"
powershell -command "Xcopy C:\Python38\tcl\tk8.6 C:\Python38\lib\tk8.6 /v /i /e"
