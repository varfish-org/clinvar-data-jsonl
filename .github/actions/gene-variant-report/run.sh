#!/usr/bin/bash

set -euo pipefail
set -x

mkdir -p ${OUTPUT_DIR}/gene-variant-report

df -h


clinvar-this data gene-variant-report \
    ${OUTPUT_DIR}/convert-clinvar/clinvar-full-release.jsonl.gz \
    ${OUTPUT_DIR}/gene-variant-report/gene-variant-report.jsonl.gz


cat >${OUTPUT_DIR}/gene-variant-report/spec.yaml <<EOF
dc.identifier: clinvar-this/gene-variant-report-${CLINVAR_RELEASE/-/}+$CLINVAR_THIS_VERSION
dc.title: clinvar-this gene-to-phenotype links JSONL file
dc.creator: NCBI ClinVar Team
dc.contributor:
  - VarFish Development Team
dc.format: application/x-json-lines
dc.date: $(date +%Y%m%d)
x-version: ${CLINVAR_RELEASE/-/}+$CLINVAR_THIS_VERSION
dc.description: |
  JSONL file with links between genes and phenotypes from ClinVar.
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
