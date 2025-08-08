# IaC Deployment Stack with Jenkins, Helm, OpenTofu, Prometheus and Grafana

This repository sets up a complete deployment and monitoring system using:

- **Jenkins**: CI/CD
- **Helm**: Kubernetes package manager
- **OpenTofu**: Infrastructure as Code (IaC)
- **Prometheus + Grafana**: Observability stack
- **Minikube or external Kubernetes**: Cluster manager
- **Example app**: Exposes `/metrics` endpoint for Prometheus scraping

---

## 🧰 Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [OpenTofu](https://opentofu.org/)
- [Checkov](https://www.checkov.io/) (for IaC validation)
- [GNU Make (optional)](https://www.gnu.org/software/make/)

---

## 🚀 Quick Start with Minikube

```bash
# 1. Start cluster
minikube start --memory 8192 --cpus 4

# 2. Clone and enter project
unzip iac-deployment.zip
cd iac-deployment

# 3. Initialize OpenTofu
opentofu init

# 4. Run validation (optional but recommended)
./tests/test_tf.sh

# 5. Apply infrastructure
opentofu apply -auto-approve
```

---

## ✅ Accessing Services

```bash
# Jenkins
kubectl port-forward svc/jenkins 8080:8080 -n infra

# Grafana
kubectl port-forward svc/grafana 3000:80 -n infra

# Prometheus
kubectl port-forward svc/prometheus-operated 9090:9090 -n infra
```

- Default Jenkins credentials: `admin / admin`
- Default Grafana credentials: `admin / admin`

---

## 📦 Example App

An example application (Node Exporter) is deployed in the `apps` namespace and exposes `/metrics` by default on port `9100`.

---

## 🚦 Jenkins Pipeline

Jenkins runs a pipeline defined in `jenkins/Jenkinsfile`:

- **Build**: Placeholder
- **Test**: Runs `./tests/test_app.sh`
- **Deploy**: Deploys app via Helm in `apps` namespace

---

## 🔁 Using Another Cluster (e.g. KinD, K3s, Cloud)

You can replace Minikube with any Kubernetes cluster.

```bash
# Use your kubeconfig path if not default
export KUBECONFIG=~/.kube/config

# Then initialize and apply as normal
opentofu init
opentofu apply
```

Ensure your cluster has enough resources (~8GB RAM recommended).

---

## 🧪 Testing Infrastructure

```bash
./tests/test_tf.sh    # Runs terraform validate + checkov
./tests/test_app.sh   # Dummy app test
```

---

## 📈 Observability

Prometheus automatically scrapes services in `apps` namespace with default config.

Grafana connects to Prometheus and can be pre-loaded with dashboards.

---

## 📂 Project Structure

```
iac-deployment/
├── main.tf
├── values/
├── helm/myapp/
├── jenkins/
├── tests/
└── README.md
```

---