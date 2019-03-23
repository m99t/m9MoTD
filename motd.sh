#!/bin/bash
#clear
##-----------------------------------------------------------------------------------------------------#
#|                                                                                                     |
#|               __________________                   .___             __  .__                         |
#|         _____/   __   \______   \_______  ____   __| _/_ __   _____/  |_|__| ____   ____            |
#|        /     \____    /|     ___/\_  __ \/  _ \ / __ |  |  \_/ ___\   __\  |/  _ \ /    \           |
#|       |  Y Y  \ /    / |    |     |  | \(  <_> ) /_/ |  |  /\  \___|  | |  (  <_> )   |  \          |
#|       |__|_|  //____/  |____|     |__|   \____/\____ |____/  \___  >__| |__|\____/|___|  /          |
#|             \/                                      \/           \/                    \/           |
#|                                                                                                     |
##-----------------------------------------------------------------------------------------------------#
#
#                [ A attempt at a MoTD using ANSI colors and echo escape chars]
#
#                                Title   [      MoTD.sh               ]
#                                Date    [ 07 - May - 2015            ]
#                                Authors [ Sean Murphy,               ]

#Ram

hw_mem=0
free_mem=0
human=1024

mem_info=$(</proc/meminfo)
mem_info=$(echo $(echo $(mem_info=${mem_info// /}; echo ${mem_info//kB/})))
for m in $mem_info; do
        if [[ ${m//:*} = MemTotal ]]; then
                memtotal=${m//*:}
        fi

        if [[ ${m//:*} = MemFree ]]; then
                memfree=${m//*:}
        fi

        if [[ ${m//:*} = Buffers ]]; then
                membuffer=${m//*:}
        fi

        if [[ ${m//:*} = Cached ]]; then
                memcached=${m//*:}
        fi
done

usedmem="$(((($memtotal - $memfree) - $membuffer - $memcached) / $human))"
totalmem="$(($memtotal / $human))"

mem="${usedmem}MB / ${totalmem}MB"

#Hostname
hostname=$hostname

#Disk Useages
totaldisk=$(df -h --total 2>/dev/null | tail -1)
diskusedper=$(awk '{print $5}' <<< "${totaldisk}")

#ANSI colours
White="\033[01;37m"
Blue="\033[1;34m"
Green="\033[0;32m"


#{OLD} Echo message.

#echo -e "
#\a
#
#$Blue
#
#                                    ad88888ba    ad88888ba  888888888888
#                                   d8\"     \"88  d8\"     \"88      88
#                                   8P       88  8P       88      88
#               88,dPYba,,adPYba,   Y8,    ,d88  Y8,    ,d88      88
#               88P'   \"88\"    \"8a   \"PPPPPP\"88   \"PPPPPP\"88      88
#               88      88      88           8P           8P      88
#               88      88      88  8b,    a8P   8b,    a8P       88
#               88      88      88   \"Y8888P'     \"Y8888P'        88
#
#
#

# Echo message.

echo -e "
\a

$Blue

                                                                          ,,,,,,,,
                                                                ,,,,,,,,,,,,,,,,,,
                                                            ,,,,,,,,,,,,,,,,,,,,,,,
                                            ,,,,,,,,,,,    ,,,,,,,,,,,,,,,,,,,,,,,,
                                   ,,,,,,,,,,,,,,,,,,,,,   ,,,,,,,,,,,,,    ,,,,,,,
                         ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,    ,,,,,,           ,,,,,,
               ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,  ,,,,,,,           ,,,,,,
            ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,      ,,,,,,   ,,,,,,,  ,,,,,,,,,,,,,,,
            ,,,,,,,,,,,,,,,,,,,,,,,,,            ,,,,,,   ,,,,,,,,,,,,,,,,,,,,,,,,
            ,,,,,,,,,,,       ,,,,,,            ,,,,,,,   ,,,,,,,,,,,,,,,,,,,,,,,
           ,,,,,,,            ,,,,,,            ,,,,,,    ,,,,,,,,,,,,,,,,,,,,,,,
           ,,,,,,            ,,,,,,             ,,,,,,     ,,,,,,         ,,,,,,,
           ,,,,,,            ,,,,,,             ,,,,,,                    ,,,,,,,
          ,,,,,,,            ,,,,,,            ,,,,,,,                ,,,,,,,,,,
          ,,,,,,,            ,,,,,,            ,,,,,,       ,,,,,,,,,,,,,,,,,,,,
          ,,,,,,            ,,,,,,,            ,,,,,,    ,,,,,,,,,,,,,,,,,,,,,,,
          ,,,,,,            ,,,,,,            ,,,,,,,    ,,,,,,,,,,,,,,,,,,,
         ,,,,,,,            ,,,,,,            ,,,,,,,   ,,,,,,,,,,,,
         ,,,,,,,            ,,,,,,            ,,,,,,
         ,,,,,,            ,,,,,,,            ,,,,
         ,,,,,,            ,,,,,,
        ,,,,,,,
        ,,,,,,



$White
                                        This server is
                                        secured by
                                        m9Networks LLC

                                        mUID:$HOSTNAME
                                        UsedSpace: $diskusedper
                                        Free RAM: $mem
"
sleep 1
tput bel

#Reset term colour

echo -e $White
echo

