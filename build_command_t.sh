#! /bin/sh

cd bundle/command-t/ruby/command-t
ruby extconf.rb
if [ `uname` = "FreeBSD" ]; then
    gmake
else
    make
fi
