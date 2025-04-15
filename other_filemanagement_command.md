## Find all files
```bash
find / -type f
```

## Find all files 5 days old
```bash
find / -type f -mtime 5
```

### Delete file
rm <name_file>

### Secure deletion
shred -u -v -z <name_file>

### tar command

- create new archive => -c
- compress with gzip => -z
- extract data from archive => -x