#!/usr/bin/bash

set -euo pipefail
set -x

mkdir -p ${OUTPUT_DIR}/convert-clinvar

df -h


clinvar-this data xml-to-jsonl \
    ${CLINVAR_DIR}/ClinVarFullRelease_${CLINVAR_RELEASE}.xml.gz \
    ${OUTPUT_DIR}/convert-clinvar/clinvar-full-release.jsonl.gz \
    $(if [[ "$MAX_RCVS" != "" ]] && [[ "$MAX_RCVS" != "0" ]]; then \
        echo --max-records $MAX_RCVS;
    fi)


cat >${OUTPUT_DIR}/convert-clinvar/spec.yaml <<EOF
dc.identifier: clinvar-this/clinvar-data-jsonl-${CLINVAR_RELEASE/-/}+$CLINVAR_THIS_VERSION
dc.title: clinvar-this JSONL dump of ClinVar database
dc.creator: NCBI ClinVar Team
dc.contributor:
  - VarFish Development Team
dc.format: application/x-json-lines
dc.date: $(date +%Y%m%d)
x-version: ${CLINVAR_RELEASE/-/}+$CLINVAR_THIS_VERSION
dc.description: |
  JSONL file with dump of ClinVar weekly release ${CLINVAR_RELEASE},
  created using clinvar-this v${CLINVAR_THIS_VERSION}.
dc.source:
  - PMID:32461654
  - https://gnomad.broadinstitute.org/
  - https://github.com/bihealth/clinvar-this
  - https://github.com/bihealth/clinvar-data-jsonl
x-created-from:
  - name: ClinVar weekly release
    version: $CLINVAR_RELEASE
EOF


df -h
