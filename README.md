[![CI](https://github.com/bihealth/clinvar-data-jsonl/actions/workflows/main.yml/badge.svg)](https://github.com/bihealth/clinvar-data-jsonl/actions/workflows/main.yml)

# (Weekly) ClinVar Data in JSONL Format

## Following Rolling Releases

The GitHub actions for this repository follows the ClinVar XML file release on the [ClinVar FTP](https://ftp.ncbi.nlm.nih.gov/pub/clinvar/xml/weekly_release/).
A scheduled action is run every hour that:

- Checks for the latest file on the ClinVar FTP
- Checks whether a corresponding release or branch exists in this repository
- If it does then nothing else is done
- Otherwise, it will:
    - update the repository's `clinvar-releasae.txt` file in a new branch,
    - creates a pull request with this branch, and
    - set the PR to auto-merge
- The "Publish" action is run on the `main` branch and after the merge will create the corresponding release and deposit the files.

# Developer Documentation

The following is for developers of `clinvar-data-jsonl` itself.

## Managing Project with Terraform

```
# export GITHUB_OWNER=bihealth
# export GITHUB_TOKEN=ghp_TOKEN

# cd utils/terraform
# terraform init
# terraform import github_repository.clinvar-data-jsonl clinvar-data-jsonl
# terraform validate
# terraform fmt
# terraform plan
# terraform apply
```
