## Terraform Chef Test Environment

This repo houses Terraform code for standing up Chef, Chef Automate, and Chef
Automate Workflow Runners all in an automated fashion. This code will stand up
the following on AWS:

* A new VPC and 3 subnets, each in different AZs
* An EIP and EIP Nat Gateway
* S3 Bucket for file transfer purposes during bootstrap
* Security groups required for Chef, Automate and Workflow Runners
* A stand-alone Chef Server
* A stand-alone Chef Automate Server
* Chef Workflow Runners (2 by default)

This is a **Work in progress!!!**, there are absolutely no setup steps
right now as I'm cleaning up code, I'm posting what I have right now
because I know some people who could use some of the code. I'll be
cleaning this up over the next few weeks and adding easy to follow
documentation to make setup a snap!

## Long term goals

* Clean everything up, make this super intuitive and easy to use
* Add Azure and Google Cloud Computing (GCP) as additional platforms to deploy to
* Keep it up to date, Automate 2.0 is just around the corner! 
