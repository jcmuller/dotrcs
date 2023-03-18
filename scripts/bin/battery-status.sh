#!/bin/bash

for i in $(upower -e | grep 'BAT')
do
  upower -i $i | grep -E "path|state|to\ full|percentage|time"
done
