@echo off
set RELEASE_PATH=%~dp0\..\Win32\Release
set MAJORMINOR=1.0
%OAH_INSTALLED_PATH%bin\pkg-config --modversion %RELEASE_PATH%\lib\pkgconfig\pango.pc > libver.tmp || goto error
set /P LIBVER= < libver.tmp
del libver.tmp

nmake /nologo version=%LIBVER% api_version=%MAJORMINOR% release_path=%RELEASE_PATH% %*

goto:eof
:error
del libver.tmp
echo Couldn't start build process... have you compiled Pango.sln with OAH_BUILD_OUTPUT cleared!??