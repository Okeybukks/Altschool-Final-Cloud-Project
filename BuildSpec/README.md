# Implementing Semgrep with AWS CodeBuild
This documentation provides a guide to integrating Semgrep to AWS CloudBuild

## Prerequisite
1. An AWS Account
2. A Semgrep Account

## Usage
1. Create a `buildspec.yaml` file in the root directory of the repository to be scanned by Semgrep
2. Create an AWS CodeBuild Project which links to the repository containing the `buildspec.yaml` file then click on build. 

## Setting Up Semgrep
Semgrep has a good documentation on how to setup an account. You can click on the [link](https://semgrep.dev/docs/deployment/create-account-and-orgs/) to setup an account.

The scanning carried out by Semgrep is done using a Semgrep CI job which is added to your pipeline. This job is a pretty straight-forward one. The only information needed to get the scan report to Semgrep Project Dashboard is to create a `SEMGREP_APP_TOKEN` and add this block of code to your `buildspec.yaml` file.
```
version: 0.2

env:
  secrets-manager:
    SEMGREP_APP_TOKEN: "semgrep_token:SEMGREP_APP_TOKEN"
phases:
  install:
    runtime-versions:
      python: 3.8
    commands:
      - pip3 install semgrep
  build:
    commands:    
      - semgrep ci
```