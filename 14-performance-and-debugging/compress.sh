PARAMS="-e PVRTC --channel-weighting-perceptual --bits-per-pixel-4"

/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/texturetool $PARAMS -o "$1.pvrtc" -p "$1-Preview.png" "$1"
