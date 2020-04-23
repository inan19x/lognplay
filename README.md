# lognplay
Small utilities to log your shell session for further audit

#!/bin/sh<br/>
#lognplay: log n play your shell session!<br/>
#utilize script(1) and scriptreplay(1), part of "util-linux" package.<br/>
#available from Linux Kernel Archive <ftp://ftp.kernel.org/pub/linux/utils/util-linux/>.<br/>
#in debian systems, require "bsdutils" package.<br/>
<br/>
Scripto Kiddo - 2011<br/>
<br/>
Usage example:<br/>
$ lognplay start &lt;session-name&gt;<br/>
Will start lognplay script as usual<br/>
  <br/>
$ lognplay stealth &lt;session-name&gt;<br/>
Will start lognplay script in hide mode<br/>
  <br/>
$ lognplay read /path/to/logfile/file-&lt;session-name&gt;.log<br/>
Will play the log of a session that previously logged<br/>
  <br/>
$ lognplay export /path/to/logfile/file-&lt;session-name&gt;.log<br/>
Will export the log of a session to a password-protected zip file<br/>
  <br/>
$ lognplay import /path/to/logfile/file-&lt;session-name&gt;.zip<br/>
Will import zip file contains a session that previously logged<br/>
