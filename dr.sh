#!/bin/bash

set -eu

git switch -c $(date +"%Y-%m-%d")
touch ./content/daily_report/$(date +"%Y-%m-%d").md


