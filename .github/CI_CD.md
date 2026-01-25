# CI/CD Documentation

## Overview

CI/CD is implemented with **GitHub Actions** and covers:

1. **Required:** Updating the documentation site on **GitHub Pages**.
2. **Bonus (optional):** Building a Docker image, pushing it to **ECR**, and documenting how to pull and run it on the web server.

---

## 1. GitHub Pages (required)

**Workflow:** `.github/workflows/github-pages.yml`

**Purpose:** Publish the project documentation (from `README.md`) to GitHub Pages.

**Triggers:**

- Push to `master` when `README.md` or the workflow file changes.
- Manual run via **Actions → Deploy GitHub Pages → Run workflow**.

**Steps:**

1. Checkout repo.
2. Configure GitHub Pages.
3. Convert `README.md` to HTML (Node + `marked`).
4. Upload artifact and deploy to Pages.

**Setup:**

1. **Settings → Pages**
2. **Source:** **GitHub Actions**
3. Save.

**URL:** `https://<username>.github.io/devops-bootcamp-project`

No GitHub secrets are required.

---

## 2. Docker → ECR (bonus, optional)

**Workflow:** `.github/workflows/docker-build-push.yml`

**Purpose:** Build the application Docker image and push it to AWS ECR.

**Triggers:**

- Push to `master` when `app/`, `Dockerfile`, or the workflow change.
- Manual run (**Actions → Build and Push Docker Image to ECR → Run workflow**), with optional image tag.

**Steps:**

1. Checkout repo.
2. Configure AWS credentials (OIDC).
3. Log in to ECR.
4. Clone app repo (e.g. `https://github.com/Infratify/lab-final-project`) into `app/` if missing.
5. Build Docker image.
6. Tag and push to ECR (`devops-bootcamp/final-project-robin`, region `ap-southeast-1`).

**Required secret:**

- **`AWS_ROLE_ARN`:** IAM role ARN used by GitHub Actions (OIDC).

**IAM setup (summary):**

1. Create an OIDC identity provider for `https://token.actions.githubusercontent.com` (if needed).
2. Create an IAM role that:
   - Is trusted by the GitHub OIDC provider for this repo.
   - Has permissions to push (and pull) images in the ECR repository above (e.g. `AmazonEC2ContainerRegistryFullAccess` or a scoped policy).
3. Put the role ARN into **Settings → Secrets and variables → Actions** as **`AWS_ROLE_ARN`**.

---

## 3. Pull and run on the web server (bonus)

The **Docker workflow** only builds and pushes to ECR. It does **not** update the web server.

To **pull and run** the new image on the web server:

1. Ensure the latest image has been pushed (run the Docker workflow first).
2. Run the Ansible playbook that deploys the web app (see [ansible/README.md](../ansible/README.md)).

That playbook connects to the web server, pulls the image from ECR, and runs the container. Doing this **after** each ECR push gives you the full “push to ECR + pull and run” bonus flow.

---

## Summary

| Item                       | Required | Workflow                   | Secrets     |
|----------------------------|----------|----------------------------|-------------|
| GitHub Pages documentation | ✅ Yes   | `github-pages.yml`         | None        |
| Docker build + push to ECR | Bonus    | `docker-build-push.yml`    | `AWS_ROLE_ARN` |
| Pull & run on web server   | Bonus    | Ansible (manual / your automation) | —           |

---

## References

- [GitHub Pages](https://docs.github.com/en/pages)
- [GitHub Actions](https://docs.github.com/en/actions)
- [AWS ECR](https://docs.aws.amazon.com/ecr/)
- [OIDC with GitHub and AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
