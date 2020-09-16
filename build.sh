#!/usr/bin/env sh

# Install required packages
sudo dnf install -y "git" "wget" "openssl-static" "npm" "qt5-qtbase" "qt5-qtbase-devel" "qt5-qtmultimedia-devel" "qt5-qtscript-devel" "qscintilla-qt5-devel" "qt5-linguist" "gcc-c++" "cmake" "make" --best

# Get Source
cd ~/Downloads
git clone --recursive "https://github.com/Bionus/imgbrd-grabber"
cd ~/Downloads/imgbrd-grabber/

# Build the project in the build directory
./scripts/build.sh gui translations

# Move the built binary to the release folder with its config
./scripts/package.sh "release"
cp -r src/dist/linux/* "release"

# Finalizing
echo "Installing to /opt/"
cd ~/Downloads/imgbrd-grabber
wget "https://raw.githubusercontent.com/Bionus/imgbrd-grabber/master/src/gui/resources/images/readme-icon.png"
cp -av ~/Downloads/imgbrd-grabber/release ~/Downloads/imgbrd-grabber/Grabber
cp -av ~/Downloads/imgbrd-grabber/readme-icon.png ~/Downloads/imgbrd-grabber/icon.png
sudo cp -av ~/Downloads/imgbrd-grabber/Grabber /opt/
sudo cp -av ~/Downloads/imgbrd-grabber/icon.png /opt/Grabber/
cd /opt/Grabber
sed -i /Exec=Grabber/c\Exec=/opt/Grabber/Grabber /opt/Grabber/Grabber.desktop
sed -i /Icon=Grabber/c\Icon=/opt/Grabber/icon.png /opt/Grabber/Grabber.desktop
sudo cp -av /opt/Grabber/Grabber.desktop /usr/share/applications/
sudo update-desktop-database
echo "Installation Completed"
