; Script generated by the Inno Setup Script Wizard.
; Make by CairoLee

#define LeeAppName "LeeClient"
#define LeeAppVersion "1.0.0"
#define LeeAppPublisher "rAthenaCN, Inc."
#define LeeAppURL "https://rathena.cn/"
#define LeeAppExeName "2017-06-14bRagexeRE_patched.exe"
#define LeePackageSourceDirPath "..\..\..\..\LeeClient_Release_20181003_234134"
#define LeeDefaultGroupName "LeeClient StartMenu Group"
#define LeeOutputBaseFilename "Setup"
#define LeeGameSetupName "GameSetup"  
#define LeeGameSetupExeName "setup.exe"
#define LeeDefaultDirName "LeeClient"
#define LeeAppId "{{55A9D5FA-FA24-4AF1-B9A5-B65542662632}"
#define LeeResourceDirPath "..\Resources"
#define LeeOutputDir ".\Output"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={#LeeAppId}
AppName={#LeeAppName}
AppVersion={#LeeAppVersion}
;AppVerName={#LeeAppName} {#LeeAppVersion}
AppPublisher={#LeeAppPublisher}
AppPublisherURL={#LeeAppURL}
AppSupportURL={#LeeAppURL}
AppUpdatesURL={#LeeAppURL}
DefaultDirName={pf}\{#LeeDefaultDirName}
DefaultGroupName={#LeeDefaultGroupName}
DisableProgramGroupPage=yes
OutputBaseFilename={#LeeOutputBaseFilename}
; Compression=lzma
Compression=none
SolidCompression=no
; SolidCompression=yes
DiskSpanning=yes
DiskSliceSize=736000000
LicenseFile={#LeeResourceDirPath}\Licences\SetupLicence.txt
OutputDir={#LeeOutputDir}

[Languages]
Name: "ChineseSimplified"; MessagesFile: "{#LeeResourceDirPath}\Languages\ChineseSimplified.isl"
Name: "ChineseTraditional"; MessagesFile: "{#LeeResourceDirPath}\Languages\ChineseTraditional.isl"
Name: "English"; MessagesFile: "{#LeeResourceDirPath}\Languages\English.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Files]
Source: "{#LeePackageSourceDirPath}\AI\*"; DestDir: "{app}\AI\"; Flags: ignoreversion skipifsourcedoesntexist 
Source: "{#LeePackageSourceDirPath}\AI\USER_AI\*"; DestDir: "{app}\AI\USER_AI\"; Flags: ignoreversion skipifsourcedoesntexist
Source: "{#LeePackageSourceDirPath}\AI_sakray\*"; DestDir: "{app}\AI_sakray\"; Flags: ignoreversion skipifsourcedoesntexist 
Source: "{#LeePackageSourceDirPath}\AI_sakray\USER_AI\*"; DestDir: "{app}\AI_sakray\USER_AI\"; Flags: ignoreversion skipifsourcedoesntexist
Source: "{#LeePackageSourceDirPath}\BGM\*"; DestDir: "{app}\BGM\"; Flags: ignoreversion 
Source: "{#LeePackageSourceDirPath}\SaveData\*"; DestDir: "{app}\SaveData\"; Flags: ignoreversion  
Source: "{#LeePackageSourceDirPath}\System\*"; DestDir: "{app}\System\"; Flags: ignoreversion 
Source: "{#LeePackageSourceDirPath}\System\Font\*"; DestDir: "{app}\System\Font\"; Flags: ignoreversion
Source: "{#LeePackageSourceDirPath}\System\LuaFiles514\*"; DestDir: "{app}\System\LuaFiles514\"; Flags: ignoreversion
Source: "{#LeePackageSourceDirPath}\*"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[UninstallDelete]
Type: filesandordirs; Name: "{app}\data"
Type: filesandordirs; Name: "{app}\memo"
Type: filesandordirs; Name: "{app}\Replay"
Type: filesandordirs; Name: "{app}\Navigationdata"

[Icons]
Name: "{group}\{#LeeAppName}"; Filename: "{app}\{#LeeAppExeName}"
Name: "{group}\{#LeeGameSetupName}"; Filename: "{app}\{#LeeGameSetupExeName}"
Name: "{group}\{cm:UninstallProgram,{#LeeAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#LeeAppName}"; Filename: "{app}\{#LeeAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#LeeAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(LeeAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent