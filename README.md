                  Backup Automation System

     A modular and reliable backup automation framework built using Bash.
     This wiki provides a complete explanation of the system, its architecture, usage, and extension points.

   1. Overview

         The Backup Automation System is designed to generate timestamped compressed backups with built-in integrity verification and comprehensive logging.
         It works on any Unix-like environment and requires no external dependencies beyond standard Linux utilities.

         The system is useful for:

       DevOps practice

       Server maintenance

       Automated scheduled backups

       Test environments

       Training projects

     2. System Architecture

   The backup automation process includes the following components:

     2.1 Backup Script

     The main automation logic resides in backup.sh.
     Its responsibilities include:

     Validating input

     Creating compressed archives

     Generating SHA-256 checksums

     Verifying backup integrity

     Logging operations

     Handling errors

     2.2 Configuration File

     backup.config allows customization of default settings.
     Supported configuration values:

     BACKUP_DIR="backups"
     LOG_FILE="backup.log"

     2.3 Output Directory

      All generated files are stored inside the backups folder:

      .tar.gz backup files

       SHA-256 hash files

       Verification results

       2.4 Logging

       All operations are appended to backup.log with timestamps and severity levels.

      3. Directory Layout
    Devops-Practice-Test/
    │
     ├── backup.sh
     ├── backup.config
     ├── backup.log
     │
     ├── backups/
     │   ├── backup-YYYY-MM-DD-HHMM.tar.gz
     │   └── backup-YYYY-MM-DD-HHMM.tar.gz.sha256
     │
     └── test_folder/

     4 . How the System Works
     Step 1: Validate Input

     The script checks whether the provided directory exists.

     Step 2: Create Archive

     The folder is compressed using tar into a .tar.gz format.

     Step 3: Generate Checksum

       A SHA-256 checksum is created to verify the integrity of the backup.

     Step 4: Validate Backup

     The script verifies the generated checksum through:

      sha256sum -c file.sha256

      Step 5: Logging

      The script logs:

      Start and end of backup

       Success messages


      Verification results

      5. Usage Guide
      5.1 Make script executable
      chmod +x backup.sh

      5.2 Run the Script
      ./backup.sh <directory_path>


      Example:

      ./backup.sh test_folder

       5.3 Output Files

        You will find inside backups/:

        backup-2025-11-03-1027.tar.gz

        backup-2025-11-03-1027.tar.gz.sha256

        Logs will be added to backup.log.

        6. Logging Details

        Log format:

       [YYYY-MM-DD HH:MM:SS] LEVEL: message


       Log levels:

       INFO

       SUCCESS

        Example log entries:

         [2025-11-03 10:30:11] INFO: Backup started
         [2025-11-03 10:30:14] SUCCESS: Backup created successfully
         [2025-11-03 10:30:15] SUCCESS: Backup verification passed
!         [Image 2025-11-03 at 16 24 31_01dc1d0e](https://github.com/user-attachments/assets/220b4e9f-0c92-4ef7-939f-2f2adf33ed5a)


         7. Verification Process

        Checksum generation:

        sha256sum backup.tar.gz > backup.tar.gz.sha256


         Verification:

          sha256sum -c backup.tar.gz.sha256


        summary:

              A professional, robust, and automated backup system built using Bash scripting that securely compresses files, validates integrity with SHA-256 checksums, and                logs every action for full traceability.

<img width="1068" height="214" alt="Screenshot 2025-11-03 180456" src="https://github.com/user-attachments/assets/5c9f4b26-6772-427e-b988-e42aa4ddb02f" />
