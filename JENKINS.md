# Jenkins pipeline

This provides a fancier way to run the Terraform demo -- not so terminal-janky.

## Versions
There will be two versions of the Jenkins pipeline -- one that runs on s390x, and one that runs on other architectures.
Because s390x binaries for Terraform are not freely available, and the Terraform registry does not recognise s390x as an architecture, we have to have a different workflow for s390x than other architectures where Terraform binaries are freely available.

So far the s390x version is the only one written.

## Steps performed by the pipeline
0. Accept parameter (apply or destroy)
1. Sync the repo
2. For `s390x`: Set up the provider code -- generate `.terraform.rc` to configure "developer mode" and point to local provider build
   
   For other architecures: run `terraform init`
3. Run `terraform plan`
   Currently no `-out` option is used, but this may change
4. Run `terraform` according to desired action
5. If action is apply:
   - Run the Ansible playbook to configure HAProxy
   - Run the script to find out the z/VM IDs of the generated users

## Current status
It works!
The pipeline is parameterised, allowing the choice between "apply" and "destroy".
When "apply" is chosen, the Ansible HAProxy configuration playbook and the z/VM ID determination script run as additional stages after Terraform.

## TO-DO
- Make the non-s390x version
- Add extra tasks into the demo, for better visualisation:
  - Create a web page with a status diagram (e.g. some of the SVG charts Terraform can create)
  - Improve the PHP page (make it more than just `phpinfo()`)
