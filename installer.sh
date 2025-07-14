#!/bin/bash
clear
echo "📦 Package Installer Script"
echo

while true; do
    read -p "Enter the package name to install (or type 'exit' to quit): " package

    if [[ "$package" == "exit" ]]; then
        echo "👋 Exiting the installer."
        break
    fi

    if [[ -z "$package" ]]; then
        echo "❌ Package name cannot be empty. Please try again."
        continue
    fi

    installed=false

    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y "$package" && installed=true
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y "$package" && installed=true
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm "$package" && installed=true
    elif command -v winget &> /dev/null; then
        winget install --silent "$package" && installed=true
    else
        echo "❌ No supported package manager found on this system."
        exit 1
    fi

    if $installed; then
        echo "✅ Package '$package' installed successfully."
    else
        echo "❌ Failed to install '$package'. It may not exist or another error occurred."
    fi

    echo
done

echo "🎉 Thank you for using the Package Installer Script!"
