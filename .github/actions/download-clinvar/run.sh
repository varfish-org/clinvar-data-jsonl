#!/usr/bin/bash

set -euo pipefail
set -x

mkdir -p $CLINVAR_DIR

export TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT ERR

df -h

# Check that the release name corresponds to the date of the current weekly release.

curl https://ftp.ncbi.nlm.nih.gov/pub/clinvar/xml/weekly_release/ \
> /tmp/lst.html

grep 'latest_weekly.xml.gz"' /tmp/lst.html \
| head -n 1 \
| cut -d '>' -f 21- \
| cut -d '<' -f 1 \
| cut -d ' ' -f 1 \
| tr -d '-' \
> /tmp/release-name.txt

if ! diff /tmp/release-name.txt release-name.txt >/dev/null; then
    >&2 echo "Difference in release names"
    >&2 diff /tmp/release-name.txt release-name.txt
    exit 1
fi

# Actually download the file

wget -O $CLINVAR_DIR/ClinVarVCVRelease_00-latest_weekly.xml.gz \
    https://ftp.ncbi.nlm.nih.gov/pub/clinvar/xml/weekly_release/ClinVarVCVRelease_00-latest_weekly.xml.gz

df -h
