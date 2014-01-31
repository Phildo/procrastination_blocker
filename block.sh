#!/bin/bash

HOSTS="/etc/hosts"
BAK="/etc/hosts.blocked-bak"
USAGE="`basename $0` [-f filename] [domainname ...] | [-u]"
BLOCK_BEGIN_DELIM="#BLOCK_BEGIN"
BLOCK_END_DELIM="#BLOCK_END"
TMPFILE=.BLOCK_$$_$RANDOM.tmp

error()
{
  echo "$@" >&2;
  exit 1;
}

#no permissions
if [ `whoami` != "root" ]; then
  error "must be super user (sudo $0 $@)"
fi

#no args
if [ $# -eq 0 ]; then
  error "usage: $USAGE"
fi
    
#unblock
if [ "$1" == "-u" ]; then
  if [ $# -gt 1 ]; then
    error "usage: $USAGE"
  fi
  if [ ! -f $BAK ]; then
    error "not blocked"
  fi
  cat $HOSTS | awk "BEGIN { blocking = 0 } /$BLOCK_BEGIN_DELIM/ { blocking = 1 } blocking != 1 { print } /$BLOCK_END_DELIM/ { blocking = 0 }" > $TMPFILE
  if [ "`diff $TMPFILE $BAK`" = "" ]; then
    cp $BAK $HOSTS
    rm $BAK
    rm $TMPFILE
    exit 0;
  else
    echo "unblocked hosts file does not match bak- manual correction required." >&2
    echo "BAK:" >&2
    cat $BAK >&2
    echo "Unblocked hosts file:" >&2
    cat $TMPFILE >&2
    rm $TMPFILE
    error "aborting..."
  fi
fi

#already blocked
if [ -f $BAK ]; then
  error "already blocked- aborting"
fi

#block
echo $BLOCK_BEGIN_DELIM > $TMPFILE
#from file
if [ "$1" == "-f" ]; then
  if [ $# -lt 2 ]; then
    error "usage: $USAGE"
  elif [ ! -f $2 ]; then
    error "$2: no such file found"
  fi

  cat $2 | sed "s/http:\/\///" | sed "s/www.//" | awk '{ print "127.0.0.1 " $1 "\n127.0.0.1 www." $1 }' >> $TMPFILE
  shift
  shift
fi
#from args
for a in $@; do
   echo $a | sed "s/http:\/\///" | sed "s/www.//" | awk '{ print "127.0.0.1 " $1 "\n127.0.0.1 www." $1 }' >> $TMPFILE
done
echo $BLOCK_END_DELIM >> $TMPFILE

cp $HOSTS $BAK
cat $TMPFILE >> $HOSTS

rm $TMPFILE

exit 0

