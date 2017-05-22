#!/bin/bash
#$>> _
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;35m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;35m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;35m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

PROCCOUNT=`ps -Afl | wc -l`

read one five fifteen rest < /proc/loadavg


clear

echo -e "                   \033[32mWelcome in \033[0;37m`hostname`\033[32m's Server!"
echo -en "\033[1;32m
\033[0;35m+++++++++++++++++++++++++: \033[0;37m${undylw}System Data\033[0;35m :++++++++++++++++++++++++++++
+\033[0;37m Hostname    \033[0;35m =  \033[1;32m`hostname`
\033[0;35m+ \033[0;37mAddress     \033[0;35m =  \033[1;32m`ifconfig | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}' | awk '{if( NR == 1 )print $1}'`
\033[0;35m+ \033[0;37mOS          \033[0;35m =  \033[1;32m`cat /etc/redhat-release`
\033[0;35m+ \033[0;37mKernel      \033[0;35m =  \033[1;32m`uname -r`
\033[0;35m+ \033[0;37mUptime      \033[0;35m =\033[1;32m`uptime | awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print}'`
\033[0;35m+ \033[0;37mLoad         \033[0;35m=  \033[1;32m${one}, ${five}, ${fifteen} (1, 5, 15 min)
\033[0;35m+ \033[0;37mCPU          \033[0;35m=  \033[1;32m`cat /proc/cpuinfo |grep "model name" | wc -l`x`cat /proc/cpuinfo |grep "model name" | awk '{if( NR == 1 )print $0}' | cut -d: -f2`
\033[0;35m+ \033[0;37mMemory      \033[0;35m =  \033[1;32m`cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
\033[0;35m+ \033[0;37mSwap        \033[0;35m =  \033[1;32m`cat /proc/meminfo | grep SwapTotal | awk {'print $2'}`kB (SwapTotal) / `cat /proc/meminfo | grep SwapFree | awk {'print $2'}`kB (SwapFree)
\033[0;35m+ \033[0;37mProcesses    \033[0;35m=  \033[1;32m$PROCCOUNT of `ulimit -u` MAX
\033[0;35m+ \033[0;37mSessions     \033[0;35m=  \033[1;32m`who | grep $USER | wc -l` of $ENDSESSION MAX
\033[0;35m+++++++++++++++++++++++++: \033[0;37m${undylw}User Data\033[0;35m :++++++++++++++++++++++++++++++
+ \033[0;37mUsername     \033[0;35m=  \033[1;32m`whoami`
\033[0;35m+ \033[0;37mAdmin        \033[0;35m=  \033[1;32msyslnx @ istanbul.net
\033[0;35m++++++++++++++++++: \033[0;37m${undred}Maintenance Information\033[0;35m :+++++++++++++++++++++++
 "
maint=`cat /etc/motd`
if  [ "${maint}" = "Nothing to report!" ]
then echo -e "${txtgrn}Nothing to report!"
else echo -e "${txtred}${maint}"
fi
echo -e "\033[0;35m++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"
echo ""

