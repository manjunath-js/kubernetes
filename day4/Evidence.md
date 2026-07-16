# Day 4 – Kubernetes Lab Evidence
---

# Objective

Completed Kubernetes Day 4 practical labs covering:

* Labels and Selectors
* Service Selectors
* ReplicaSet
* Metrics Server
* Horizontal Pod Autoscaler (HPA)
* RBAC
* ClusterRole and ClusterRoleBinding

---

# Environment

* OS: Windows 11
* Kubernetes: Minikube
* kubectl: Installed and Configured
* Namespace: `manjunath-day4`

---

# Lab 1 – Labels and Selectors

## Objective

Learn how Labels are assigned to Kubernetes objects and how Selectors filter resources.

### Commands Executed

```bash
kubectl apply -f labeled-pods.yaml
kubectl get pods --show-labels
kubectl get pods -l environment=dev
kubectl get pods -l tier=frontend
kubectl get pods -l environment=dev,tier=backend
kubectl get pods -l environment!=prod
kubectl get pods -l 'environment in (dev,qa)'
kubectl get pods -l 'tier notin (backend)'
```

### Result

* Successfully created all Pods.
* Verified Labels.
* Filtered Pods using Equality-Based and Set-Based Selectors.

**Output:**

<img width="855" height="607" alt="Labels and Selectors" src="https://github.com/user-attachments/assets/df8cd23d-1e76-4684-9f44-473707431c69" />


---

# Lab 2 – Service Selector

## Objective

Create a Service that routes traffic only to frontend Pods.

### Commands

```bash
kubectl apply -f ecommerce-frontend-service.yaml
kubectl get svc
kubectl get endpoints ecommerce-frontend
kubectl get endpointslice -l kubernetes.io/service-name=ecommerce-frontend
```

### Result

* Service created successfully.
* EndpointSlice showed only frontend Pods.
* Backend Pods were not selected because of label mismatch.

**Output:**

<img width="831" height="262" alt="service selector" src="https://github.com/user-attachments/assets/71d94bcc-4474-46e8-98d4-1a107387204b" />


---

# Lab 3 – ReplicaSet

## Objective

Understand ReplicaSet and Kubernetes self-healing.

### Commands

```bash
kubectl apply -f nginx-replicaset.yaml
kubectl get rs
kubectl get pods -l app=nginx
kubectl delete pod <replicaset-pod>
kubectl get pods -w
```

### Result

* ReplicaSet maintained the desired number of replicas.
* Deleted Pod was automatically recreated.

**Output:**

<img width="642" height="502" alt="replicaset " src="https://github.com/user-attachments/assets/e6b9dc29-0e28-4d83-93be-18917ccb0c91" />



---

# Lab 4 – Metrics Server

## Objective

Enable Metrics Server and verify resource metrics.

### Commands

```bash
minikube addons enable metrics-server
kubectl top nodes
kubectl top pods
```

### Result

* Metrics Server enabled successfully.
* CPU and Memory usage displayed for all Pods.

**Output:**

<img width="840" height="419" alt="metric server" src="https://github.com/user-attachments/assets/fc1b98ca-9d17-484c-b464-965b3603b156" />


---

# Lab 5 – Horizontal Pod Autoscaler (HPA)

## Objective

Automatically scale Pods based on CPU utilization.

### Commands

```bash
kubectl apply -f php-apache-deployment.yaml
kubectl apply -f php-apache-service.yaml
kubectl apply -f php-apache-hpa.yaml
kubectl get hpa
kubectl describe hpa php-apache
```

Load Generation

```bash
kubectl run -it --rm load-generator --image=busybox --restart=Never -- /bin/sh
```

Inside BusyBox

```bash
while true; do wget -q -O- http://php-apache; done
```

### Result

* HPA created successfully.
* CPU utilization monitored.
* Deployment scaled automatically based on workload.

**Output:**

<img width="1920" height="1080" alt="horizontal pod Autoscalar" src="https://github.com/user-attachments/assets/7fe455d0-d6f0-4fda-b33e-f04b3a7e2f00" />



---

# Lab 6 – RBAC

## Objective

Provide read-only Pod access using Role and RoleBinding.

### Commands

```bash
kubectl apply -f dev-user-serviceaccount.yaml
kubectl apply -f pod-reader-role.yaml
kubectl apply -f pod-reader-rolebinding.yaml

kubectl auth can-i list pods --as=system:serviceaccount:manjunath-day4:dev-user
kubectl auth can-i delete pods --as=system:serviceaccount:manjunath-day4:dev-user
```

### Result

* ServiceAccount created successfully.
* Read access granted.
* Delete access denied as expected.

**Output:**

<img width="732" height="462" alt="RoleBinding" src="https://github.com/user-attachments/assets/76e8f3a3-6eea-4a0d-8962-88de35a8f4da" />

---

# Lab 7 – ClusterRole and ClusterRoleBinding

## Objective

Grant cluster-wide permission to list Nodes.

### Commands

```bash
kubectl apply -f node-reader-clusterrole.yaml
kubectl apply -f node-reader-clusterrolebinding.yaml

kubectl auth can-i list nodes --as=system:serviceaccount:manjunath-day4:dev-user
```

### Result

* ClusterRole created successfully.
* ClusterRoleBinding attached to the ServiceAccount.
* Verified node listing permission.

**Output:**

<img width="727" height="395" alt="ClusterRoleBinding" src="https://github.com/user-attachments/assets/47734b71-0a60-492c-98a8-c0d8b84edf13" />



---

# Skills Gained

* Working with Kubernetes Labels and Selectors
* Creating Services using Selectors
* Managing ReplicaSets
* Understanding Kubernetes self-healing
* Monitoring CPU and Memory with Metrics Server
* Configuring Horizontal Pod Autoscaler (HPA)
* Implementing RBAC using Roles and RoleBindings
* Managing cluster-wide permissions using ClusterRoles

---

# Conclusion

Successfully completed all Kubernetes Day 4 practical exercises in the `manjunath-day4` namespace. Verified each lab using Kubernetes commands and observed the expected behavior, including Service selection, ReplicaSet self-healing, Metrics Server monitoring, HPA configuration, and RBAC authorization.
