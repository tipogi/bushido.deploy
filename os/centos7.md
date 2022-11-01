# Installtion and configuration of the system
### git
```bash
sudo yum install git -y
```
### nginx
Add EPEL Software Repository before install nginx
```bash
sudo yum install epel-release
#now install nginx
sudo yum install nginx
# Enable to run in the system init
sudo systemctl enable --now nginx
```
### docker
Set up docker repository to install the docker engine. More info [here](https://docs.docker.com/engine/install/centos/#set-up-the-repository).
**IMPORTANT. Not run as a admin user**. For that we will add our user in the docker group. More info [here](https://docs.docker.com/engine/install/linux-postinstall/)
### NVM (Node version manager)
Install the library to manage different version of nodeJS. [Here](https://github.com/nvm-sh/nvm#git-install) how to install using git
```bash
# After installation, activate node 16 version
nvm install 16
```
### firewall
We will use `firewall-cmd` to manage the firewall and not edit as raw the rules of iptables
[Configurar reglas del firewall](https://www.solvetic.com/tutoriales/article/3467-firewall-centos-7-configurar-habilitar-deshabilitar-crear-reglas/)
### fail2ban
Control the ssh logins with some rules and act if some some malicious actor wants to access. Follow [this](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-centos-7) tutorial
### Process viewer
```bash
sudo yum install htop
```
### SELinux
Deactivate SELinux to be more permissive the system. [Here](https://www.tecmint.com/disable-selinux-in-centos-rhel-fedora/)

# Server requirements
