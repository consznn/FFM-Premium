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
DefaultDirName={autopf}\{#MyAppName}
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
; Clean up old install directory if still present
Type: filesandordirs; Name: "{pf32}\Roblox FFlag Manager"
Type: filesandordirs; Name: "{pf}\Roblox FFlag Manager"
; Clean up old shortcuts
Type: files; Name: "{autoprograms}\Roblox FFlag Manager.lnk"
Type: files; Name: "{autodesktop}\Roblox FFlag Manager.lnk"

[Files]
Source: "dist\FastFlag+ Manager\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait

[Code]
procedure UninstallOldVersion(InstallPath: string);
var
  Uninstaller: string;
  ResultCode: Integer;
begin
  Uninstaller := InstallPath + '\unins000.exe';
  if FileExists(Uninstaller) then
  begin
    if Exec(Uninstaller, '/SILENT /NORESTART', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
      Sleep(500);
  end;
end;

function InitializeSetup: Boolean;
begin
  Result := True;
  UninstallOldVersion(ExpandConstant('{pf32}\Roblox FFlag Manager'));
  UninstallOldVersion(ExpandConstant('{pf}\Roblox FFlag Manager'));
end;
