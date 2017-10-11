# Copyright (C) 2014-2016  Internet Systems Consortium, Inc. ("ISC")
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

SYSTEMTESTTOP=..
. $SYSTEMTESTTOP/conf.sh

status=0
n=0

n=`expr $n + 1`
echo "I:verifying that named started normally ($n)"
ret=0
[ -s ns2/named.pid ] || ret=1
grep "unable to listen on any configured interface" ns2/named.run > /dev/null && ret=1
grep "another named process" ns2/named.run > /dev/null && ret=1
if [ $ret != 0 ]; then echo "I:failed"; fi
status=`expr $status + $ret`

if [ ! "$CYGWIN" ]; then
    n=`expr $n + 1`
    echo "I:verifying that named checks for conflicting listeners ($n)"
    ret=0
    (cd ns2; $NAMED -c named-alt1.conf -D ns2-extra-1 -X other.lock -m record,size,mctx -d 99 -g -U 4 >> named2.run 2>&1 & )
    sleep 2
    grep "unable to listen on any configured interface" ns2/named2.run > /dev/null || ret=1
    [ -s ns2/named2.pid ] && $KILL -15 `cat ns2/named2.pid`
    if [ $ret != 0 ]; then echo "I:failed"; fi
    status=`expr $status + $ret`
fi

n=`expr $n + 1`
echo "I:verifying that named checks for conflicting named processes ($n)"
ret=0
(cd ns2; $NAMED -c named-alt2.conf -D ns2-extra-2 -X named.lock -m record,size,mctx -d 99 -g -U 4 >> named3.run 2>&1 & )
sleep 2
grep "another named process" ns2/named3.run > /dev/null || ret=1
[ -s ns2/named3.pid ] && $KILL -15 `cat ns2/named3.pid`
if [ $ret != 0 ]; then echo "I:failed"; fi
status=`expr $status + $ret`

n=`expr $n + 1`
echo "I:verifying that 'lock-file none' disables process check ($n)"
ret=0
(cd ns2; $NAMED -c named-alt3.conf -D ns2-extra-3 -m record,size,mctx -d 99 -g -U 4 >> named4.run 2>&1 & )
sleep 2
grep "another named process" ns2/named4.run > /dev/null && ret=1
[ -s ns2/named4.pid ] && $KILL -15 `cat ns2/named4.pid`
if [ $ret != 0 ]; then echo "I:failed"; fi
status=`expr $status + $ret`

n=`expr $n + 1`
echo "I: checking that named refuses to reconfigure if working directory is not writable ($n)"
ret=0
cp -f ns2/named-alt4.conf ns2/named.conf
$RNDC -c ../common/rndc.conf -s 10.53.0.2 -p 9953 reconfig > rndc.out.$n 2>&1
grep "failed: permission denied" rndc.out.$n > /dev/null 2>&1 || ret=1
sleep 1
grep "[^-]directory './nope' is not writable" ns2/named.run > /dev/null 2>&1 || ret=1
if [ $ret != 0 ]; then echo "I:failed"; fi
status=`expr $status + $ret`

n=`expr $n + 1`
echo "I: checking that named refuses to reconfigure if managed-keys-directory is not writable ($n)"
ret=0
cp -f ns2/named-alt5.conf ns2/named.conf
$RNDC -c ../common/rndc.conf -s 10.53.0.2 -p 9953 reconfig > rndc.out.$n 2>&1
grep "failed: permission denied" rndc.out.$n > /dev/null 2>&1 || ret=1
sleep 1
grep "managed-keys-directory './nope' is not writable" ns2/named.run > /dev/null 2>&1 || ret=1
if [ $ret != 0 ]; then echo "I:failed"; fi
status=`expr $status + $ret`

n=`expr $n + 1`
echo "I: checking that named refuses to start if working directory is not writable ($n)"
ret=0
cd ns2
$NAMED -c named-alt4.conf -d 99 -g > named4.run 2>&1 &
sleep 2
grep "exiting (due to fatal error)" named4.run > /dev/null || ret=1
[ -s named4.pid ] && kill -15 `cat named4.pid` > /dev/null 2>&1
cd ..
if [ $ret != 0 ]; then echo "I:failed"; fi
status=`expr $status + $ret`

n=`expr $n + 1`
echo "I: checking that named refuses to start if managed-keys-directory is not writable ($n)"
ret=0
cd ns2
$NAMED -c named-alt5.conf -d 99 -g > named5.run 2>&1 &
sleep 2
grep "exiting (due to fatal error)" named5.run > /dev/null || ret=1
[ -s named5.pid ] && kill -15 `cat named5.pid` > /dev/null 2>&1
cd ..
if [ $ret != 0 ]; then echo "I:failed"; fi
status=`expr $status + $ret`

echo "I:exit status: $status"
[ $status -eq 0 ] || exit 1
