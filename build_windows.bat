rd /S /Q Web2ExeWin
call pyinstaller --onefile --hidden-import PIL.Jpeg2KImagePlugin --hidden-import configobj --hidden-import pkg_resources -i icon.ico --distpath command_line_builds -n web2exe-win command_line.py
rd /S /Q command_line_builds\files
echo D | xcopy /s files command_line_builds\files


call pyinstaller -w --onefile --hidden-import PIL.Jpeg2KImagePlugin --hidden-import pkg_resources --hidden-import configobj -i icon.ico --distpath Web2ExeWin -n Web2Exe main.py
echo D | xcopy /s files Web2ExeWin\files

del Web2ExeWin\files\compressors\upx-mac
del Web2ExeWin\files\compressors\upx-linux-x64
del Web2ExeWin\files\compressors\upx-linux-x32

del command_line_builds\files\compressors\upx-mac
del command_line_builds\files\compressors\upx-linux-x64
del command_line_builds\files\compressors\upx-linux-x32

makensis /V4 Web2Exe.nsi

set /p Version=<files\version.txt

7z a Web2ExeWin-%Version%.zip -r Web2ExeWin
cd command_line_builds
7z a ..\Web2ExeWin-CMD.zip -tzip -r *
cd ..
7z a Web2ExeWin-Setup.zip Web2Exe-Setup.exe

call python upload_release.py
