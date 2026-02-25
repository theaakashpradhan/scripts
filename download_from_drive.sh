#!/bin/bash
set -e

# === Step 1: Install Python3 and pip if not installed ===
if ! command -v python3 &> /dev/null; then
    echo "Installing Python3..."
    sudo yum install -y python3
fi

if ! command -v pip3 &> /dev/null; then
    echo "Installing pip3..."
    sudo yum install -y python3-pip
fi

# === Step 2: Install gdown in user space ===
echo "Installing gdown..."
python3 -m pip install --user gdown

# Make sure ~/.local/bin is in PATH
export PATH=$PATH:~/.local/bin

# === Step 3: Download the tar.gz file from Google Drive ===
FILE_ID="1NY1Avs4VaSlPIkh97Y53BSU7fBwWpbzE"
OUTPUT_FILE="dags.tar.gz"

echo "Downloading dags.tar.gz..."
gdown https://drive.google.com/uc?id=$FILE_ID -O $OUTPUT_FILE

echo "Downloaded $OUTPUT_FILE successfully!"

# === Step 4: Cleanup gdown and its dependencies ===
echo "Cleaning up..."
python3 -m pip uninstall -y gdown tqdm typing-extensions upsieve urllib3
rm -f ~/.local/bin/gdown

echo "Cleanup done. Script finished!"
