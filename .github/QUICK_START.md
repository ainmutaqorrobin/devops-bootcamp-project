# CI/CD Quick Start

## Required: GitHub Pages

1. Open **Settings → Pages**.
2. Under **Source**, choose **GitHub Actions**.
3. Save.

On each relevant push (or manual run), the **Deploy GitHub Pages** workflow will publish the docs.

**URL:** `https://<username>.github.io/devops-bootcamp-project`

---

## Bonus: Docker → ECR (optional)

1. **Create IAM role for GitHub Actions (OIDC)**

   - Use `https://token.actions.githubusercontent.com` as OIDC provider.
   - Trust policy: allow `sts:AssumeRoleWithWebIdentity` for your repo (e.g. `repo:USERNAME/devops-bootcamp-project:*`).
   - Attach a policy that allows ECR push (e.g. `AmazonEC2ContainerRegistryFullAccess` or a custom ECR policy).

2. **Add GitHub secret**

   - **Settings → Secrets and variables → Actions**
   - New secret: **Name** = `AWS_ROLE_ARN`, **Value** = the IAM role ARN.

3. **Run the workflow**

   - **Actions → Build and Push Docker Image to ECR → Run workflow.**

To **pull and run** on the web server, use the Ansible playbook (see [ansible/README.md](../ansible/README.md)) after pushing the image.

---

## More detail

See [CI_CD.md](CI_CD.md) for full CI/CD documentation.
