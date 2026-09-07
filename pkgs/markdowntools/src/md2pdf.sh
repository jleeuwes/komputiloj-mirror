#!/usr/bin/env bash

set -e
set -o pipefail

pandoc -o "$(basename -- "$1" .md).pdf" "$1"
