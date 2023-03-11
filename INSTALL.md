1. Под рутом:

```
apt-get install git
```

2. Под обычным пользователем:

```

cd $HOME
git init
git remote add origin https://github.com/em230418/dotfiles
git fetch
git checkout origin/master -ft

```

3. Под рутом:

```

bash .install.sh
bash .install-debian.sh  # только для Debian

```

4. Перенести .ssh
5. Перенести gpg ключи

Из другой системы

```

gpg --list-keys  # просмотреть список ключей
gpg --output private1.pgp --armor export-secret-key molotov@it-projects.info
gpg --output private2.pgp --armor export-secret-key eugene.molotov@yandex.ru
scp private*.pgp 192.168.0.300:/home/eugene
rm private*.pgp

```

Из текущей системы

```

gpg --import private*.pgp
rm private*.pgp

```
