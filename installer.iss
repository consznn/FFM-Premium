#define MyAppName "FastFlag+ Manager"
#define MyAppVersion "0.0.2"
#define MyAppPublisher "consznn"
#define MyAppURL "https://github.com/consznn/FFM-Premium"
#define MyAppExeName "FastFlag+ Manager.exe"

[Setup]
AppId={{AA0B1C-FF4A-4B6E-A533-1D0A4F6A2D1F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={localappdata}\Programs\{#MyAppName}
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
OutputDir=.
OutputBaseFilename=FFP_Installer
SetupIconFile=ffp_v3_logo.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes
AppMutex=FFlagManager_SingleInstance_Mutex
UninstallDisplayIcon={app}\{#MyAppExeName}
DisableDirPage=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[InstallDelete]
; Remove the old shortcut so user doesn't accidentally launch old app
Type: files; Name: "{autoprograms}\Roblox FFlag Manager.lnk"
Type: files; Name: "{autodesktop}\Roblox FFlag Manager.lnk"

[Files]
Source: "dist\FastFlag+ Manager\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait
