#!/bin/bash

FILENAME=$1
LINES=$2


#. ./test.env
. ~gbasedbt/.bash_profile

ORACLE_HOME=/home/oracle/instantclient_21_3
ECHO=echo
INCL="-I${ORACLE_HOME}/sdk/include"
PROC="${ORACLE_HOME}/sdk/proc"
RM="rm -f"
CC="/usr/bin/gcc"
CFLAGS="-O2  -fPIC -DPRECOMP -DLINUX -D_GNU_SOURCE -D_LARGEFILE64_SOURCE=1 -D_LARGEFILE_SOURCE=1 -DSLTS_ENABLE -DSLMXMX_ENABLE -D_REENTRANT -DNS_THREADS"
LDFLAGS="-L${ORACLE_HOME} -lclntshcore -lclntsh -ldl -lm -lpthread"

FILENAME=`echo $FILENAME|awk -F"." '{print $1}'`
rm -rf $FILENAME
${PROC} ${PROCFLAGS} iname=${FILENAME}.pc
${CC} ${CFLAGS} ${INCL} -c ${FILENAME}.c
${CC} -o ${FILENAME} ${FILENAME}.o -g ${LDFLAGS} ${PROLDLIBS}


rm -f ${FILENAME}.o
rm -f ${FILENAME}.c

if [ "X$LINES" = "X" ];then
        SHOW="tail -n 18"
elif [ "X$LINES" = "X0" ];then
        SHOW="cat"
else
        SHOW="tail -n $LINES"
fi

exit 0;

