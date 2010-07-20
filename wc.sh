#! /bin/sh

wc `find -regex '.+\.\(hs\|y\|c\|h\)'` | sort -n

