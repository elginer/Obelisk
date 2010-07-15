#! /bin/sh
wc `find -regex '.+\.\(hs\|y\)'` | sort -n
