#!/bin/bash

set -x
find . -name "*.erb"| while read file ; do rm -f "${file%.erb}" ;done

