# Installtion and configuration of the system
### Install git
```bash
sudo yum install git -y
```
### Add EPEL Software Repository before install nginx
```bash
sudo yum install epel-release
```
### Install nginx
```bash
sudo yum install nginx
# Enable to run in the system init
sudo systemctl enable --now nginx
```
### Install docker
[Set up the repository](https://docs.docker.com/engine/install/centos/#set-up-the-repository)
**IMPORTANT. Not run as a admin user**: [linux post install](https://docs.docker.com/engine/install/linux-postinstall/)
### Install NVM (Node version manager)
Follow steps https://github.com/nvm-sh/nvm#git-install
### v16
```bash
nvm install 16
```
### Install process viewer
```bash
sudo yum install htop
```
### Control firewall
We will use `firewall-cmd` to manage the firewall and not edit as raw the rules of iptables
[Configurar reglas del firewall](https://www.solvetic.com/tutoriales/article/3467-firewall-centos-7-configurar-habilitar-deshabilitar-crear-reglas/)
### Install fail2ban
Control the ssh logins with some rules and act if some some malicious actor wants to access. Follow [this](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-centos-7) tutorial
### SELinux
Deactivate SELinux to be more permissive the system. [Here](https://www.tecmint.com/disable-selinux-in-centos-rhel-fedora/)

# SERVER REQUIREMENTS
