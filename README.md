# lognplay
Small utilities to log your shell session for further audit

#!/bin/sh
#lognplay: log n play your shell session!
#utilize script(1) and scriptreplay(1), part of "util-linux" package.
#available from Linux Kernel Archive <ftp://ftp.kernel.org/pub/linux/utils/util-linux/>.
#in debian systems, require "bsdutils" package.

Scripto Kiddo - 2011

Usage example:

$ lognplay start <session-name>
Will start lognplay script as usual
  
$ lognplay stealth <session-name>
Will start lognplay script in hide mode
  
$ lognplay read /path/to/logfile/file-<session-name>.log
Will play the log of a session that previously logged
  
$ lognplay export /path/to/logfile/file-<session-name>.log
Will export the log of a session to a password-protected zip file
  
$ lognplay import /path/to/logfile/file-<session-name>.zip
Will import zip file contains a session that previously logged
