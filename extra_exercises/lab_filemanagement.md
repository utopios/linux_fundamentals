# 🧪 **Linux Fundamentals – Advanced File Management Lab**

---

## 🎓 **Scenario**

You are a junior Linux system administrator.

Your team uses the `/srv/projects/` directory to store logs, temporary files, and scripts from multiple users.

Your mission is to:
- Inspect and clean the directory
- Apply the correct permissions and ownerships
- Archive old logs
- Securely delete sensitive data
- Use advanced `find`, `ls`, `chmod`, `chown`, `stat`, `tar`, and `shred` commands
- Practice using `-exec {} \;` and `-exec {} +`

---

## 🧰 **Lab Setup – Preparation Commands (Instructor Only)**

> 💡 Run the following commands before the lab to simulate a working project directory.

```bash
sudo mkdir -p /srv/projects
sudo chown "$USER:$USER" /srv/projects
cd /srv/projects

# Simulate old .log files (March 2024)
touch -t 202403010101 file1.log
touch -t 202403080101 file2.log
touch -t 202403150101 file3.log

# Create large files (~100MB+)
dd if=/dev/zero of=bigfile1.tmp bs=1M count=110
dd if=/dev/zero of=bigfile2.tmp bs=1M count=120

# Create a confidential file with insecure permissions
echo "secret data" > password.txt
chmod 777 password.txt

# Add a debug temp file
echo "temporary debug info" > debug.tmp
chmod 777 debug.tmp

# Add a shell script
echo -e '#!/bin/bash\necho Hello' > cleanup.sh
chmod 644 cleanup.sh
```

---

## 📂 **PART 1: File Analysis and Inspection**

1.1 List all files in `/srv/projects/` with detailed information, sorted by size (largest to smallest), and display human-readable sizes.

```bash
ls -lhS /srv/projects/
```  

1.2 List all files sorted by modification time, oldest first.

```bash
ls -lhtr /srv/projects/
``` 

1.3 Display the real file type of each file using content analysis, not file extensions.

```bash
find *
``` 

---

## 🔐 **PART 2: Permission and Access Management**

2.1 Change the permissions of `password.txt` so only the file owner can read and write it.  
```bash
chmod 600 password.txt
``` 
2.2 Find all `.sh` files in the directory and make them executable only by their owner.

```bash
find . -type f -name "*.sh" -exec chmod 700 {} \;
```

---

## 🔎 **PART 3: Filtering and Cleanup**

3.1 Find and list all files larger than 100 MB in `/srv/projects`. 

```bash
find . -type f -size +100M -exec ls -lh {} \;
```

3.2 Find and list all files older than 7 days.

```bash
find . -type f -mtime +7 -exec ls -lh {} \;
```

---

## 📦 **PART 4: Archiving**

4.1 Archive all `.log` files that are older than 7 days into a gzip-compressed archive.  
 ➤ Save the archive in a `~/backups/` folder named `old_logs_<today’s date>.tar.gz`.

```bash
mkdir Backups
find . -type f -name "*.log" -mtime +7 -exec tar -czvf /srv/projects/backups/old_logs_$(date +%F).tar.gz {} +
```

---

## 🧹 **PART 5: Secure Deletion**

5.1 Securely delete the `password.txt` file by overwriting its content before removing it.

```bash
shred -u -v -z password.txt
```

---

## 📊 **PART 6: Reporting and Ownership**

6.1 Display metadata (size, timestamps, inode number, etc.) for each `.log` file using a command-line tool.  
6.2 Count how many files in `/srv/projects/` are owned by your current user.

