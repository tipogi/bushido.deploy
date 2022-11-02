# Installtion and configuration of the system
### Locale
Configure LOCALE of the system, use the below snippet or read for more [info](https://www.cyberciti.biz/faq/failed-to-set-locale-defaulting-to-c-warning-message-on-centoslinux/)
```bash
vim /etc/environment
# Add the following lines
LANG=en_GB.utf-8
LC_ALL=en_GB.utf-8
```
### dnf
```
sudo yum install dnf -y
```
### System upgrade
```bash
sudo dnf upgrade
```
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
sudo yum install epel-release
#now install nginx
sudo dnf install nginx
# Enable to run in the system init
sudo systemctl enable --now nginx
```
### docker
Set up docker repository to install the docker engine. More info [here](https://docs.docker.com/engine/install/centos/#set-up-the-repository).
**IMPORTANT. Not run as a admin user**. For that we will add our user in the docker group. More info [here](https://docs.docker.com/engine/install/linux-postinstall/)
### nvm (Node version manager)
Install the library to manage different version of nodeJS. [Here](https://github.com/nvm-sh/nvm#git-install) how to install using git
```bash
# After installation, activate node the latest version. First check available versions
nvm ls-remote
nvm install 16.18.0
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
### SELinux
Deactivate SELinux to be more permissive the system. [Here](https://www.tecmint.com/disable-selinux-in-centos-rhel-fedora/)







# Server requirements
