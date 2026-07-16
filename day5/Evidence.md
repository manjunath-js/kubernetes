# Day 5 – Kubernetes Lab Evidence
---

# Objective

The objective of this lab was to deploy a simple e-commerce application in Kubernetes using Deployments and Services, configure Ingress for path-based routing, verify application health using Probes, implement Network Policies, test Egress connectivity, and deploy the application using Helm.

---

# Environment

- OS: Windows 11
- Kubernetes: Minikube
- Container Runtime: Docker
- kubectl: Installed and Configured
- Helm: Installed
- Namespace: `day5`

---

# Lab 1 – Deployments

## Objective

Create Kubernetes Deployments for the Payments and Orders applications.

### Commands Executed

```bash
kubectl apply -f manifests/01-payments-deployment.yaml
kubectl apply -f manifests/02-orders-deployment.yaml
kubectl get deployments -n day5
kubectl get pods -n day5
```

### Evidence

- Successfully created Payments and Orders Deployments.
- Both applications were deployed with two replicas.
- Verified that all Pods were in the **Running** state.

**Output:**

<img width="628" height="193" alt="image" src="https://github.com/user-attachments/assets/78a574e6-e700-4c80-8b01-dba78dd3434a" />

---

# Lab 2 – ClusterIP Services

## Objective

Expose the applications internally using Kubernetes Services.

### Commands Executed

```bash
kubectl apply -f manifests/03-payments-service.yaml
kubectl apply -f manifests/04-orders-service.yaml
kubectl get svc -n day5
kubectl get endpoints -n day5
```

### Evidence

- Created ClusterIP Services for both applications.
- Verified that the Services were connected to the correct Pod endpoints.
- Confirmed internal communication within the cluster.

**Output:**

<img width="708" height="96" alt="Screenshot 2026-07-15 190557" src="https://github.com/user-attachments/assets/3bc8b0b2-e37a-4a1b-b9b6-8e09a5708e22" />



---

# Lab 3 – Ingress Controller

## Objective

Enable the NGINX Ingress Controller.

### Commands Executed

```bash
minikube addons enable ingress
kubectl get pods -n ingress-nginx
```

### Evidence

- Successfully enabled the NGINX Ingress Controller.
- Verified that the Ingress Controller Pod was running successfully.

**Output:**

<img width="750" height="263" alt="Screenshot 2026-07-15 171708" src="https://github.com/user-attachments/assets/d9d3c6f6-375c-4966-b1de-4dab9f56e8e0" />


---

# Lab 4 – Ingress Resource

## Objective

Configure path-based routing using Kubernetes Ingress.

### Commands Executed

```bash
kubectl apply -f manifests/06-ingress.yaml
kubectl get ingress -n day5
kubectl describe ingress ecommerce-ingress -n day5
```

### Evidence

- Created the Ingress Resource successfully.
- Configured routing for:
  - `/payments`
  - `/orders`

- Verified that the Ingress Controller recognized the routing rules.

**Output:**

<img width="733" height="397" alt="Screenshot 2026-07-15 172046" src="https://github.com/user-attachments/assets/a0144314-51f3-4dba-ab8e-4f0f8ae069d7" />


---

# Lab 5 – Verify Application Routing

## Objective

Verify routing through the Ingress Controller.

### Commands Executed

```bash
curl http://127.0.0.1/payments -H "Host: day5.local"
curl http://127.0.0.1/orders -H "Host: day5.local"
```

### Evidence

- Successfully accessed the Payments application.
- Successfully accessed the Orders application.
- Verified that path-based routing was working correctly through the Ingress Controller.

**Output:**

<img width="681" height="112" alt="Screenshot 2026-07-15 185318" src="https://github.com/user-attachments/assets/e9b58337-1f1d-44e0-91f3-003bc810ec8b" />


---

# Lab 6 – Liveness and Readiness Probes

## Objective

Verify Pod health using Kubernetes Probes.

### Commands Executed

```bash
kubectl describe deployment payments -n day5
kubectl describe pod <pod-name> -n day5
```

### Evidence

- Verified Readiness Probe configuration.
- Verified Liveness Probe configuration.
- Confirmed that the Pods were healthy and ready to serve traffic.

**Output:**

<img width="752" height="593" alt="Screenshot 2026-07-15 190401" src="https://github.com/user-attachments/assets/5aab2079-0c7b-4c84-a055-0f94ce3f3723" />
<img width="748" height="778" alt="Screenshot 2026-07-15 190507" src="https://github.com/user-attachments/assets/d95ae9ca-3a0f-45f0-a72c-55ca073df360" />
<img width="708" height="96" alt="Screenshot 2026-07-15 190557" src="https://github.com/user-attachments/assets/5ebaab5a-90e7-43d6-ad6b-9330e0aabb12" />

---

# Lab 8 – Egress Testing

## Objective

Verify outbound internet connectivity from a Kubernetes Pod.

### Commands Executed

```bash
kubectl exec -n day5 egress-client -- wget -qO- http://example.com
```

### Evidence

- Successfully connected to **example.com** from inside the Pod.
- Verified that outbound (Egress) network traffic was working correctly.

**Output:** 

<img width="1522" height="95" alt="Screenshot 2026-07-15 191050" src="https://github.com/user-attachments/assets/abefb5d4-f272-4bbc-a491-901e14a5c9c9" />


---

# Lab 9 – Helm Chart Deployment

## Objective

Deploy the application using a Helm Chart.

### Commands Executed

```bash
helm install day5-web helm/day5-ecommerce -n day5
helm list -A
```

### Evidence

- Successfully installed the Helm Chart.
- Created the Helm Release **day5-web**.
- Verified that the release status was **deployed**.

**Output:**

<img width="1086" height="508" alt="Screenshot 2026-07-15 230558" src="https://github.com/user-attachments/assets/b93a2296-66e6-4d86-bb6e-5024f53b3633" />
<img width="985" height="147" alt="Screenshot 2026-07-15 230813" src="https://github.com/user-attachments/assets/38183c60-a447-478c-924b-2967141784e4" />
<img width="1096" height="62" alt="Helm list" src="https://github.com/user-attachments/assets/ed87caa1-41a4-4026-9b0b-6323af2b273c" />


---

# Skills Gained

- Creating Kubernetes Deployments
- Managing ReplicaSets
- Creating ClusterIP Services
- Configuring NGINX Ingress
- Implementing Path-Based Routing
- Configuring Liveness and Readiness Probes
- Testing Egress Connectivity
- Deploying Applications using Helm
- Managing Helm Releases

---

# Conclusion

Successfully completed all Kubernetes Day 5 practical exercises in the **day5** namespace. Verified Deployments, Services, Ingress Controller, Ingress routing, Probes, Egress connectivity, and Helm deployment. All resources were created successfully, and the expected outputs were verified using Kubernetes and Helm commands.
