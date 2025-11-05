       Automated Backup System

   A fully automated, configuration-driven Backup & Recovery System built using Bash.
   Designed with production-grade standards — featuring integrity validation, lifecycle management, checksum verification, restore workflows, dry-run mode, exclusion           patterns, and operational logging.

   This project demonstrates real-world DevOps engineering principles, including automation, reliability engineering, disaster recovery preparation, and backup rotation        strategy.

   Highlights

  * Automated full-folder backup

  * SHA-256 checksum verification

  * Corruption detection & archive integrity testing

  * Flexible configuration file (backup.config)

  * Backup retention policy (Daily | Weekly | Monthly)

  * Exclude patterns for efficient backups

  * Dry-run mode for testing operations safely

  * Safe lock mechanism to prevent duplicate processes

  * Structured logging with timestamps

  * Simple & safe restore functionality

* Architecture Overview *
  System Workflow
  flowchart LR
    A[Start Script] --> B[Load Configuration]
    B --> C{Dry Run?}
    C -->|Yes| D[Simulate Backup Process]
    C -->|No| E[Acquire Lock]
    E --> F[Check Disk Space]
    F --> G[Create Tar Archive]
    G --> H[Generate SHA-256 Checksum]
    H --> I[Verify Checksum]
    I --> J[Test Archive Integrity]
    J --> K[Apply Retention Policy]
    K --> L[Release Lock]
    L --> M[Finish]

   Project Directory Structure
Devops-Practice-Test/
│
├── backup.sh            # Core automation script
├── backup.config        # Central configuration file
├── backup.log           # Execution logs
├── backups/             # All generated backup files
└── test_folder/         # Sample backup source folder

* Configuration (backup.config) *

This file controls how the backup system behaves.

BACKUP_DESTINATION=./backups
EXCLUDE_PATTERNS=".git,node_modules,.cache"
DAILY_KEEP=7
WEEKLY_KEEP=4
MONTHLY_KEEP=3

* Explanation of Config Keys
Key	Description
BACKUP_DESTINATION	The directory where backup files will be stored
EXCLUDE_PATTERNS	Comma-separated folder/file patterns to ignore
DAILY_KEEP	Number of daily backups to retain
WEEKLY_KEEP	Number of weekly backups to retain
MONTHLY_KEEP	Number of monthly backups to retain
* Usage Guide *
 1. Create a Backup
./backup.sh <source_folder>


Example:

./backup.sh test_folder

 2. List All Available Backups
./backup.sh --list

 3. Restore a Backup
./backup.sh --restore <backup_name.tar.gz> --to <restore_path>


Example:

./backup.sh --restore backup-2025-11-05-1727.tar.gz --to ./restore_here

 4. Dry-Run Mode (Safe Simulation)
./backup.sh --dry-run test_folder

 Internal Components Explained
  1. Lock System

Prevents multiple scripts from running simultaneously:

/tmp/backup.lock


Ensures data consistency and avoids corrupt backups.

 2. Backup Creation Process

Uses tar for compression

Respects all exclude patterns

Names backups using timestamp (YYYY-MM-DD-HHMM)

 3. Data Integrity Checks

After creating a backup:

A SHA-256 file <backup>.sha256 is generated

Checksum is re-validated immediately

Archive is tested using tar -tzf

If anything fails → backup is aborted safely.

 4. Retention Policy (Lifecycle Management)

Automatically removes old backups based on:

✅ Daily
✅ Weekly
✅ Monthly

This keeps storage clean and follows real-world DR best practices.

📝 Sample Log Output
