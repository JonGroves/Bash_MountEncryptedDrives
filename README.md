# Bash_MountEncryptedDrives
Automates the creation, opening, and closing of encrypted containers (LUKS).

## Usage:
- Copy the contents of EncryptedContainerActions.sh into ~/.bash_aliases
- Restart your terminal/console

## Create an encrypted folder
### Usage:
createEncryptedDrive \[FileName\] \[Size\]
### Example:
createEncryptedDrive encrypted.luks 32G
### Note:
\[Size\] can be in kB=1000 bytes, K=1024, MB=1000x1000, M=1024x1024, GB=1000x1000x1000, G=1024x1024x1024, and so on for T, P, E, Z, Y.

## Open an encrypted folder
### Usage:
mountEncryptedDrive \[FullOrRelativeFilePath\]
### Example:
mountEncryptedDrive ~\user\encrypted.luks 


## Unmounts an encrypted folder
### Usage:
unmountEncryptedDrive \[FileName\]
### Example:
unmountEncryptedDrive \[encrypted.luks\]
