#!/bin/bash

SWAP_FILE="/var/swapfile"
SWAP_SIZE_MB=2000

install_swap() {
    echo "Creating swap file..."
    sudo dd if=/dev/zero of=$SWAP_FILE bs=1M count=$SWAP_SIZE_MB
    sudo chmod 600 $SWAP_FILE

    echo "Making swap file..."
    sudo mkswap $SWAP_FILE

    echo "Activating swap file..."
    sudo swapon $SWAP_FILE

    echo "Updating /etc/fstab..."
    echo "$SWAP_FILE   swap   swap   defaults   0   0" | sudo tee -a /etc/fstab

    echo "Swap file created and activated successfully."
    echo "You can check the result using: free -m"
}

uninstall_swap() {
    echo "Deactivating swap file..."
    sudo swapoff $SWAP_FILE

    echo "Removing swap file configuration from /etc/fstab..."
    sudo sed -i '/swapfile/d' /etc/fstab

    echo "Removing swap file..."
    sudo rm -f $SWAP_FILE

    echo "Swap file has been successfully deactivated and removed."
}

case "$1" in
    --install)
        install_swap
        ;;
    --uninstall)
        uninstall_swap
        ;;
    *)
        echo "Usage: $0 {--install|--uninstall}"
        exit 1
        ;;
esac

exit 0
