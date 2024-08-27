# Google Cloud Platform (GCP) Virtual Machine Creation with Terraform

## Overview

This document provides step-by-step instructions on how to create a Virtual Machine (VM) using Terraform and Google Cloud Platform (GCP). Follow the outlined steps to complete the assignment successfully.

## Prerequisites

- A Google Cloud Platform (GCP) account.
- A working terminal with administrative privileges.
- Basic knowledge of Terraform and GCP.
- Access to GitHub.

## Instructions

### 1. Sign Up for Google Cloud Platform

1. **Sign up** for a Google Cloud Platform (GCP) account by visiting [Google Cloud](https://cloud.google.com/).
2. **Log in** to the GCP Console using your Gmail account credentials.
3. **Create a New Project** for this course:
   - Navigate to the GCP Dashboard.
   - Click on the current project name (e.g., "ProjectForClass").
   - In the view that appears, select the option to create a new project.

### 2. Install Terraform on Your Computer

#### For Linux (Ubuntu)
1. Open your terminal.
2. Run the following commands to install Terraform:

   ```bash
   wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   sudo apt update && sudo apt install terraform
   ```

### 3. Install Google Cloud CLI (gcloud CLI)

1. **Prepare your system** for gcloud CLI installation:

   ```bash
   sudo apt-get update
   sudo apt-get install apt-transport-https ca-certificates gnupg curl
   ```

2. **Import the Google Cloud public key** and add the gcloud CLI distribution URI as a package source:

   ```bash
   curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
   echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
   ```

3. **Update and install** the gcloud CLI:

   ```bash
   sudo apt-get update && sudo apt-get install google-cloud-cli
   ```

4. (Optional) **Install additional components** as needed:

   ```bash
   sudo apt-get install google-cloud-cli
   sudo apt-get install google-cloud-cli-anthos-auth
   sudo apt-get install google-cloud-cli-app-engine-go
   sudo apt-get install google-cloud-cli-app-engine-grpc
   sudo apt-get install google-cloud-cli-app-engine-java
   sudo apt-get install google-cloud-cli-app-engine-python
   sudo apt-get install google-cloud-cli-app-engine-python-extras
   sudo apt-get install google-cloud-cli-bigtable-emulator
   sudo apt-get install google-cloud-cli-cbt
   sudo apt-get install google-cloud-cli-cloud-build-local
   sudo apt-get install google-cloud-cli-cloud-run-proxy
   sudo apt-get install google-cloud-cli-config-connector
   sudo apt-get install google-cloud-cli-datastore-emulator
   sudo apt-get install google-cloud-cli-firestore-emulator
   sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin
   sudo apt-get install google-cloud-cli-kpt
   sudo apt-get install google-cloud-cli-kubectl-oidc
   sudo apt-get install google-cloud-cli-local-extract
   sudo apt-get install google-cloud-cli-minikube
   sudo apt-get install google-cloud-cli-nomos
   sudo apt-get install google-cloud-cli-pubsub-emulator
   sudo apt-get install google-cloud-cli-skaffold
   sudo apt-get install google-cloud-cli-spanner-emulator
   sudo apt-get install google-cloud-cli-terraform-validator
   sudo apt-get install google-cloud-cli-tests
   sudo apt-get install kubectl
   ```

5. **Initialize gcloud CLI**:

   ```bash
   gcloud init
   ```

### 4. Clone or Fork the Course GitHub Repository

1. **Clone or fork** the course repository available at [this link](https://github.com/eric-keller/npp-cloud).
2. **Navigate** to the `tf-mod1-demo` directory within the cloned repository.

### 5. Modify and Deploy the Provided Code

1. **Open the `provider.tf` file** located in the `tf-mod1-demo` directory.
2. **Edit the file** to replace the placeholders marked as `FILL-IN` with your specific project details:
   - Replace `<project_id>` with your Google Cloud Platform project ID.
   - Update the `credentials` line to point to the path of your GCP credentials JSON file, which should be placed in the root directory of the `npp-cloud` repository.
   - Ensure that the `region` and `zone` are set appropriately for your VM location.

   The updated `provider.tf` file should look something like this:

   ```hcl
   provider "google" {
     credentials = file("../<your-project-id>-xxx.json")

     project = "<your-project-id>"
     region = "us-central1"
     zone   = "us-central1-a"
   }
   ```

3. **Deploy the code** using Terraform by following these steps:
   - Navigate to the directory containing the `provider.tf` file.
   - Run the following commands in your terminal:

     ```bash
     terraform init
     terraform apply
     ```

4. **Confirm** the deployment when prompted to proceed with the changes.

### 6. SSH into the Deployed VM

1. **Using gcloud CLI**:
   - Run the following command in your terminal:

     ```bash
     gcloud compute ssh <VM_NAME> --zone <ZONE>
     ```

2. **Using the GCP Console**:
   - Navigate to the VM instances section in the GCP Console.
   - Click on the SSH link next to the deployed VM.

### Conclusion

You have successfully created a Virtual Machine on Google Cloud Platform using Terraform. You should now be able to connect to the VM via SSH and explore further configurations or installations as needed.