@echo off

rem A menu-driven backup using Robocopy for Windows
rem Copyright (C) 2018  Michael Kruzil

rem This program is free software: you can redistribute it and/or modify
rem it under the terms of the GNU General Public License as published by
rem the Free Software Foundation, either version 3 of the License, or
rem (at your option) any later version.

rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
rem GNU General Public License for more details.

rem You should have received a copy of the GNU General Public License
rem along with this program.  If not, see <http://www.gnu.org/licenses/>.

setlocal enabledelayedexpansion

set currdir=%~dp0

echo ---------------------------------
echo Welcome^^!
echo Are you sure you want to proceed?
echo.
echo 1. Yes
echo 2. No
echo ---------------------------------
set /p option="Choose an option: "

if "!option!"=="1" (
    cls

    :source
    set /p source="Enter the source path (or type 'quit' to exit): "
    echo.

    rem Remove quotes added to the string by the user
    rem See: https://ss64.com/nt/syntax-dequote.html
    set source=!source:"=!

    if "!source!"=="quit" (
        goto goodbye
    ) else (
        if exist !source! (
           :destination
            set /p destination="Enter the destination path (or type 'quit' to exit): "
            echo.

            rem Remove quotes added to the string by the user
            set destination=!destination:"=!

            if "!destination!"=="quit" (
                goto goodbye
            ) else (
                if "!destination!"=="" (
                    echo The destination folder cannot be empty^^! Please try again.
                    echo.
                    goto destination
                ) else (
                    rem check if the second character is a colon (ex. c:)
                    set colon=!destination:~1,1!
                    if not "!colon!"==":" (
                        rem check if the third character is a colon (ex. "c:")
                        set colon=!destination:~2,1!
                        if not "!colon!"==":" (
                            echo The destination must be an absolute path^^! Please try again.
                            echo.
                            goto destination
                        )
                    )

                    if not exist !destination! (
                        set /p create="The destination folder '!destination!' does not exist, would you like to create it (y/n)?
                        echo.
                        if "!create!"=="y" (
                            mkdir !destination!
                            if not exist !destination! (
                                echo Could not create destination folder^^! Please try again.
                                echo.
                                goto destination
                            )
                        ) else (
                            goto goodbye
                        )
                    )

                    cls

                    echo ---------------------------------------------------
                    echo Confirm Copy Settings
                    echo Are you sure you want to proceed with this copy? 
                    echo.
                    echo Source: !source!
                    echo Destination: !destination!
                    echo.
                    echo 1. Yes
                    echo 2. No
                    echo ---------------------------------------------------
                    set /p confirm="Choose an option: "

                    if "!confirm!"=="1" (
                        rem SWITCHES
                        rem /e = copy subdirectories, including empty ones
                        rem /z = copy files in restartable mode
                        rem /copy:dat = copy data, attributes, and timestamps for files
                        rem /purge = delete files/dirs in source that no longer exist in source CAREFUL WITH THIS!!
                        rem /dcopy:dat = copy data, attributes, and timestamps for folders
                        rem /xf = exclude files
                        rem /xjd = exclude junction points for Directories
                        rem /r:1 = one retry on failed copy
                        rem /w:0 = wait 0 seconds between retries
                        rem /v = verbose output
                        rem /fp = include full pathname of files in log
                        rem /log:<path>
                        rem /tee = output to console as well as log file
                        cls
                        set log=%currdir%robolog.txt
                        rem Escape trailing backslash because it won't work in Robocopy: https://ss64.com/nt/robocopy.html
                        set backslash=!source:~-1,1!
                        if "!backslash!"=="\" (
                            set source=!source!\
                        )
                        set backslash=!destination:~-1,1!
                        if "!backslash!"=="\" (
                            set destination=!destination!\
                        )
                        #robocopy.exe "!source!" "!destination!" /e /z /copy:dat /dcopy:dat /xf "!log!" /xjd /r:1 /w:0 /v /fp /log:"!log!" /tee
                        echo.
                        echo Done^^!
                        echo.
                        goto end
                    )
                )
            )
        ) else (
            echo The source folder does not exist^^!
            echo.
            goto source
        )
    )
)

:goodbye
cls
echo Goodbye^^!
echo.

:end
pause
exit
