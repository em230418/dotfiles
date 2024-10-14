curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list

apt update

apt install -y brave-browser
apt install -y \
    cal \
    docker.io \
    flake8 \
    geany \
    gnupg \
    libreoffice \
    net-tools \
    postgresql-client \
    python3-pip \
    python3-virualenv \
    shadowsocks-libev

systemctl stop shadowsocks-libev
systemctl disable shadowsocks-libev
