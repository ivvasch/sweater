#!/usr/bin/env bash

mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/