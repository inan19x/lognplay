#!/bin/sh
#lognplay: log n play your shell session!
#utilize script(1) and scriptreplay(1), part of "util-linux" package.
#available from Linux Kernel Archive <ftp://ftp.kernel.org/pub/linux/utils/util-linux/>.
#in debian systems, require "bsdutils" package.
#for fun only LOL. http://inan.tibandung.com/pub/lognplay.zip
#end of header.

#================================================================
#this is all configurations you need before using lognplay...
#================================================================

#script working directory. choose ONE suggested below.
DIRECTORY="$HOME/lognplay"
#DIRECTORY="/var/log/lognplay"

#path to script(1) tool.
LOGGING="/usr/bin/script"

#path to scriptreplay(1) tool.
PLAYING="/usr/bin/scriptreplay"

#token for log file ID. default is using date %s (seconds since 1970-01-01 00:00:00 UTC).
FILEID=$(date '+%s')

#path to zip/unzip for export/import logfiles.
#I prefer zip because it provide built-in encryption mechanism.
ZIP="/usr/bin/zip"
UNZIP="/usr/bin/unzip"

#================================================================

#check script(1) or scriptreplay(1) exist.
if [ ! -f $LOGGING ] || [ ! -f $PLAYING ];
then
	echo "WARNING: $LOGGING or $PLAYING not exist in your system. Exiting..."
exit 1
fi

#get username from shell.
USERNAME=$USER

#check args is not NULL, otherwise print usage information.
if [ ! -n "$1" ];
then
	echo "Usage: $0 [ start <session-name> | stealth <session-name> | read <logfile.log> | export <logfile.log> | import <logfile.zip> ]"
exit 1
fi

#check proper command args.
if [ $1 = "read" ] || [ $1 = "start" ] || [ $1 = "stealth" ] || [ $1 = "export" ] || [ $1 = "import" ];
then
	#check if $DIRECTORY not exist then create the $DIRECTORY.
	if [ ! -d "$DIRECTORY" ];
	then
		mkdir -p $DIRECTORY
	fi

	#if user execute "lognplay read" command.
	if [ $1 = "read" ];
	then
		echo -e "\e[31m"
		echo "$0: Playing your log file..."
		$PLAYING $DIRECTORY/.$(basename ${2%\.*}).time $2
		echo
		echo "$0: Play session ended."
		echo -e "\e[0m"
	fi

	#if user execute "lognplay start" command.
	if [ $1 = "start" ];
	then
		#check if user input second args, use it as part of log file name.
		if [ -n "$2" ];
		then
			$LOGGING -t 2>$DIRECTORY/.$USERNAME-$2-$FILEID.time $DIRECTORY/$USERNAME-$2-$FILEID.log
		else
		#else, use default file naming instead.
			$LOGGING -t 2>$DIRECTORY/.$USERNAME-session-$FILEID.time $DIRECTORY/$USERNAME-session-$FILEID.log
		fi
	fi

	#if user execute "lognplay stealth" command.
	if [ $1 = "stealth" ];
	then
		#check if user input second args, use it as part of log file name.
		if [ -n "$2" ];
		then
			#script(1) quiet start options.
			$LOGGING -q -t 2>$DIRECTORY/.$USERNAME-$2-$FILEID.time $DIRECTORY/$USERNAME-$2-$FILEID.log
		else
		#else, use default file naming instead. script(1) quiet start options.
			$LOGGING -q -t 2>$DIRECTORY/.$USERNAME-session-$FILEID.time $DIRECTORY/$USERNAME-session-$FILEID.log
		fi
	fi

	#if user execute "lognplay export" command.
	if [ $1 = "export" ];
	then
		#check if user input second args, use it as zip package name.
		if [ -n "$2" ] && [ -f "$2" ];
		then
			echo "Your logfile will be encrypted and protected..."
			$ZIP -ej $DIRECTORY/$(basename ${2%\.*}).zip $DIRECTORY/$(basename ${2%\.*}).log $DIRECTORY/.$(basename ${2%\.*}).time
		else
		#else, show "lognplay export" usage.
			echo "WARNING: File not exist or wrong syntax!"
			echo "Usage of $0 \"export\" : $0 export <logfile.log>"
		fi
	fi

	#if user execute "lognplay import" command.
	if [ $1 = "import" ];
	then
		#check if user input second args, use it as zip package name.
		if [ -n "$2" ] && [ -f "$2" ];
		then
			$UNZIP $2 -d $DIRECTORY
			echo "Log imported to $DIRECTORY/$(basename ${2%\.*}).log."
			echo "Type: \"$0 read $DIRECTORY/$(basename ${2%\.*}).log\" to play the shell session."
		else
		#else, show "lognplay import" usage.
			echo "WARNING: File not exist or wrong syntax!"
			echo "Usage of $0 \"import\" : $0 import <logfile.zip>"
		fi
	fi
exit 0
else
#else print same usage information as above.
	echo "Usage: $0 [ start <session-name> | stealth <session-name> | read <logfile.log> | export <logfile.log> | import <logfile.zip> ]"
exit 1
fi

#EOF
