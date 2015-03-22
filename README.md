# Autosleep
A simple bash script to automatically suspend idle home server to save electricity

## How it works

It measures an in/outbound network traffic and logs in given intervals. If the amount of data sent from the server don't exceeds a set limit, the server suspends itself. It's a very useful script intended to use in home servers that are not meant to be turned on constantly. 

You can 'wake' your home server using **wakeonlan** tool by typing:

	wakeonlan [server's MAC address]

And after the transmission (video streaming, file syncynig, torrent download) is ended it will suspend itself. 

## Setup

On Debian-based system you need to add a rule to sudoers file (_sudo visudo_):

	user ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend

to be able to execute te script correctly. Then setup a cron job like this:

	crontab -e
	*/15 **** sh /path/to/autosleep.sh

## License

This is just a modified version of a script I found in [Ubuntu Forums](http://ubuntuforums.org/showthread.php?t=530973&p=5195355#post5195355), originally posted by the user **vashwood**. I claim no copyright to it.