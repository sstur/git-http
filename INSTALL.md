INSTALL
=======

Stable on Linux/Unix based systems using make
---------------------------------------------

Note: Make sure Git and cURL are installed.

This should work on Mac OS X, Debian, Ubuntu, Fedora, RedHat, etc.

The easiest way is to use Git for installing:

	$ git clone https://github.com/sstur/git-http.git
	$ cd git-http
	$ sudo make install

Updating using git

	$ git pull
	$ sudo make install


Windows
-------
There are at least two ways to install git-http on Windows.

 * Using cygwin only
 * Using cygwin and msysgit (recommended)

First install cygwin and install the package 'curl'.
If you like to use cygwin only, install package 'git',
otherwise install msysgit.

After this, open git bash (or cygwin bash for cygwin only):

	$ cd ~
	$ git clone https://github.com/sstur/git-http git-http.git
	$ cd git-http.git && chmod +x git-http
	$ cp ~/git-http.git/git-http /bin/git-http

__Important:__ Because Windows does not support symbolic links (shortcuts),
the above steps will create a copy of the git-http script in your /bin/ directory.
If you update your git-http clone, you will have to repeat the last command.

*Note: the /bin/ directory is a alias, and if you use msysgit this is the same as C:\Program Files (x86)\Git\bin\*
