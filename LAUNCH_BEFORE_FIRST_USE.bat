@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install -y python3.8
python -m pip install --upgrade pip
python-3.8 -m pip install pandas
python-3.8 -m pip install Tk
python-3.8 -m pip install numpy
python-3.8 -m pip install coloraide