import os
import subprocess
import sys
import shutil


def build():
    print("[*] Starting FFP build...")

    # 1. Clean previous build output
    for folder in ['build', 'dist']:
        if os.path.exists(folder):
            print(f"[*] Removing old {folder} folder...")
            shutil.rmtree(folder, ignore_errors=True)

    # 2. Ensure PyInstaller is installed
    try:
        import PyInstaller
    except ImportError:
        print("[!] PyInstaller not found. Installing...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "pyinstaller"])

    # 3. Ensure required dependencies are installed
    if os.path.exists("requirements.txt"):
        print("[*] Ensuring required dependencies are installed...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])

    # 4. Define paths
    script_path = "main.pyw"
    icon_file = "ffp_v3_logo.ico"
    
    # 5. Build command
    # On Windows, path separator for --add-data is ';'
    separator = ";"
    
    cmd = [
        sys.executable,
        "-m",
        "PyInstaller",
        "--noconsole",
        "--onedir",
        f"--icon={icon_file}",
        f"--add-data=src/gui/ui{separator}src/gui/ui",
        f"--add-data=version.json{separator}.",
        f"--add-data=src/data{separator}src/data",
        f"--add-data=bg.jpg{separator}src/gui/ui",
        "--hidden-import=webview",
        "--hidden-import=pystray",
        "--hidden-import=PIL",
        "--hidden-import=requests",
        "--name=FFP",
        "--noconfirm",
        "--clean",
        script_path
    ]

    print(f"[*] Executing: {' '.join(cmd)}")
    subprocess.check_call(cmd)

    print("\n[+] Build Complete!")
    print(f"[+] Application folder: {os.path.abspath('dist/FFP')}")
    print("[+] EXE path: dist/FFP/FFP.exe")

if __name__ == "__main__":
    build()
