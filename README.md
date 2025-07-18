# Github-Action-Project-4

## Lesson 1: Introduction to Deployment Pipelines

## Objectives:
- Define and understand the stages of a deployment pipeline.
- Learn about different deployment strategies.

## Lesson Details:

1. Defining Deployment Stages:
- Development: Writing and testing code in a local environment.
- Integration: Merging code changes to a shared branch.
- Testing: Running automated tests to ensure code quality.
- Staging: Deploying code to a production-like environment for final testing.
- Production: Releasing the final version of your code to the end-users.

2. Understanding Deployment Strategies:
- Blue-Green Deployment: Running two production environments, only one of which serves end-users at any time.
- Canary Releases: Rolling out changes to a small subset of users before full deployment.
- Rolling Deployment: Gradually replacing instances of the previous version of an application with the new version.


## Lesson 2: Automated Releases and Versioning

## Objectives:
- Automate versioning in the CI/CD process.
- Create and manage software releases.

## Automating Versioning in CI/CD:

1. Semantic Versioning:
- Use semantic versioning (SemVer) for your software. It uses a three-part version number, for example, "MAJOR.MINOR.PATCH".
- Resource: Semantic Versioning.

2. Automated Versioning with GitHub Actions:
- Implement automated versioning using GitHub Actions to increment version numbers automatically based on code changes.

## Example snippet for a versioning script in GitHub Actions:

```
name: Bump version and tag
on:
  push:
    branches:
      - main

jobs:
  build:
    name: Create Tag
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        # The checkout action checks out your repository under $GITHUB_WORKSPACE, so your workflow can access it.

      - name: Bump version and push tag
        uses: anothrNick/github-tag-action@1.26.0
        env:
          GITHUB_TOKEN: ${{" secrets.GITHUB_TOKEN "}}
          DEFAULT_BUMP: patch
        # This action automatically increments the patch version and tags the commit.
        # 'DEFAULT_BUMP' specifies the type of version bump (major, minor, patch).


```
### This action will automatically increment the patch version and create a new tag each time changes are push to the main branch

## Creating and managing releases

### 1. Automating release with Github Action

- Set up Github Action to create a new release  whenever a new tag is push to the repository. 

- Example snippet to create a release

```
on:
  push:
    tags:
      - '*'

jobs:
  build:
    name: Create Release
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        # Checks out the code in the tag that triggered the workflow.

      - name: Create Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{" secrets.GITHUB_TOKEN "}}
        with:
          tag_name: ${{" github.ref "}}
          release_name: Release ${{" github.ref "}}
          # This step creates a new release in GitHub using the tag name.
```

### The `actions/create-release@v1` action is use to create a release on Github. It uses the tag that triggered the workflow to name and label the release.


## Troubleshooting and Additional Resources:

- For troubleshooting GitHub Actions, the GitHub Actions Documentation is an invaluable resource.
- To resolve issues related to specific actions used in your workflow, refer to their respective repositories on GitHub or their documentation.
- For general questions and community support, the GitHub Community Forum can be a great place to seek help.
- Remember, reading through the logs generated by GitHub Actions can provide insights into what might be going wrong with your workflows.

## Lesson 3: Deploying to Cloud Platforms

## Objectives:

- Deploy applications to popular cloud platforms using GitHub Actions.
- Configure deployment environments.

## Lesson Details:

## Detailed Guide: Deploying Applications to Cloud Platforms with GitHub Actions

### For beginners completely new to GitHub Actions and cloud deployment, it's essential to understand the process step-by-step. Here's a detailed breakdown of deploying applications to cloud platforms like AWS, Azure, or Google Cloud Platform using GitHub Actions:

## Step 1: Choose a Cloud Platform

- Decide on a cloud platform based on your project requirements. Each platform (AWS, Azure, Google Cloud) has its own set of services and pricing models.

  - AWS: Amazon Web Services
  - Azure: Microsoft Azure
  - Google Cloud Platform: GCP


## Step 2: Set Up GitHub Actions for Deployment

1. Creating the Workflow File:
   • Workflow files are YAML files stored in your repository’s `.github/workflows` directory.
   • Start by creating a file, e.g., `deploy-to-aws.yml` in this directory.

2. Defining the Workflow:
   • A workflow is defined with a series of steps that run on specified events.

## Example for AWS Deployment:

name: Deploy to AWS
on:
  push:
    branches:
      - main
  # This workflow triggers on a push to the 'main' branch.

```
jobs:
  deploy:
    runs-on: ubuntu-latest
    # Specifies the runner environment.

    steps:
    - name: Checkout code
      uses: actions/checkout@v2
      # Checks out your repository under $GITHUB_WORKSPACE.

    - name: Set up AWS credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{" secrets.AWS_ACCESS_KEY_ID "}}
        aws-secret-access-key: ${{" secrets.AWS_SECRET_ACCESS_KEY "}}
        aws-region: us-west-2
      # Configures AWS credentials from GitHub secrets.

    - name: Deploy to AWS
      run: |
        # Add your deployment script here.
        # For example, using AWS CLI commands to deploy.
```

### This workflow deploys your application to AWS when changes are pushed to the main branch


### Step 3: Configuring Deployment Environments

1. Setting Up Environment Variables and Secrets:
   - Store sensitive information like API keys and access tokens as GitHub Secrets.
   - Use environment variables for non-sensitive configuration.

2. Environment-Specific Workflow:
   - Tailor your workflow for different environments (development, staging, production) by using conditions or different workflow files.

## Additional Resources:
   - GitHub Actions Documentation: For a comprehensive understanding, refer to the official documentation.
   - AWS GitHub Actions: Learn more about the AWS actions available on GitHub.
   - Azure GitHub Actions: Check out Azure actions.
   - Google Cloud GitHub Actions: Explore Google Cloud actions.

## Troubleshooting:
   - Review action logs in GitHub for errors during execution.
   - Ensure that your cloud platform credentials are correctly set up in GitHub Secrets.
   - Validate your YAML file for syntax errors using online validators like YAML Lint.


## Steps to Deploying to AWS EC2 Instance

### STEP 1: Prepare Your EC2 Instance

### Connect to EC2:

`ssh -i your-key.pem ubuntu@your-ec2-public-ip`

## On the EC2 instance:

### Install Node.js (v18)
`curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -`

`sudo apt install -y nodejs`

### Install PM2 to manage your app

`sudo npm install -g pm2`

### Create a folder for your app

`mkdir -p ~/github-app && cd ~/github-app`

### You can manually `git clone` the repo the first time, but the pipeline will auto-pull updates later.


## STEP 2: Add GitHub Secrets

### Go to your repo → Settings → Secrets and variables → Actions → New repository secret

### Add the following:

 # 🚀 Node.js CI/CD with GitHub Actions — Deploy to AWS S3 and EC2

This repository uses a GitHub Actions workflow to:

- Run matrix builds for multiple Node.js versions and environments
- Perform linting and static code analysis with ESLint
- Run tests and upload test result artifacts
- Deploy frontend static files to AWS S3
- Deploy backend Node.js application to an AWS EC2 instance

---

## CI/CD Workflow Overview

| Stage                | Description                                                      |
|----------------------|------------------------------------------------------------------|
| Matrix Build         | Runs on Node.js versions 16, 18, and 20 across dev/staging/prod |
| Linting              | Uses ESLint to perform static code analysis                     |
| Testing              | Runs tests and uploads output as GitHub Actions artifacts        |
| Deploy to S3         | Syncs `./public` to AWS S3 bucket for static hosting             |
| Deploy to EC2        | SSH into EC2, pulls latest code, installs deps, and restarts app |

---

## GitHub Secrets Configuration

| Secret Name             | Description                                                   |
|-------------------------|---------------------------------------------------------------|
| `AWS_ACCESS_KEY_ID`     | AWS IAM access key                                            |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM secret key                                            |
| `AWS_REGION`            | AWS region (e.g., `us-east-1`)                                |
| `AWS_DEPLOY_BUCKET`     | S3 bucket name for hosting static frontend                    |
| `EC2_HOST`              | Public IP or DNS of the EC2 instance                          |
| `EC2_USER`              | SSH username (usually `ubuntu` or `ec2-user`)                 |
| `EC2_SSH_KEY`           | Contents of your `.pem` private SSH key (for EC2 access)      |
| `DEPLOY_PATH`           | Path on EC2 where the app is located (e.g., `/home/ubuntu/app`) |

---

## 📂 Repository Structure

                        


### Use cat your-key.pem to get the content to paste into the GitHub secret.

## STEP 3: Update ci.yml in .github/workflows/

### Make sure your GitHub Actions workflow has this EC2 deployment step after build + test.

### Example:

```
      - name: Conditional Deployment Step (EC2)
        if: ${{ matrix.environment == 'production' && success() }}
        uses: appleboy/ssh-action@v1.0.3
        with:
          host: ${{ secrets.EC2_HOST }}
          username: ${{ secrets.EC2_USER }}
          key: ${{ secrets.EC2_SSH_KEY }}
          script: |
            cd ${{ secrets.DEPLOY_PATH }}
            git pull origin main
            npm install --omit=dev
            pm2 restart all || node index.js &
     
```

### This does the following on your EC2:

- Navigates to your app folder

- Pulls the latest code

- Installs only production dependencies

- Restarts the app with PM2, or starts it in background


## STEP 4:If you're deploying for the first time, SSH into your EC2 and run:

# Inside your app folder

`git clone https://github.com/your-username/your-repo.git .`

`npm install`

`pm2 start index.js --name github-action-app`

### Ensure that port 3000 is open in your EC2 security group.


## STEP 5: Push Code and Trigger Deployment

`git add .`

`git commit -m "Trigger CI/CD to EC2"`

`git push origin main`

### You’ll see logs of SSH activity directly in your GitHub Actions run.

## our app is now:

- Built

- Tested

- Deployed automatically to EC2 from GitHub

## Implementing Contnuous Deployment using our Continous Integration workflow from project 3.

## Step 1: EC2 Setup

### Creating environment where application will be hosted. In this example I shall be hosting my nodejs app on AWS EC2 instance.

![image](screenshot/1.PNG)

### Envronment secrets and variables

![image](screenshot/2.PNG)

### Security group setup. I open port 3000 because that is where our app will be listening to and port 22 for ssh access

![image](screenshot/3.PNG)

### S3 Bucket Set

![image](screenshot/4.PNG)

### Successfully ssh into the app server

![image](screenshot/5.PNG)

### Updating and installing dependencies on our app server

![image](screenshot/6.PNG)

## Step 2: Setting up App Directory

### Creating our app folder and navigating into the app folder

![image](screenshot/7.PNG)

### Cloning our app repository into the app server

![image](screenshot/8.PNG)

### Navigating into the project folder and install app dependencies

`npm install`

`pm2 start index.js --name node-backend`

![image](screenshot/9.PNG)

![image](screenshot/10.PNG)

![image](screenshot/11.PNG)

![image](screenshot/12.PNG)

### Successful deployment of our application to aws ec2 instance

![image](screenshot/13.PNG)

### successful build and deployment

![image](screenshot/14.PNG)

![image](screenshot/15.PNG)

![image](screenshot/16.PNG)

### Succssful deployment to AWS S3 Bucket

![image](screenshot/17.PNG)









