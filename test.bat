@echo off
set /p total=Enter the total number of iterations: 

for /l %%i in (1,1,%total%) do (
  set /p "progress=(%%i * 100 / %total%)"
  echo %progress%
  echo [%progress%%]
  for /l %%j in (1,1,%progress%) do (
    echo.
  )
  ping localhost -n 2 > nul
)


////////////////////

