## Problem Statement 

## Architecture Diagram

<p><h3>Prerequistes:</h3>
<ol>
  <li>1x VPC with public subnets</li>
  <li>1x ECR</li>
</ol>

## Branching Strategies:

1. Production Branch (main)
   [My repo](https://github.com/jingyang022/ce8-grp4-capstone/tree/main)
   - The main branch, also known as the master branch, represents the production-ready state of the application.
   - It contains stable and thoroughly tested code that is ready to be deployed to the live environment.
   - Only fully reviewed and approved code changes are merged into the main branch.
   - It is typically protected, meaning that direct commits or modifications are restricted, and changes can only be introduced through pull requests after thorough code review and testing.

2. Development Branch (dev)
   - The dev branch, short for development branch, serves as the primary integration branch for ongoing development work.
   - It acts as a staging area for features and bug fixes before they are merged into the main branch.
   - Developers regularly merge their completed feature branches into the dev branch for integration testing and collaboration.
   - Continuous integration practices are often implemented on the dev branch, allowing automated testing and verification of code changes.

3. Feature Branch (feature-1)
   - Feature branches are created by developers to work on specific features or bug fixes independently.
   - Each feature branch represents a self-contained task or feature development.
   - Developers work on their feature branches locally, implementing and testing their changes.
   - Once the feature is completed and tested, it is merged into the dev branch for further integration.
   - Feature branches are short-lived and are eventually deleted after merging into the dev branch to maintain a clean and manageable codebase.

## CICD Pipelines:

## Member Contributions:
| Name          | Focused Area  | 
| ------------- |:-------------:|
| Yap Jing Yang | Documentation |







