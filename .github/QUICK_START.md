# CI/CD Quick Start

## Required: GitHub Pages

1. Open **Settings → Pages**.
2. Under **Source**, choose **GitHub Actions**.
3. Save.

On each relevant push (or manual run), the **Deploy GitHub Pages** workflow will publish the docs.

**URL:** `https://<username>.github.io/devops-bootcamp-project`

---

## Bonus: Docker → ECR (optional)

1. **Create IAM user with ECR access**

   - Go to AWS IAM → Users → Create user (or use existing)
   - Attach policy: `AmazonEC2ContainerRegistryFullAccess` (or custom ECR policy)
   - Go to Security credentials → Create access key
   - Choose "Application running outside AWS"
   - Copy the Access key ID and Secret access key

2. **Add GitHub secrets**

   - **Settings → Secrets and variables → Actions**
   - Add two secrets:
     - **Name:** `AWS_ACCESS_KEY_ID`, **Value:** your access key ID
     - **Name:** `AWS_SECRET_ACCESS_KEY`, **Value:** your secret access key

3. **Run the workflow**

   - **Actions → Build and Push Docker Image to ECR → Run workflow.**

To **pull and run** on the web server, use the Ansible playbook (see [ansible/README.md](../ansible/README.md)) after pushing the image.

---

## More detail

See [CI_CD.md](CI_CD.md) for full CI/CD documentation.
