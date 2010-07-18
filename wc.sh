#! /bin/sh

wc `find -regex '.+\.\(hs\|y\|c\)'` | sort -n
