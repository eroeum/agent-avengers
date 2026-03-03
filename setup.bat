@echo off
setlocal enabledelayedexpansion

set "CLAUDE_DIR=%USERPROFILE%\.claude"
set "AGENTS_DIR=%CLAUDE_DIR%\agents"
set "SKILLS_DIR=%CLAUDE_DIR%\skills"
set "SCRIPT_DIR=%~dp0"
set "SRC_CLAUDE=%SCRIPT_DIR%.claude"
set "SRC_CONFIG=%SCRIPT_DIR%config"

set installed=0
set skipped=0
set updated=0

:: ---------- preflight ----------
if not exist "%SRC_CLAUDE%\" (
    echo Error: .claude directory not found at %SRC_CLAUDE% >&2
    echo Run this script from the agent-avengers repo root. >&2
    exit /b 1
)

echo [34m==^> Installing agent-avengers into %CLAUDE_DIR%[0m

:: ---------- agents ----------
echo [34m==^> Agents -^> %AGENTS_DIR%[0m
if not exist "%AGENTS_DIR%\" mkdir "%AGENTS_DIR%"
for %%F in ("%SRC_CLAUDE%\agents\*.md") do (
    call :install_file "%%F" "%AGENTS_DIR%\%%~nxF"
)

:: ---------- skills ----------
echo [34m==^> Skills -^> %SKILLS_DIR%[0m
for /d %%D in ("%SRC_CLAUDE%\skills\*") do (
    if exist "%%D\SKILL.md" (
        set "SKILL_NAME=%%~nxD"
        if not exist "%SKILLS_DIR%\!SKILL_NAME!\" mkdir "%SKILLS_DIR%\!SKILL_NAME!"
        call :install_file "%%D\SKILL.md" "%SKILLS_DIR%\!SKILL_NAME!\SKILL.md"
    )
)

:: ---------- settings ----------
echo [34m==^> Settings -^> %CLAUDE_DIR%\settings.json[0m
if exist "%SRC_CONFIG%\settings.json" (
    call :install_file "%SRC_CONFIG%\settings.json" "%CLAUDE_DIR%\settings.json"
)

:: ---------- tmux ----------
echo [34m==^> Tmux -^> %USERPROFILE%\.tmux.conf[0m
if exist "%SRC_CONFIG%\tmux.conf" (
    call :install_file "%SRC_CONFIG%\tmux.conf" "%USERPROFILE%\.tmux.conf"
)

:: ---------- summary ----------
echo.
echo [34m==^> Done[0m
echo   installed %installed% ^| updated %updated% ^| unchanged %skipped%
echo.
echo Agents and skills are now available globally in Claude Code.
echo Run 'claude' in any project to use them.

endlocal
exit /b 0

:: ---------- install_file subroutine ----------
:install_file
set "src=%~1"
set "dest=%~2"

if not exist "%dest%" (
    copy /y "%src%" "%dest%" >nul
    echo [32m  + installed %~nx2[0m
    set /a installed+=1
) else (
    fc /b "%src%" "%dest%" >nul 2>&1
    if errorlevel 1 (
        copy /y "%src%" "%dest%" >nul
        echo [32m  + updated  %~nx2[0m
        set /a updated+=1
    ) else (
        set /a skipped+=1
    )
)
exit /b 0
