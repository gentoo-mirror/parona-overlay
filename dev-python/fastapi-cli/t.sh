#!/usr/bin/env bash

sed \
	-e 's/"-m", "coverage", "run",//' \
	-e 's/-m coverage run//' \
	-e '/"-m",/ {
			N
			N
			s/"-m",\n.*"coverage",\n.*"run",//
	}' test_sub_help.py

#		/sys.executable,/,/"typer",/ {
#			/"-m",/,/"run",/d
			#s/"-m",\n.*"coverage",\n.*"run",\n//
