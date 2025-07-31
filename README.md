# Todo-List-nodejs-CI/CD
## Introduction
This project demonstrates a full DevOps pipeline using **Terraform**, **Ansible**, **Docker**, **GitHub Actions**, **K3s**, and **Argo CD** to deploy a Node.js Todo List application with MongoDB.
---

## ✅ Project Structure

| Part | Description |
|------|-------------|
| Part 1 | Dockerized Node.js app with CI (GitHub Actions) pushing to a private Docker Hub repo |
| Part 2 | Terraform + Ansible to provision and configure EC2 instances |
| Part 3 | Kubernetes for deployment |
| Part 4 | Argo CD for GitOps CD |

---

## 📦 Part 1 – Application Setup

### ✔️ Steps

- Cloned: [https://github.com/Ankit6098/Todo-List-nodejs](https://github.com/Ankit6098/Todo-List-nodejs)
- Dockerized app using `Dockerfile`
- Created `.dockerignore` to exclude unnecessary files
- Created CI workflow in `.github/workflows/main.yml`

### 🐳 Docker Image

- Pushed to **private Docker Hub repo**
- Built via GitHub Actions on every push to `main`

---

![Alt text](https://drive.google.com/uc?export=view&id=1Wh0BSRWgO_4f9uIVm7rek5Dv1JCOk7W7)

## ☁️ Part 2 – Infrastructure Provisioning

### ⚙️ Tools Used

- **Terraform**: Provisioned 2 EC2 instances on AWS (1 control plane, 1 worker)
- **Ansible**: Configured the instances:
  - Installed K3s

### 📁 Files

- `terraform/`: VPC, EC2, Security Groups
- `ansible/`: Installs, K3s

### Running Terraform and Ansibble locally 

Terraform:
```bash
terraform init
terraform apply -var-file="var.tfvars"
```
![Alt text](https://drive.google.com/uc?export=view&id=152YnaJSO-CKlMn4_6HF7DrAS3drETvzz)

Ansible:
```bash
ansible-playbook -i inventory.yml playbook.yml 
```
---

![Alt text](https://drive.google.com/uc?export=view&id=1OsfZs-BPflRXqN644mMHuN7p5dJSzoKl)

## ☸️ Part 3 – Kubernetes Deployment

### 🛠 Setup

- Used K3s (lightweight Kubernetes) on EC2
- Created Kubernetes `Deployment`, `Service`, and `Secret` objects
- Used `NodePort` service to expose app
- MongoDB URI passed securely via Kubernetes secret

## 🎯 Part 4 – (Argo CD)

- Argo CD installed locally 
- GitHub repo integrated with Argo CD for Continuous Delivery
- Argo CD tracks:
  - Deployment YAML
  - Service + Secret
  - Automatically syncs changes from Git

---

![Alt text](https://drive.google.com/uc?export=view&id=1C4YSnvMTiyo33beXXwtQSPdnVKODBebU)

## 🔐 Secrets

- MongoDB URI and Docker credentials created manually in cluster:
  ```bash
  kubectl create secret generic mongodb-secret \
    --from-literal=MONGO_URI='mongodb://user:pass@host:27017/db'

  kubectl create secret docker-registry regcred \
    --docker-username=<docker-username> \
    --docker-password=<docker-password> \
    --docker-email=<email>

---
