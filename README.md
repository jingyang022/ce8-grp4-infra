## 1. Problem Statement
![Current Process](/images/problem.jpg)

Agency ABC faces significant inefficiencies in processing hardcopy applications for their subsidized broadband and device scheme, primarily due to the manual data entry process done by the administrative clerks. This tedious process results in long waiting times, hinders the timely processing of claims, and lacks an automated system to ensure accuracy in data extraction. Agency ABC has engaged our team to brainstorm and build a robust and scalable solution for them.



## 2. Proposed Solution
![Architecture](/images/solution.jpg)

To address these challenges, our team aims to implement a scalable cloud solution leveraging Optical Character Recognition(OCR) technology to streamline operations, reduce processing times and improve information accuracy. Our solution will utilize AWS cloud infrastructure to implement a serverless architecture for scalability and high availability. 

After receiving the hardcopy form, the clerk will scan it and upload the image file via a website. The image goes into an S3 bucket which will trigger a Lambda function to use Amazon Textract to perform text extraction on the scanned document. Amazon Textract is a machine learning (ML) AWS service that automatically extracts text, handwriting, layout elements, and data from scanned documents.

After the extraction is completed, we will use Amazon Simple Notification Service (SNS) to notify another Lambda function to process and store the extracted data into a text file which will be saved back into the same S3 bucket. 


## 3. GITHUB Repositories

### 3.1.1 Main Project Repository
   [Project Repo](https://github.com/jingyang022/ce8-grp4-infra)
   - Holds the terraform infrastructure code and documentation for the project.
   - The main folder contains the code base for the production infrastructure and the dev folder contains the code for the dev setup.
   - The dev setup is an exact replica of the production infrastructure and is a sandbox environment to test new features.
   - Has GITHUB workflows to check the terraform code for code errors and security vulnerabilities. The detailed explanation is given in the CICD Pipelines section.

### 3.1.2 Directory Structure of the Infra Repository
   ![Infra Repo Directory Structure](/images/InfraRepo-dir-structure.jpg)

   The above diagram depicts the directory structure inside the infra repository:

   1) Root directory - contains all the terraform and python files for the production environment setup
   2) dev directory - contains all the terraform and python files for the dev environment setup
   3) workflows directory - contains all the CICD yaml files
   4) README - documentation for the entire project

### 3.2.1 Application Repository
   [App Repo](https://github.com/jingyang022/ce8-grp4-app)
   - This repo stores the image code for the container.
   - Has GITHUB workflows to build and push the Docker image to AWS ECR. The workflow will also update the container task definition inside the ECS service. The detailed explanation is given in the CICD Pipelines section.

### 3.2.1 Directory Structure of the App Repository
   ![App Repo Directory Structure](/images/AppRepo-dir-structure.jpg)

   The above diagram depicts the directory structure inside the app repository:

   1) workflows directory - contains all the CICD yaml files
   2) README - information regarding the repository
   3) Dockerfile - A script containing a series of instructions to build a Docker image. It specifies the base image, environment variables, application code, dependencies, and commands to run.
   4) app.py - the source code
   5) requirements.txt - file that contains a list of packages or libraries needed to work on a project.


## 4. Branching Strategies:

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


## 5. CICD Pipelines:

### 5.1 Infra Repository
![Infra Repo CICD diagram](/images/InfraRepo-cicd-workflow.jpg)

1. <b>prod-codecheck</b>
   - Trigger upon Pull Request open
   - Check the code (TFLint & SYNK check)

2. <b>deploy-to-prod</b>
   - Trigger upon 'push main'
   - perform Terraform init, plan & approve

### 5.2 App Repository
![App Repo CICD diagram](/images/AppRepo-cicd-workflow.jpg)

1. <b>deploy-to-dev</b>
   - trigger upon ‘push dev’
   - pull variables from github dev environment
   - Build & push image to dev ECR
   - Update container image in dev ECS

2. <b>dev-CodeCheck</b>
   - Trigger upon Pull Request open
   - SYNK scan

3. <b>deploy-to-prod</b>
   - trigger upon PR approved and merge
   - pull variables from github prod environment
   - Build & push image to prod ECR
   - Update container image in prod ECS


## 6. Member Contributions:
| Name           | Area of Responsibility                            | 
| -------------  |:--------------------------------------------------|
| Yap Jing Yang  | Documentation, Terraform & Testing, CICD workflow |
| Wong Choon Yee | Security (implement SYNK)                         |
| Yoon           | Terraform & Testing, CICD workflow                |
| Wei Xiong      | Documentation                                     |
| Ng Zi Rong     | Website enhancements                              |








