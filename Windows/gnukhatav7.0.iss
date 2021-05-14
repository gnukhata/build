; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "GNUKhata"
#define MyAppVersion "7.0"
#define MyAppPublisher "Digital Freedom Foundation"
#define MyAppURL "https://gnukhata.in"
#define MyAppExeName "startgnukhata.EXE"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{2FE425B3-3F6B-4DF4-9FEB-9F36EF931556}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\gnukhatav7.0
DisableDirPage=yes
UsePreviousAppDir=no
DisableProgramGroupPage=yes
LicenseFile=C:\Users\abhijith\Documents\GNUKhata_Windows_Installer\COPYING
OutputDir=C:\Users\abhijith\Documents\GNUKhata_Windows_Installer
OutputBaseFilename=gnukhatav7.0
SetupIconFile=C:\Users\abhijith\Documents\GNUKhata_Windows_Installer\icon.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\gnukhatav7.0\startgnukhata.EXE"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\gnukhatav7.0\postgresql-9.6.9-1-windows-x64.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "C:\gnukhatav7.0\nginx-1.14.0\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\gnukhatav7.0\WPy64-3830\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\gnukhatav7.0\gkcore.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\gnukhatav7.0\gkinit.EXE"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\gnukhatav7.0\gkwebapp.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\gnukhatav7.0\database.EXE"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\gnukhatav7.0\icon.ico"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\icon.ico"
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{app}\icon.ico"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; IconFilename: "{app}\icon.ico"

[Run]
Filename: "{app}\postgresql-9.6.9-1-windows-x64.exe"; Parameters: "--mode unattended --superpassword gkadmin";
Filename: "{app}\database.EXE";
Filename: "{app}\gkinit.EXE";
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: shellexec postinstall skipifsilent

[Registry]
Root: HKLM; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "GNUKhata"; ValueData: "{app}\gkinit.EXE"

