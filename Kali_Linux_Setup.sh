#!/bin/bash

echo "



______ _____ _   _______  ___   _____ 
|  _  \  ___| | | |  _  \/ _ \ /  ___|
| | | | |__ | | | | | | / /_\ \\ `--. 
| | | |  __|| | | | | | |  _  | `--. \
| |/ /| |___\ \_/ / |/ /| | | |/\__/ /
|___/ \____/ \___/|___/ \_| |_/\____/ 



                                       
"

if [[ $EUID -eq 0 ]]; then
    # Download Burp Suite Profesional Latet Version
    echo 'Downloading Burp Suite Professional ....'
    Link="https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar"
    wget "$Link" -O Burp_Suite_Pro.jar --quiet --show-progress
    sleep 2

    # execute Keygenerator
    echo 'Starting Keygenerator'
    (java -jar keygen.jar) &
    sleep 3s
    
    # Execute Burp Suite Professional with Keyloader
    echo 'Executing Burp Suite Professional with Keyloader'
    echo "java --illegal-access=permit -Dfile.encoding=utf-8 -javaagent:$(pwd)/loader.jar -noverify -jar $(pwd)/Burp_Suite_Pro.jar &" > burp
    chmod +x burp
    cp burp /bin/burp 
    (./burp)
else
    echo "Execute Command as Root User"
    exit
fi

