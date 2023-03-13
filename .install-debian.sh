curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list

apt update

apt install -y brave-browser
apt install -y \
    docker.io \
    docker-compose \
    geany \
    gnupg \
    libreoffice \
    postgresql-client \
    python3-pip \
    python3-virualenv \
    telegram-desktop
