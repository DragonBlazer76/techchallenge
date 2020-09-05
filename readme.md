# Servian DevOps Tech Challenge - Tech Challenge App

[license]: https://github.com/DragonBlazer76/techchallenge

## Overview

This is the Servian DevOps Tech challenge assigned to me. This repo was clone from [Servian](https://github.com/servian/TechChallengeApp) Github

## Prerequisites

Installation of the following is needed:
- [AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [Docker](https://docs.docker.com/get-docker/)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Steps
1. Clone this repo down to your local.
2. Login to your own AWS account using the AWS cli
2. Run `terraform init`
3. Run `terraform plan` to check if there is any problem
4. Run `terraform apply`. Terraform will create of the rest of infrastructure. This includes:
   - AWS ECR repo
   - AWS ECS cluster
   - Pull from ECS task with mapping of container port, memory size, cpu, etc and spin 3 of them for a start
   - Create IAM role policy
   - Create ECS service
   - Define load balancer
   - Define avaliability zone
   - Define security group
   - Define target group
   - Bind all together
Architecure diagram can be seen below:
![architecure](doc/images/my_architecture.png)
5. Build the docker image `docker build . -t techchallengeapp-repo:latest`
6. Push the image to ECR with the command with AWS command provided. File is `main.tf`
![guide](doc/images/ECR_guide.png)

## Note to evalutator
## What could have been done better
- Use some automation tool for building to code and push to ECR. As of writting, due to time constraint and no knowledge of CodeDepoly, thus I did not use.
- Have a shared credential file for AWS and variable file.(https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- Have an output.tf for output some variables like IP address
- Check out the link[link](http://test-lb-tf-729572412.ap-southeast-1.elb.amazonaws.com) for the website deployed.
