#define MyAppName "FastFlag+ Manager"
#define MyAppVersion "1.0.0"
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
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename=FFP_Installer
SetupIconFile=ffp_v3_logo.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes
AppMutex=FFlagManager_SingleInstance_Mutex

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "dist\FFP\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait
