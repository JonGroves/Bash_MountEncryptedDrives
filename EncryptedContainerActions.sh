# Create an encrypted folder
# Usage: createEncryptedDrive <FileName> <Size>
# Example: createEncryptedDrive encrypted.luks 32G
function createEncryptedDrive(){
	$printf "Type 'YES', and enter requested encrypted container password when requested"
	dpkg -s cryptsetup &> /dev/null #Check if cryptsetup is installed
	if [ $? -ne 0 ]; then #If cryptsetup is not installed, then:
	sudo apt install cryptsetup
	fi
	dd if=/dev/zero of=/tmp/"${1##*/}" bs=1 count=0 seek=$2 #Create empty container of requested size
	sudo cryptsetup luksFormat /tmp/"${1##*/}" #Format file as a container
	sudo cryptsetup luksOpen /tmp/"${1##*/}" "${1##*/}" #Open it
	sudo mkfs.ext4 /dev/mapper/"${1##*/}" #Format with a file system
	sudo mkdir -p /mnt/"${1##*/}"
	sudo mount /dev/mapper/"${1##*/}"  /mnt/"${1##*/}" #Mount it
	sudo chown -R $USER /mnt/"${1##*/}" #Change user to current user
}

# Open an encrypted folder
# Usage: mountEncryptedDrive <FullOrRelativeFilePath> 
# Example: mountEncryptedDrive encrypted.luks 
function mountEncryptedDrive(){
	dpkg -s cryptsetup &> /dev/null #Check if cryptsetup is installed
	if [ $? -ne 0 ]; then #If cryptsetup is not installed, then:
	sudo apt install cryptsetup
	fi
	mkdir -p /mnt/"${1##*/}"
	sudo cryptsetup luksOpen "$1" "${1##*/}" #Open it
	sudo mount /dev/mapper/"${1##*/}" /mnt/"${1##*/}" #Mount it
	dolphin /mnt/"${1##*/}" #Show folder (in KDE)
}

# Unmounts an encrypted folder
# Usage: unmountEncryptedDrive <FileName>
# Example: unmountEncryptedDrive <encrypted.luks >
function unmountEncryptedDrive(){
	sudo umount /mnt/"${1##*/}"
	sudo cryptsetup close "${1##*/}"
}
