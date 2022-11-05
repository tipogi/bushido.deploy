# CentOS 7

This is a tutorial how to set up a bushido in a VPS

## User creation

```bash
# m: create a user folder, c: comment, s: shell type
useradd -m -c "+frostypond888" -s /bin/bash dust
# Change password of the new user
passwd dust
# Add in wheel (sudoers) group
usermod -aG wheel dust
# Disconnect from the root user and open a new ssh connection with dust (new user)
```

## Installtion and configuration of the system

The minimun applications to run the bushido.deploy container

### Locale

Configure LOCALE of the system, use the below snippet or read for more [info](https://www.cyberciti.biz/faq/failed-to-set-locale-defaulting-to-c-warning-message-on-centoslinux/)

```bash
vim /etc/environment
# Add the following lines
LANG=en_GB.utf-8
LC_ALL=en_GB.utf-8
```

### dnf

```bash
sudo yum install dnf -y
```

### System upgrade

```bash
sudo dnf upgrade
```

### SELinux

Deactivate SELinux to be more permissive the system. [Here](https://www.tecmint.com/disable-selinux-in-centos-rhel-fedora/)

### git

```bash
sudo dnf install git -y
```

### terminal

Set up the terminal interface. Install the following repositories

- [General installation](https://gist.github.com/OndrejValenta/41c4c60f837ccd56c57ba496177676b3)
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation). As theme install `agnoster`
- [auto-suggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)

### EPEL

Before start installing any librariy, install EPEL software repository, [info](https://www.cyberciti.biz/faq/installing-rhel-epel-repo-on-centos-redhat-7-x/)

```bash
sudo dnf -y install epel-release
```

### nginx

 nginx

```bash
#now install nginx
sudo dnf install nginx
# Enable to run in the system init
sudo systemctl enable --now nginx
```

### LetsEncrypt

Create lets encrypt issued certificated to secure client/server communication, [source](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-centos-7)

```bash
sudo dnf install -y epel-release mod_ssl
sudo dnf install certbot-nginx
sudo dnf install nginx
sudo systemctl start nginx
sudo vi /etc/nginx/nginx.conf
# Edit server name field with our domain 
sudo systemctl reload nginx
# IMPORTANT: If we do not open the ports, lets encrypt cannot negotiate with our server
# URL: https://letsencrypt.org/how-it-works/
sudo firewall-cmd --add-service=http
sudo firewall-cmd --add-service=https
sudo firewall-cmd --runtime-to-permanent
# Create certificate
sudo certbot --nginx -d example.com [-d www.example.com]
# Set up the crontab
sudo crontab -e
0 0 * * 1 sudo /usr/bin/certbot renew >> /var/log/sslrenew.log
```

### docker

Set up docker repository to install the docker engine. More info [here](https://docs.docker.com/engine/install/centos/#set-up-the-repository).
**IMPORTANT. Not run as a admin user**. For that we will add our user in the docker group. More info [here](https://docs.docker.com/engine/install/linux-postinstall/)
Also add the experimental features

```bash
vim /etc/docker/daemon.json
# Add the following content
{
  "features": {
    "buildkit" : true
  }
}
```

### nvm (Node version manager)

Install the library to manage different version of nodeJS. [Here](https://github.com/nvm-sh/nvm#git-install) how to install using git

```bash
# After installation, activate node the latest version. First check available versions
nvm ls-remote
nvm install 16.18.0
# Usefull commands
# Print the current nodeJS version
nvm current
# Print all nodeJS available versions
nvm ls
# Set the nodeJS version
nvm use 16.18.0
```

### Process viewer

```bash
sudo dnf install htop
```

### firewall

We will use `firewall-cmd` to manage the firewall and not edit as raw the rules of iptables
[Configurar reglas del firewall](https://www.solvetic.com/tutoriales/article/3467-firewall-centos-7-configurar-habilitar-deshabilitar-crear-reglas/)

### fail2ban

Control the ssh logins with some rules and act if some some malicious actor wants to access. Follow [this](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-centos-7) tutorial

```bash
sudo dnf install fail2ban
sudo systemctl enable fail2ban
```

## Server requirements

- At least 2GB of RAM (2048MB)
