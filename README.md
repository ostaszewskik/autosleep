# autosleep
A simple bash script to automatically suspend idle home server to save electricity
On Debian based system you need to add a rule to sudoers file (sudo visudo):
user ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend
