# DevOps Bootcamp Final Project 2025

**Project Name:** Trust Me, I'm a DevOps Engineer

---

## 📌 Overview

This repository contains the final capstone project for the DevOps Bootcamp 2025.

The objective is to design, provision, configure, deploy, monitor, and document a complete DevOps-based system using industry-standard tools and best practices.

---

## 🏗️ Architecture Overview

The system is built on AWS with a secure public/private subnet layout:

- **Terraform** for infrastructure
- **Ansible** for configuration
- **Docker** for the web app
- **Prometheus** and **Grafana** for monitoring
- **Cloudflare Tunnel** for secure access
- **GitHub Pages** for documentation

---

## 🧰 Technology Stack

- **Cloud:** AWS (ap-southeast-1)
- **IaC:** Terraform
- **Config:** Ansible
- **Containers:** Docker
- **Monitoring:** Prometheus, Grafana
- **DNS / Security:** Cloudflare
- **CI/CD:** GitHub Actions (GitHub Pages; optional Docker → ECR)

---

## 📁 Repository Structure

```text
devops-bootcamp-project/
├── .github/
│   └── workflows/       # GitHub Actions CI/CD
├── terraform/           # Terraform
├── ansible/             # Ansible playbooks and roles
└── README.md            # Project docs (GitHub Pages)
```

---

## 🚀 CI/CD

### Required: GitHub Pages

- **Workflow:** `.github/workflows/github-pages.yml`
- **Purpose:** Publish the documentation site to GitHub Pages when `README.md` (or the workflow) changes.
- **URL:** `https://<username>.github.io/devops-bootcamp-project`

**Setup:**

1. **Settings → Pages**
2. Set **Source** to **GitHub Actions**.

No extra secrets are needed for Pages.

---

### Bonus: Docker → ECR (optional)

- **Workflow:** `.github/workflows/docker-build-push.yml`
- **Purpose:** Build the app image, push it to AWS ECR.
- **Triggers:** Pushes to `main`/`master` (when `app/`, `Dockerfile`, or the workflow changes) or manual run.

**Setup (optional):**

1. Create an IAM role for GitHub Actions (OIDC with `token.actions.githubusercontent.com`).
2. Grant that role access to ECR (e.g. `AmazonEC2ContainerRegistryFullAccess` or a custom ECR policy).
3. Add a repository secret: **`AWS_ROLE_ARN`** = that role’s ARN.

To **deploy** the new image on the web server (pull and run), run the Ansible playbook after a push (see [ansible/README.md](ansible/README.md)).

---

## 📚 More

- **CI/CD details:** [.github/CI_CD.md](.github/CI_CD.md)
- **Ansible usage:** [ansible/README.md](ansible/README.md)
