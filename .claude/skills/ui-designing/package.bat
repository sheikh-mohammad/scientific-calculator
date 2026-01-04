@echo off
echo Packaging UI Designing Skill...

REM Create a zip file of the skill
powershell Compress-Archive -Path ".\ui-designing" -DestinationPath "ui-designing.skill" -Force

echo.
echo ✅ UI Designing Skill packaged successfully!
echo 📦 File created: ui-designing.skill
echo.
echo To install this skill in Claude Code, use:
echo claude code install ui-designing.skill