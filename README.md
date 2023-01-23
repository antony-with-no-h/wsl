# wsl

Import and configure a rootfs in WSL

## Usage

### Extract rootfs 

```
download-rootfs.ps1 -tag Fedora-36 -image https://dl.fedoraproject.org/pub/fedora/linux/releases/36/Container/x86_64/images/Fedora-Container-Base-36-1.5.x86_64.tar.xz
```

### Create new profile from image

```
boot.ps1 -tag Fedora-36 -name Fedora-36-001 -username bobross
```
