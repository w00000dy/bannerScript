#!/bin/bash

lang="en"

# Loop through all parameters
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --lang) # If the parameter --long is found
            lang="$2" # Take the next parameter as the value for long
            shift # Shift the arguments to skip the value
            ;;
    esac
    shift # Jump to the next argument
done

cd /tmp
rm -r -f /tmp/bannerScript
mkdir bannerScript
cd bannerScript/
wget https://github.com/w00000dy/bannerScript/archive/refs/heads/master.tar.gz
tar -xf master.tar.gz
cd bannerScript-master/
mv banner-$lang banner
chmod +x setup.sh
./setup.sh
