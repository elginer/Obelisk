#! /bin/sh
cd happy && ./gen.sh && cd ../ && cabal configure && cabal build
