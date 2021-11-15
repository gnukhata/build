' Script to start GNUkhata init scripts in a hidden command propmt
Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run chr(34) & "C:\gnukhatav7.0.t\init_gnukhata.bat" & Chr(34), 0
Set WshShell = Nothing