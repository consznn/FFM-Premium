import os, sys, json, urllib.request, zipfile, tempfile, subprocess, shutil
from pathlib import Path

OWNER = "consznn"
REPO = "FFM-Premium"
APP_NAME = "FastFlag+ Manager"
EXE_NAME = f"{APP_NAME}.exe"

def get_latest_release():
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/releases/latest"
    req = urllib.request.Request(url, headers={"User-Agent": "FFP-Bootstrapper/1.0", "Accept": "application/json"})
    with urllib.request.urlopen(req) as r:
        return json.loads(r.read())

def download_file(url, dest):
    print(f"Downloading {Path(dest).name}...")
    req = urllib.request.Request(url, headers={"User-Agent": "FFP-Bootstrapper/1.0"})
    with urllib.request.urlopen(req) as src, open(dest, "wb") as out:
        shutil.copyfileobj(src, out)

def find_asset(release):
    assets = release.get("assets", [])
    portable = None
    for a in assets:
        name = a["name"]
        if name == EXE_NAME:
            return a
        if name == f"{APP_NAME}.zip":
            portable = a
        if name.endswith(".exe") and name not in ("FFP_Installer.exe", "FFP_Setup.exe") and not portable:
            portable = a
    return portable

def main():
    target = Path(os.environ.get("LOCALAPPDATA", ".")) / APP_NAME
    exe_path = target / EXE_NAME

    print(f"Checking for updates from {OWNER}/{REPO}...")
    try:
        release = get_latest_release()
        tag = release["tag_name"]
        asset = find_asset(release)
        if not asset:
            print("No portable .exe or .zip found in latest release.")
            input("Press Enter to exit...")
            sys.exit(1)

        url = asset["browser_download_url"]
        filename = asset["name"]

        if exe_path.exists():
            print(f"Found existing {EXE_NAME}")

        target.mkdir(parents=True, exist_ok=True)

        if filename.endswith(".zip"):
            zip_path = target / filename
            download_file(url, zip_path)
            with zipfile.ZipFile(zip_path, "r") as z:
                z.extractall(target)
            os.remove(zip_path)
        else:
            download_file(url, exe_path)
            exe_path.chmod(0o755)

        print(f"\nLaunching {APP_NAME}...")
        subprocess.Popen([str(exe_path)], cwd=str(target))

    except Exception as e:
        print(f"Error: {e}")
        input("Press Enter to exit...")
        sys.exit(1)

if __name__ == "__main__":
    main()
