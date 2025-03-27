## Problem Statement
![Current Process](/images/problem.jpg)

- To be added


## Proposed Solution
![Architecture](/images/solution.jpg)

- To be added


## GITHUB Repositories

1. Main Project Repository
   [Project Repo](https://github.com/jingyang022/ce8-grp4-infra)
   - Holds the terraform infrastructure code and documentation for the project.
   - Has a GITHUB workflow to check the terraform code for code errors and security vulnerabilities. Detailed explanation is given in the CICD Pipelines section.

2. Application Repository
   [App Repo](https://github.com/jingyang022/ce8-grp4-app)
   - This repo stores the image code for the container.
   - Has a GITHUB workflow to build and push the container image to AWS ECR. Detailed explanation is given in the CICD Pipelines section.


## Branching Strategies:

![Branching](/images/cicd.jpg)

1. Production Branch (main)
   - The main branch, also known as the master branch, represents the production-ready state of the application.
   - It contains stable and thoroughly tested code that is ready to be deployed to the live environment.
   - Only fully reviewed and approved code changes are merged into the main branch.
   - It is typically protected, meaning that direct commits or modifications are restricted, and changes can only be introduced through pull requests after thorough code review and testing.

2. Development Branch (dev)
   - The dev branch, short for development branch, serves as the primary integration branch for ongoing development work.
   - It acts as a staging area for features and bug fixes before they are merged into the main branch.
   - Developers regularly merge their completed feature branches into the dev branch for integration testing and collaboration.
   - Continuous integration practices are often implemented on the dev branch, allowing automated testing and verification of code changes.


## CICD Pipelines:

1. Infra Repo (infra-cicd-workflow)
   - checks the code (fmt, tfint & SYNK check)
   - do terraform init, plan & apply

2. Application Repo (app-cicd-workflow)
   - checks the code (fmt & SYNK check)
   - Push image to ECR
   - Update container task definition


## Member Contributions:
| Name           | Area of Responsibility                            | 
| -------------  |:--------------------------------------------------|
| Yap Jing Yang  | Documentation, Terraform & Testing, CICD workflow |
| Wong Choon Yee | Security (implement SYNK)                         |
| Yoon           | Terraform & Testing, CICD workflow                |
| Wei Xiong      | Documentation                                     |
| Ng Zi Rong     | Enhanced the website                              |








