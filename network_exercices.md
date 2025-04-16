

## 🔹 **Exercise 1 – View All Interfaces**

```bash
ip addr show
```

*"This command lists all network interfaces — both physical and virtual — and their status. You'll see interface names like `eth0`, `wlan0`, or `lo` for loopback. If you see `state UP` and an `inet` line, it means the interface is active and has an IP address."*

---

## 🔹 **Exercise 2 – Test Internet and Local Connectivity**

```bash
ping -c 4 192.168.1.1     # Replace with your router IP
ping -c 4 google.com
```

*"The first `ping` checks if your local network (router) is reachable — a quick way to confirm physical connectivity. The second one checks DNS resolution and external access. If DNS fails, try `ping 8.8.8.8` to test IP-level reachability."*

---

## 🔹 **Exercise 3 – Assign a Temporary Static IP**

```bash
sudo ip addr add 192.168.100.100/24 dev eth0
```

*"Here we temporarily assign a static IP using `ip addr add`. This only lasts until reboot. Replace `eth0` with your interface name — you can find it using `ip link show`. Be sure this IP doesn't conflict with another on the network!"*

Undo it:
```bash
sudo ip addr del 192.168.100.100/24 dev eth0
```

---

## 🔹 **Exercise 4 – Enable SSH Access**

```bash
sudo apt install openssh-server
sudo systemctl enable --now ssh
```

*"We install the SSH server and make sure it’s active and enabled at boot. On another machine, you can test the connection using:*

```bash
ssh username@remote_ip
```

*Replace `username` and `remote_ip` with real values."*

Check if port 22 is open:
```bash
sudo ss -tuln | grep 22
```

---

## 🔹 **Exercise 5 – Remote Command Execution**

```bash
ssh username@remote_ip 'uptime'
```

*"You don’t always need to log in interactively. With this syntax, you send a command like `uptime` or `ls` and receive the result immediately. Useful for automation and scripts."*

---

## 🔹 **Exercise 6 – Key-Based Authentication**

1. Generate the key:
```bash
ssh-keygen
```

2. Copy the public key to the remote system:
```bash
ssh-copy-id username@remote_ip
```

3. Test login:
```bash
ssh username@remote_ip
```

*"This sets up password-less login. It uses public-key cryptography. Once configured, SSH checks your identity without needing a password, improving both security and convenience."*

---

## 🔹 **Exercise 7 – Transfer a File with `scp`**

```bash
scp myfile.txt username@remote_ip:/home/username/
```

*"`scp` stands for secure copy. Here, you're sending a local file to a remote user's home directory. It's encrypted via SSH, so it's safe even over public networks."*

---

## 🔹 **Exercise 8 – Retrieve a File with `scp`**

```bash
scp username@remote_ip:/path/to/remote/file.txt ~/Downloads/
```

*"Now we reverse the direction: we’re pulling a file from the remote system to our local one. The file’s content and permissions are preserved by default."*

Use `-p` to explicitly preserve timestamps/permissions.

---

## 🔹 **Exercise 9 – Transfer a Directory Recursively**

```bash
scp -r myfolder/ username@remote_ip:/tmp/
```

*"The `-r` flag means 'recursive'. It sends the folder and everything inside it to the `/tmp/` directory of the remote system. This is useful for backups or deployments."*

---

## 🔹 **Exercise 10 – Synchronize with `rsync`**

```bash
rsync -av --delete myfolder/ username@remote_ip:/home/username/myfolder/
```

*"`rsync` is like a smarter `scp`. It copies only what's changed. The `-a` flag preserves attributes, and `-v` is for verbose output. `--delete` ensures the destination matches the source — including removing files deleted locally."*

