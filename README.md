# PowerShell Surgical File Restorer

A specialized PowerShell script designed to replace specific files on a "Live/Corrupted" drive with healthy versions from a "Recovery/Backup" drive.

## 🚀 Use Case
This script is ideal for scenarios like **Ransomware Recovery** or **Data Corruption**. 
Instead of a bulk restore that might create duplicates or clutter, this script reads a list of specific filenames (e.g., from a log or a specific directory export) and performs a 1-to-1 replacement **only if the file already exists on the destination**.

## 🛠 How it Works
1. **Source (Z:):** Your Backup/Recovered drive (e.g., a mounted Veeam backup).
2. **Destination (W:):** Your Live/Target drive containing the corrupted or encrypted files.
3. **The Logic:**
   - It reads a text file containing relative paths.
   - It checks if the file exists in the Source.
   - It checks if the file exists in the Destination.
   - **Crucial:** It only performs the `Copy-Item` if the file is found in **both** locations, ensuring a 100% precise replacement.

## 📋 Instructions

### 1. Prerequisites
- Create a file named `files.txt` on your desktop.
- List the relative paths of the files you wish to restore (e.g., `folder\subfolder\document.docx`).

### 2. Configuration
Open the script and modify the following variables to match your environment:
- **Paths:** Change the paths for `log.txt` and `files.txt`.
- **Drive Letters:** Adjust `$src` (Source) and `$dst` (Destination) variables.
- **Path Logic:** Adjust the `-replace` logic if your source folder structure differs from your destination.

### 3. Execution
Run the script in a PowerShell window with administrative privileges.

## ⚠️ Disclaimer
This script uses the `-Force` parameter to overwrite files. Always ensure you have a secondary backup before running mass-replacement scripts.
