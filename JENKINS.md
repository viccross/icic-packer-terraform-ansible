# Jenkins pipeline

This provides a fancier way to run the Terraform demo -- not so terminal-janky.

## Versions
There will be two versions of the Jenkins pipeline -- one that runs on s390x, and one that runs on other architectures.
In future, if Jenkins supports architecture-dependent processing in pipelines, the different streams can be merged into a single `Jenkinsfile`.

### s390x version
Because s390x binaries for Terraform are not freely available, but mostly because the Terraform Registry does not recognise s390x as an architecture, we have to have a different workflow for s390x than other architectures where Terraform binaries are freely available.
Even building the provider locally and placing it in the correct local directory is not a solution: before Terraform checks the local directory, it consults the online Terraform Registry for available providers matching the running architecture.
The Registry returns that the provider is not available for s390x, so the Terraform binary does not consult the local directory and all `terraform` commands fail.

The workaround for this is to configure Terraform in so-called "development mode", where the call to the online Registry is bypassed.
The required configuration file (`.terraform.rc`) is generated as part of the Jenkins pipeline; if it were part of the repository it would interfere with running on x86_64 or other platforms.

So far the s390x version is the only one written.

> *Note:* because the Terraform binaries are not generally-available for s390x, they must be built separately.
  This activity is not covered by this repository.
  The Jenkins workflow here relies on Terraform binaries already being built and installed on the s390x system running the Jenkins agent (or the Jenkins host itself if running on the 'built-in' node).
  The `terraform` binary is assumed to be in the PATH of the user under which the Jenkins agent runs, while the path to the `terraform-provider-openstack` binary is currently coded in the Jenkins pipeline.

### 'Other architectures' version
On architectures where the Terraform Registry records that the OpenStack provider is available, running `terraform` works without custom configuration.
Instead of creating the "developer mode" configuration, `terraform init` can be run to download the required provider code.

This repo also contains a `tf_install.sh` script to install Terraform.
This could be used to install Terraform, however the Jenkins Terraform plugin provides its own method of installing and maintaining the Terraform binary under the control of Jenkins.

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
