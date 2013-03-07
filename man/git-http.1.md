% GIT-HTTP(1) git-http User Manual
% Rene Moser <mail@renemoser.net>
% 2012-08-06

# NAME

Git-http - Git powered FTP client written as shell script.

# SYNOPSIS

git-http [actions] [options] [url]...

# DESCRIPTION

This manual page documents briefly the git-http program.

Git-http is a FTP client using Git to determine which local files to upload or which files should be deleted on the remote host.

It saves the deployed state by uploading the SHA1 hash in the .git-http.log file. There is no need for [Git] to be installed on the remote host.

Even if you play with different branches, git-http knows which files are different and only handles those files. No ordinary FTP client can do this and it saves time and bandwith.

Another advantage is Git-http only handles files which are tracked with [Git].

# ACTIONS

`init`
:	Initializes the first upload to remote host.

`push`
:	Uploads files which have changed since last upload.

`catchup` 
:	Uploads the .git-http.log file only. We have already uploaded the files to remote host with a different program and want to remember its state by uploading the .git-http.log file.

`show`
:	Downloads last uploaded SHA1 from log and hooks \`git show\`.

`add-scope <scope>`
:	Creates a new scope (e.g. dev, production, testing, foobar). This is a wrapper action over git-config. See **SCOPES** section for more information.

`remove-scope <scope>`
:	Remove a scope.

`help`
:	Prints a usage help.

# OPTIONS

`-u [username]`, `--user [username]`
:	FTP login name. If no argument is given, local user will be taken.

`-p [password]`, `--passwd [password]`
:	FTP password. If no argument is given, a password prompt will be shown.

`-k [[user]@[account]]`, `--keychain [[user]@[account]]`
:	FTP password from KeyChain (Mac OS X only).

`-a`, `--all`
:	Uploads all files of current Git checkout.

`-A`, `--active`
:	Uses FTP active mode.

`-s [scope]`, `--scope [scope]`
:	Using a scope (e.g. dev, production, testing, foobar). See **SCOPE** and **DEFAULTS** section for more information.

`-l`, `--lock`
:	Enable remote locking.

`-D`, `--dry-run`
:	Does not upload or delete anything, but tries to get the .git-http.log file from remote host.

`-f`, `--force`
:	Does not ask any questions, it just does.

`-n`, `--silent`
:	Be silent.

`-h`, `--help`
:	Prints some usage information.

`-v`, `--verbose`
:	Be verbose.

`-vv`
:	Be as verbose as possible. Useful for debug information.

`--syncroot`
:	Specifies a directory to sync from as if it were the git project root path.

`--insecure`
:	Don't verify server's certificate.

`--cacert <file>`
:	Use <file> as CA certificate store. Useful when a server has got a self-signed certificate. 

`--version`
:	Prints version.

# URL

The scheme of an URL is what you would expect

	protocol://host.domain.tld:port/path
	
Below a full featured URL to *host.exmaple.com* on port *2121* to path *mypath* using protocol *ftp*:

	ftp://host.example.com:2121/mypath

But, there is not just FTP. Supported protocols are:

`ftp://...`
:	FTP (default if no protocol is set)

`sftp://...`
:	SFTP

`ftps://...`
:	FTPS

`ftpes://...`
:	FTP over explicit SSL (FTPES) protocol

# DEFAULTS

Don't repeat yourself. Setting defaults for git-http in .git/config
	
	$ git config git-http.<(url|user|password|syncroot|cacert)> <value>

Everyone likes examples

	$ git config git-http.user john
	$ git config git-http.url ftp.example.com
	$ git config git-http.password secr3t
	$ git config git-http.syncroot path/dir

After setting those defaults, push to *john@ftp.example.com* is as simple as

	$ git ftp push

# SCOPES

Need different defaults per each system or environment? Use the so called scope feature.

Useful if you use multi environment development. Like a development, testing and a production environment. 

	$ git config git-http.<scope>.<(url|user|password|syncroot|cacert)> <value>

So in the case below you would set a testing scope and a production scope.

Here we set the params for the scope "testing"

	$ git config git-http.testing.url ftp.testing.com:8080/foobar-path
	$ git config git-http.testing.password simp3l

Here we set the params for the scope "production"

	$ git config git-http.production.user manager
	$ git config git-http.production.url live.example.com
	$ git config git-http.production.password n0tThatSimp3l

Pushing to scope *testing* alias *john@ftp.testing.com:8080/foobar-path* using 
password *simp3l*

	$ git ftp push -s testing

*Note:* The **SCOPE** feature can be mixed with the **DEFAULTS** feature. Because we didn't set the user for this scope, git-http uses *john* as user as set before in **DEFAULTS**.

Pushing to scope *production* alias *manager@live.example.com* using 
password *n0tThatSimp3l*

	$ git ftp push -s production

*Hint:* If your scope name is identical with your branch name. You can skip the scope argument, e.g. if your current branch is "production":

	$ git ftp push -s

You can also create scopes using the add-scope action. All settings can be defined in the URL.
Here we create the *production* scope using add-scope

	$ git ftp add-scope production ftp://manager:n0tThatSimp3l@live.example.com/foobar-path

Deleting scopes is easy using the `remove-scope` action.

	$ git ftp remove-scope production

# IGNORING FILES TO BE SYNCED

Add file names to `.git-http-ignore` to be ignored.

Ignoring all in Directory `config`:

	config/.*

Ignoring all files having extension `.txt` in `./` :

	.*\.txt

This ignores `a.txt` and `b.txt` but not `dir/c.txt`

Ingnoring a single file called `foobar.txt`:

	foobar\.txt


# EXIT CODES

There are a bunch of different error codes and their corresponding error messages that may appear during bad conditions. At the time of this writing, the exit codes are:

`1`
:	Unknown error

`2`
:	Wrong Usage

`3`
:	Missing arguments

`4`
:	Error while uploading

`5`
:	Error while downloading

`6`
:	Unknown protocol

`7`
:	Remote locked

`8`
:	Not a Git project

# KNOWN ISSUES & BUGS

The upstream BTS can be found at <http://github.com/sstur/git-http/issues>.

[Git]: http://git-scm.org
