## Lab 1 – Setting Up Your Personal Linux Workstation

### 1. System Exploration

Before touching anything, you need to understand the environment you're working in. Open your terminal and run these commands to get basic info about your system:

```bash
cat /etc/os-release     # Shows your Linux distribution
uname -r                # Kernel version
uname -m                # System architecture
```

To inspect your disk, partitions, and file systems, use:

```bash
lsblk
df -h
findmnt
blkid
```

Also, get familiar with important system directories:

```bash
ls /home     # User data
ls /etc      # Configuration files
```

Understanding these areas is key before administering any Linux system.

---

### 2. User and Permission Setup

You need to create a secondary admin user. This is standard practice so you’re not always working as root.

```bash
sudo adduser adminlocal
sudo usermod -aG sudo adminlocal
```

Now create a quick alias so you can switch easily:

```bash
echo "alias becomeadmin='sudo su - adminlocal'" >> ~/.bash_aliases
source ~/.bash_aliases
```

Now, typing `becomeadmin` takes you straight into that admin account.

---

### 3. Useful Scripts – Reusable and Parametrized

Create a personal bin folder and add it to your PATH:

```bash
mkdir -p ~/bin
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Now let’s build some scripts.

**Archive script: archive.sh**
This script takes a folder path and creates a `.tar.gz` archive.

```bash
#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: archive.sh /path/to/folder [output_name]"
  exit 1
fi

input_dir="$1"
output_name="${2:-$(basename "$input_dir")_$(date +%F)}.tar.gz"

tar -czf "$output_name" "$input_dir"
echo "Archive created: $output_name"
```

Make it executable:

```bash
chmod +x ~/bin/archive.sh
```

You can now run `archive.sh ~/Documents` from anywhere.

**System Summary Script: summary.sh**
This prints useful system info.

```bash
#!/bin/bash

echo "User: $(whoami)"
echo "Date: $(date)"
echo "Uptime: $(uptime -p)"
echo "CPU Load: $(uptime | awk -F'load average:' '{ print $2 }')"
```

---

### 4. File Management Shortcuts

Create a symbolic link:

```bash
ln -s ~/Documents ~/docs-link
```

Define a cleanup alias to delete temporary files (excluding Downloads):

```bash
echo "alias cleanup='find . -type f \\( -name \"*.tmp\" -o -name \"*.bak\" \\) ! -path \"$HOME/Downloads/*\" -delete'" >> ~/.bash_aliases
```

Now add a few useful aliases to `.bash_aliases`:

```bash
echo "alias ..='cd ..'" >> ~/.bash_aliases
echo "alias l='ls -lah'" >> ~/.bash_aliases
echo "alias docs='cd ~/Documents'" >> ~/.bash_aliases
echo "alias ports='netstat -tuln'" >> ~/.bash_aliases
echo "alias myip='hostname -I'" >> ~/.bash_aliases
source ~/.bash_aliases
```

---

### 5. Network Info and Tools

Get your IP, gateway, and DNS manually:

```bash
ip a
ip route
cat /etc/resolv.conf
```

Now define a quick alias:

```bash
echo "alias netinfo='echo IP: $(hostname -I); ip route | grep default; grep nameserver /etc/resolv.conf'" >> ~/.bash_aliases
```

Create a function called `pingdns` to check connectivity and log it:

```bash
echo '
pingdns() {
  ping -c 2 1.1.1.1 >> ~/ping.log
  ping -c 2 8.8.8.8 >> ~/ping.log
  echo "Ping results saved to ~/ping.log"
}' >> ~/.bash_aliases
```

Run `source ~/.bash_aliases` to load it all.

---

## Lab 2 – Build Your Own Admin Toolkit

### 1. Startup Script

Create a script called `startup.sh` that does a few checks at login.

```bash
#!/bin/bash

welcome() {
  echo "Welcome back, $USER"
  echo "Date: $(date)"
}

check_connection() {
  ping -c 1 google.com &> /dev/null
  if [ $? -eq 0 ]; then
    echo "Internet: OK"
  else
    echo "Internet: Not connected" >&2
  fi
}

recent_docs() {
  echo "Recent files in ~/Documents:"
  find ~/Documents -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -n 3 | cut -d' ' -f2-
}

{
  welcome
  check_connection
  recent_docs
} 2>&1 | tee ~/startup.log
```

Make it executable:

```bash
chmod +x ~/startup.sh
```

---

### 2. Backup Script with Auto-Cleanup

Create `save.sh` to back up `~/Documents` and auto-delete old archives:

```bash
#!/bin/bash

backup_dir="$HOME/Backups"
mkdir -p "$backup_dir"

filename="Documents_$(date +%F_%H%M).tar.gz"
tar -czf "$backup_dir/$filename" ~/Documents

echo "Backup created: $backup_dir/$filename"
echo "Size: $(du -h "$backup_dir/$filename" | cut -f1)"

# Remove backups older than 7 days
find "$backup_dir" -type f -name "*.tar.gz" -mtime +7 -delete
```

---

### 3. Folder Setup and Links

Set up a simple working structure:

```bash
mkdir -p ~/workspace/{web,admin,notes}
cd ~/workspace/notes
touch note1.txt note2.txt
ln note1.txt hardlink_to_note1.txt
ln -s ~/Downloads downloads_link
```

---

### 4. Useful Shell Functions

Add a live folder watcher:

```bash
watchfolder() {
  dir="$1"
  echo "Watching: $dir"
  old=$(ls "$dir")
  while true; do
    sleep 5
    new=$(ls "$dir")
    diff <(echo "$old") <(echo "$new") | grep '>' | sed 's/> //'
    old="$new"
  done
}
```

Add a simple search command:

```bash
searchtext() {
  if [ -z "$1" ]; then
    echo "Usage: searchtext 'search term'"
    return 1
  fi
  grep -i "$1" *.txt 2>/dev/null | sort > found.txt
  echo "Results saved to found.txt"
}
```

You can paste those into your `.bashrc` or `.bash_aliases`.
