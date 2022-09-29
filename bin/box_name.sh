#!/bin/bash

if [ -f ~/.box-name ]; then
  cat ~/.box-name
else
  printf hostname -s
fi
