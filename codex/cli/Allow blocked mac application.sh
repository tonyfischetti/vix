# xattr, spctl, quarantine, security, mac, unblock application

sudo spctl --master-disable
sudo xattr -rd com.apple.quarantine /Applications/Demucs-GUI.app
# open application
sudo spctl --master-enable
