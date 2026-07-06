# Kubernetes Zero To Hero - 7 Days Notes

Author style: Bari Sagar student notes

Goal:
Learn Kubernetes from scratch with both theory and practical, in simple student-friendly language.

Daily format:
1. What is the topic?
2. Why do we use it?
3. Real-time example
4. YAML example
5. kubectl commands
6. Small student task
7. Interview point

Lab setup:
- OS: Windows PowerShell
- Container runtime: Docker Desktop
- Local Kubernetes cluster: kind
- Kubernetes CLI: kubectl

Simple Kubernetes flow:

```text
User ---> kubectl ---> kube-api-server ---> control plane ---> worker node ---> pod ---> container image
```

Main object flow:

```text
Cluster ---> Node ---> Pod ---> Container ---> Docker Image
```

Important correction:
Kubernetes is not only a Docker platform. Kubernetes is a container orchestration platform.
It helps us deploy, expose, scale, update, and self-heal containerized applications.

Example:
If one application container goes down, Kubernetes can start another one automatically.

---

## 7 Day Roadmap

| Day | Topic | Practical Output |
| --- | --- | --- |
| Day 1 | Kubernetes basics, architecture, setup, namespace, pod | Create local cluster and run first nginx pod |
| Day 2 | YAML, labels, selectors, ReplicaSet, Deployment | Deploy nginx using Deployment with replicas |
| Day 3 | Services and networking | Expose app using ClusterIP, NodePort, port-forward |
| Day 4 | ConfigMap, Secret, volumes | Pass config/password to app and mount volume |
| Day 5 | Probes, resources, debugging | Add health checks and debug broken pods |
| Day 6 | Ingress, autoscaling, DaemonSet, RBAC basics | Route traffic and understand production features |
| Day 7 | Helm and final project | Package and deploy a complete mini application |

---

# Day 1 - Kubernetes Basics And First Pod

Date:

## 1. Kubernetes

Kubernetes is a container orchestration platform.

It is used to:
- deploy containerized applications
- expose applications to users
- scale applications up and down
- restart failed containers automatically
- manage application configuration

Simple meaning:
Kubernetes is like a manager for containers.

Example:
Suppose we have a shopping website container.
If traffic increases, Kubernetes can run more copies of that container.
If one copy fails, Kubernetes can start a new copy.

## 2. Basic Architecture

```text
Cluster
  |
  |-- Control Plane
  |     |-- kube-api-server
  |     |-- etcd
  |     |-- scheduler
  |     |-- controller-manager
  |
  |-- Worker Node
        |-- kubelet
        |-- kube-proxy
        |-- container runtime
        |-- pods
```

## 3. Cluster

A cluster is a group of machines where Kubernetes runs.

Simple meaning:
Cluster is the full Kubernetes environment.

Example:
One cluster can run payment app, order app, user app, and database app.

## 4. Node

A node is a machine inside the Kubernetes cluster.

There are two types:
1. Control plane node
2. Worker node

Worker node runs the actual application pods.

## 5. Pod

A Pod is the smallest deployable unit in Kubernetes.

Simple meaning:
Pod is a wrapper around one or more containers.

Usually:

```text
1 Pod ---> 1 Container
```

Sometimes:

```text
1 Pod ---> multiple tightly connected containers
```

Pod has:
- own IP address
- own network space
- containers
- temporary storage
- optional mounted volumes

## 6. Control Plane Components

### kube-api-server

kube-api-server exposes the Kubernetes API.

Simple meaning:
All Kubernetes requests go through the API server.

Example:
When we run:

```powershell
kubectl get pods
```

kubectl asks kube-api-server for pod details.

### etcd

etcd stores Kubernetes cluster data as key-value data.

Simple meaning:
etcd is like the database of Kubernetes.

It stores:
- cluster state
- pod details
- deployment details
- service details
- config data

### kube-scheduler

kube-scheduler decides which node should run a newly created pod.

Simple meaning:
Scheduler selects the best worker node for a pod.

Example:
If node1 has enough CPU and memory, scheduler can place the pod on node1.

### kube-controller-manager

kube-controller-manager runs controller processes.

Simple meaning:
Controller manager keeps watching the cluster and tries to match actual state with desired state.

Example:
If desired replicas = 3 and only 2 pods are running, controller manager creates 1 more pod.

Common controllers:
- Node controller
- Job controller
- Deployment controller
- ReplicaSet controller

## 7. Worker Node Components

### kubelet

kubelet runs on every worker node.

Simple meaning:
kubelet makes sure pods are running properly on the node.

It receives Pod specification and asks container runtime to run containers.

### kube-proxy

kube-proxy maintains network rules on each node.

Simple meaning:
kube-proxy helps communication between services and pods.

### Container Runtime

Container runtime is the software that runs containers.

Examples:
- containerd
- CRI-O
- Docker Engine older workflow

## 8. kubectl

kubectl is the command line tool for Kubernetes.

Simple meaning:
kubectl is used to communicate with Kubernetes cluster.

Example:

```powershell
kubectl get pods
kubectl get nodes
kubectl apply -f pod.yaml
```

## 9. Day 1 Practical - Check Tools

Run these commands:

```powershell
docker version
kubectl version --client
kind version
```

Expected:
- Docker should be running
- kubectl should show client version
- kind should show version

## 10. Create Local Kubernetes Cluster

```powershell
kind create cluster --name k8s-hero
```

Check cluster:

```powershell
kubectl cluster-info
kubectl get nodes
kubectl get pods -A
```

Meaning:
- `kubectl cluster-info` shows cluster endpoint
- `kubectl get nodes` lists cluster nodes
- `kubectl get pods -A` lists pods from all namespaces

## 11. Namespace

Namespace is used to group Kubernetes resources.

Simple meaning:
Namespace is like a separate room inside one cluster.

Example:

```text
dev namespace
test namespace
prod namespace
```

Create namespace:

```powershell
kubectl create namespace day1
```

List namespaces:

```powershell
kubectl get namespaces
kubectl get ns
```

Set current namespace:

```powershell
kubectl config set-context --current --namespace=day1
```

Check current namespace:

```powershell
kubectl config view --minify
```

## 12. Create First Pod Using Command

```powershell
kubectl run nginx --image=nginx --port=80 -n day1
```

Check pod:

```powershell
kubectl get pods -n day1
kubectl get pods -n day1 -o wide
kubectl describe pod nginx -n day1
kubectl logs nginx -n day1
```

Important:
- `kubectl describe` shows pod details and events
- `kubectl logs` shows container logs

## 13. Create Pod Using YAML

File name:

```text
day1-pod.yaml
```

YAML:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  namespace: day1
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:1.27
      ports:
        - containerPort: 80
```

Apply YAML:

```powershell
kubectl apply -f day1-pod.yaml
```

Check:

```powershell
kubectl get pods -n day1
kubectl describe pod nginx-pod -n day1
```

Delete:

```powershell
kubectl delete -f day1-pod.yaml
kubectl delete pod nginx -n day1
```

## 14. Day 1 Student Task

Task:
1. Create namespace `student-day1`
2. Create nginx pod inside that namespace
3. Check pod status
4. Check pod IP
5. Check pod logs
6. Delete the pod
7. Delete the namespace

Commands:

```powershell
kubectl create namespace student-day1
kubectl run nginx --image=nginx --port=80 -n student-day1
kubectl get pods -n student-day1
kubectl get pods -n student-day1 -o wide
kubectl logs nginx -n student-day1
kubectl delete pod nginx -n student-day1
kubectl delete namespace student-day1
```

## 15. Day 1 Interview Points

1. Kubernetes is a container orchestration platform.
2. Cluster is a group of nodes.
3. Pod is the smallest deployable unit in Kubernetes.
4. kube-api-server receives all Kubernetes API requests.
5. etcd stores cluster state.
6. scheduler selects the node for new pods.
7. kubelet makes sure containers are running inside pods.
8. kubectl is the CLI tool used to communicate with Kubernetes.

---

# Day 2 - YAML, Labels, Selectors, ReplicaSet, Deployment

## 1. YAML In Kubernetes

Kubernetes objects are mostly created using YAML files.

Simple meaning:
YAML is the file where we write what we want Kubernetes to create.

Common fields:

```yaml
apiVersion:
kind:
metadata:
spec:
```

Meaning:
- `apiVersion` defines API version
- `kind` defines object type
- `metadata` defines name, namespace, labels
- `spec` defines desired configuration

## 2. Labels

Labels are key-value pairs attached to Kubernetes objects.

Simple meaning:
Labels are tags.

Example:

```yaml
labels:
  app: nginx
  env: dev
```

## 3. Selectors

Selectors are used to find objects using labels.

Simple meaning:
Selector says: find all pods with this label.

Example:

```yaml
selector:
  matchLabels:
    app: nginx
```

Command:

```powershell
kubectl get pods -l app=nginx
```

## 4. ReplicaSet

ReplicaSet maintains a stable number of pod replicas.

Simple meaning:
ReplicaSet makes sure required number of pods are always running.

Example:
If replicas = 3 and one pod is deleted, ReplicaSet creates a new pod.

## 5. Deployment

Deployment manages ReplicaSets and Pods.

Simple meaning:
Deployment is used to deploy and update applications safely.

Deployment gives:
- replicas
- rolling update
- rollback
- self-healing

## 6. Day 2 Deployment YAML

File name:

```text
day2-deployment.yaml
```

YAML:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: day2
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.27
          ports:
            - containerPort: 80
```

Commands:

```powershell
kubectl create namespace day2
kubectl apply -f day2-deployment.yaml
kubectl get deployments -n day2
kubectl get replicaset -n day2
kubectl get pods -n day2 -o wide
```

Scale deployment:

```powershell
kubectl scale deployment nginx-deployment --replicas=5 -n day2
kubectl get pods -n day2
```

Update image:

```powershell
kubectl set image deployment/nginx-deployment nginx=nginx:1.28 -n day2
kubectl rollout status deployment/nginx-deployment -n day2
```

Rollback:

```powershell
kubectl rollout history deployment/nginx-deployment -n day2
kubectl rollout undo deployment/nginx-deployment -n day2
```

## 7. Day 2 Student Task

1. Create namespace `student-day2`
2. Create Deployment with 2 nginx pods
3. Scale it to 4 pods
4. Change nginx image version
5. Rollback the deployment
6. Delete namespace

## 8. Day 2 Interview Points

1. Label is used to tag Kubernetes resources.
2. Selector is used to select resources based on labels.
3. ReplicaSet maintains pod count.
4. Deployment manages ReplicaSet and supports rolling updates.
5. Deployment is preferred over creating standalone pods.

---

# Day 3 - Services And Kubernetes Networking

## 1. Why Service Is Needed

Pod IP is not permanent.

If a pod dies and a new pod is created, the new pod gets a new IP.

Problem:
How will users or other pods access the application?

Solution:
Use Service.

## 2. Service

Service is a stable network endpoint for pods.

Simple meaning:
Service gives one fixed access point for a group of pods.

Flow:

```text
User/Pod ---> Service ---> matching Pods
```

Service selects pods using labels.

## 3. Types Of Services

### ClusterIP

Default service type.

It exposes application only inside the cluster.

Example:
Backend service used by frontend inside cluster.

### NodePort

Exposes service on node IP and port.

NodePort range:

```text
30000 - 32767
```

Example:

```text
node-ip:30080
```

### LoadBalancer

Creates external load balancer in cloud.

Example:
AWS ELB, Azure Load Balancer, GCP Load Balancer.

### ExternalName

Maps Kubernetes service name to external DNS name.

Example:
Kubernetes app accessing outside database DNS.

## 4. Day 3 Service YAML

Deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  namespace: day3
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: nginx
          image: nginx:1.27
          ports:
            - containerPort: 80
```

ClusterIP Service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: day3
spec:
  type: ClusterIP
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```

NodePort Service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-nodeport
  namespace: day3
spec:
  type: NodePort
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30080
```

Commands:

```powershell
kubectl create namespace day3
kubectl apply -f day3-deployment.yaml
kubectl apply -f day3-service.yaml
kubectl get svc -n day3
kubectl get endpoints -n day3
kubectl describe svc web-service -n day3
```

Port forward:

```powershell
kubectl port-forward svc/web-service 8080:80 -n day3
```

Open:

```text
http://localhost:8080
```

## 5. Day 3 Student Task

1. Create deployment with label `app: student-web`
2. Create ClusterIP service for it
3. Check service endpoints
4. Access it using port-forward
5. Create NodePort service
6. Explain difference between port and targetPort

## 6. Day 3 Interview Points

1. Service provides stable IP/DNS for pods.
2. ClusterIP is used for internal communication.
3. NodePort exposes app using node IP and port.
4. LoadBalancer is used mostly in cloud.
5. Service uses selector to send traffic to matching pods.

---

# Day 4 - ConfigMap, Secret, Volumes

## 1. ConfigMap

ConfigMap stores non-confidential configuration data.

Simple meaning:
ConfigMap stores normal app settings.

Example:

```text
APP_MODE=dev
APP_COLOR=blue
```

Create ConfigMap:

```powershell
kubectl create configmap app-config --from-literal=APP_MODE=dev -n day4
```

## 2. Secret

Secret stores sensitive data.

Simple meaning:
Secret is used for passwords, tokens, keys.

Example:

```text
DB_PASSWORD=admin123
```

Create Secret:

```powershell
kubectl create secret generic app-secret --from-literal=DB_PASSWORD=admin123 -n day4
```

## 3. Use ConfigMap And Secret In Pod

YAML:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: config-demo
  namespace: day4
spec:
  replicas: 1
  selector:
    matchLabels:
      app: config-demo
  template:
    metadata:
      labels:
        app: config-demo
    spec:
      containers:
        - name: busybox
          image: busybox:1.36
          command: ["sh", "-c", "echo APP_MODE=$APP_MODE && echo DB_PASSWORD=$DB_PASSWORD && sleep 3600"]
          env:
            - name: APP_MODE
              valueFrom:
                configMapKeyRef:
                  name: app-config
                  key: APP_MODE
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: app-secret
                  key: DB_PASSWORD
```

Commands:

```powershell
kubectl create namespace day4
kubectl create configmap app-config --from-literal=APP_MODE=dev -n day4
kubectl create secret generic app-secret --from-literal=DB_PASSWORD=admin123 -n day4
kubectl apply -f day4-config-demo.yaml
kubectl logs deployment/config-demo -n day4
```

## 4. Volume

Volume is used to provide storage to pods.

Simple meaning:
Volume stores data for containers.

Without volume:
If pod is deleted, container data can be lost.

With volume:
Data can be kept outside container lifecycle.

## 5. PersistentVolumeClaim

PVC is a request for storage.

Simple meaning:
Pod asks Kubernetes for storage using PVC.

## 6. Day 4 Student Task

1. Create ConfigMap with `APP_ENV=student`
2. Create Secret with `PASSWORD=student123`
3. Create Deployment that reads both values
4. Check logs
5. Explain why password should not be stored in ConfigMap

## 7. Day 4 Interview Points

1. ConfigMap stores non-sensitive configuration.
2. Secret stores sensitive data.
3. ConfigMap and Secret can be used as environment variables or mounted files.
4. Volume provides storage to containers.
5. PVC is a request for persistent storage.

---

# Day 5 - Probes, Resource Limits, Debugging

## 1. Probes

Probes are health checks used by kubelet.

Simple meaning:
Kubernetes checks whether the application is alive and ready.

## 2. Liveness Probe

Liveness probe checks whether container is alive.

If liveness probe fails, Kubernetes restarts the container.

Use case:
Application is running but stuck.

## 3. Readiness Probe

Readiness probe checks whether container is ready to receive traffic.

If readiness probe fails, Kubernetes removes pod from service endpoints.

Use case:
Application started but database connection is not ready yet.

## 4. Startup Probe

Startup probe checks whether application has started.

Use case:
Slow starting applications.

## 5. Probe YAML

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-probe
  namespace: day5
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx-probe
  template:
    metadata:
      labels:
        app: nginx-probe
    spec:
      containers:
        - name: nginx
          image: nginx:1.27
          ports:
            - containerPort: 80
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 10
```

## 6. Resource Requests And Limits

Request:
Minimum CPU/memory required by container.

Limit:
Maximum CPU/memory allowed for container.

Example:

```yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "500m"
    memory: "256Mi"
```

## 7. Debugging Commands

```powershell
kubectl get pods -n day5
kubectl get pods -n day5 -o wide
kubectl describe pod <pod-name> -n day5
kubectl logs <pod-name> -n day5
kubectl logs <pod-name> -c <container-name> -n day5
kubectl exec -it <pod-name> -n day5 -- sh
kubectl get events -n day5 --sort-by=.metadata.creationTimestamp
```

Common pod errors:

```text
Pending            ---> pod is not scheduled
ImagePullBackOff   ---> image cannot be pulled
CrashLoopBackOff   ---> container starts and crashes again and again
ErrImagePull       ---> wrong image or registry issue
CreateContainerConfigError ---> config/secret issue
```

## 8. Day 5 Student Task

1. Create deployment with liveness and readiness probe
2. Add CPU and memory requests/limits
3. Break image name intentionally
4. Check error using describe
5. Fix image name and redeploy

## 9. Day 5 Interview Points

1. Liveness probe restarts unhealthy containers.
2. Readiness probe controls whether pod receives traffic.
3. Requests help scheduler place pods.
4. Limits protect cluster resources.
5. `describe`, `logs`, `events`, and `exec` are important debugging commands.

---

# Day 6 - Ingress, Autoscaling, DaemonSet, RBAC

## 1. Ingress

Ingress manages external HTTP/HTTPS access to services inside the cluster.

Simple meaning:
Ingress routes outside web traffic to Kubernetes services.

Flow:

```text
User ---> Ingress Controller ---> Ingress Rule ---> Service ---> Pods
```

Important:
Ingress needs an Ingress Controller.

Common Ingress Controllers:
- NGINX
- Traefik
- HAProxy
- Cloud provider ingress controllers

## 2. Ingress YAML

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
  namespace: day6
spec:
  rules:
    - host: web.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web-service
                port:
                  number: 80
```

Commands:

```powershell
kubectl get ingress -n day6
kubectl describe ingress web-ingress -n day6
```

## 3. Autoscaling

Autoscaling means increasing or decreasing resources based on demand.

Types:
1. Horizontal Pod Autoscaler
2. Vertical Pod Autoscaler
3. Cluster Autoscaler

### HPA

Horizontal Pod Autoscaler increases or decreases pod count.

Example:
If CPU usage is high, HPA increases replicas.

Command:

```powershell
kubectl autoscale deployment web --cpu-percent=50 --min=1 --max=10 -n day6
kubectl get hpa -n day6
```

Note:
HPA needs metrics-server.

## 4. DaemonSet

DaemonSet makes sure one pod runs on every node or selected nodes.

Simple meaning:
If we need same agent on every node, use DaemonSet.

Use cases:
- log collection agent
- monitoring agent
- networking agent
- security agent

DaemonSet YAML:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx-daemonset
  namespace: day6
spec:
  selector:
    matchLabels:
      app: nginx-daemon
  template:
    metadata:
      labels:
        app: nginx-daemon
    spec:
      containers:
        - name: nginx
          image: nginx:1.27
          ports:
            - containerPort: 80
```

Commands:

```powershell
kubectl apply -f daemonset.yaml
kubectl get daemonset -n day6
kubectl get pods -n day6 -o wide
```

## 5. RBAC

RBAC means Role Based Access Control.

Simple meaning:
RBAC controls who can do what in Kubernetes.

Main objects:
1. Role
2. RoleBinding
3. ClusterRole
4. ClusterRoleBinding

Role:
Access inside one namespace.

ClusterRole:
Access across the full cluster.

RoleBinding:
Connects Role to user/service account.

ClusterRoleBinding:
Connects ClusterRole to user/service account.

## 6. Day 6 Student Task

1. Explain ingress in one diagram
2. Create DaemonSet
3. Check one pod per node
4. Create HPA command and explain metrics-server need
5. Explain Role vs ClusterRole

## 7. Day 6 Interview Points

1. Ingress routes HTTP/HTTPS traffic to services.
2. Ingress needs an ingress controller.
3. HPA scales pod count based on metrics.
4. DaemonSet runs one pod on every node.
5. RBAC is used for Kubernetes security and permission control.

---

# Day 7 - Helm And Final Project

## 1. Helm

Helm is a package manager for Kubernetes.

Simple meaning:
Helm helps install Kubernetes applications using charts.

Without Helm:
We apply many YAML files manually.

With Helm:
We package YAML files into one chart and install it easily.

## 2. Helm Terms

Chart:
Package of Kubernetes YAML templates.

Release:
Installed instance of a chart.

values.yaml:
File used to pass custom values to templates.

Template:
YAML file with variables.

## 3. Helm Commands

```powershell
helm version
helm create todo-app
helm install todo ./todo-app
helm list
helm upgrade todo ./todo-app
helm history todo
helm rollback todo 1
helm uninstall todo
```

## 4. Final Project

Project name:

```text
student-todo-app
```

Objects to create:
- Namespace
- Frontend Deployment
- Backend Deployment
- Database Deployment or StatefulSet
- ConfigMap
- Secret
- Service for frontend
- Service for backend
- Service for database
- PVC for database
- Ingress optional
- Helm chart optional

Project flow:

```text
User ---> frontend service ---> frontend pod ---> backend service ---> backend pod ---> database service ---> database pod
```

## 5. Final Project Folder Structure

```text
k8s-learning/
  day1/
    notes.md
    day1-pod.yaml
  day2/
    notes.md
    deployment.yaml
  day3/
    notes.md
    service.yaml
  day4/
    notes.md
    configmap-secret.yaml
  day5/
    notes.md
    probes-resources.yaml
  day6/
    notes.md
    ingress-daemonset-rbac.md
  day7/
    notes.md
    final-project/
```

## 6. Day 7 Student Task

1. Create final project namespace
2. Deploy frontend
3. Deploy backend
4. Deploy database
5. Expose app using service
6. Add ConfigMap and Secret
7. Add health checks
8. Convert YAML to Helm chart
9. Explain project architecture

## 7. Final Interview Explanation

Sample answer:

Kubernetes is a container orchestration platform. In my project, I created a namespace to isolate resources. I deployed frontend, backend, and database using Deployments. I exposed the applications using Services. I used ConfigMap for normal configuration and Secret for sensitive data. I added probes to check application health. I used kubectl commands to debug pods, logs, services, and events. Finally, I packaged the application using Helm so it can be installed and upgraded easily.

---

# Daily Teaching Script

Use this structure while teaching each topic:

1. First explain in simple words.
2. Draw arrow diagram.
3. Give real-time example.
4. Show YAML.
5. Run commands.
6. Break something.
7. Debug it.
8. Give 5 interview points.
9. Give student task.

Example:

```text
Topic: Service

Simple meaning:
Service gives stable access to pods.

Why:
Pod IP changes when pod restarts.

Real example:
Frontend should call backend using backend service name, not pod IP.

Command:
kubectl get svc

Interview point:
Service selects pods using labels and selectors.
```

---

# Command Cheat Sheet

Cluster:

```powershell
kubectl cluster-info
kubectl get nodes
kubectl get pods -A
```

Namespace:

```powershell
kubectl get ns
kubectl create ns dev
kubectl delete ns dev
kubectl config set-context --current --namespace=dev
```

Pods:

```powershell
kubectl get pods
kubectl get pods -o wide
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl exec -it <pod-name> -- sh
```

Deployment:

```powershell
kubectl get deploy
kubectl describe deploy <deployment-name>
kubectl scale deploy <deployment-name> --replicas=3
kubectl rollout status deploy/<deployment-name>
kubectl rollout history deploy/<deployment-name>
kubectl rollout undo deploy/<deployment-name>
```

Service:

```powershell
kubectl get svc
kubectl describe svc <service-name>
kubectl get endpoints
kubectl port-forward svc/<service-name> 8080:80
```

Debug:

```powershell
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl exec -it <pod-name> -- sh
```

Cleanup:

```powershell
kubectl delete -f <file-name>.yaml
kubectl delete ns <namespace-name>
```

---

# Student Notes Rules

1. Write definition in simple words first.
2. Write one real-time example.
3. Write commands with meaning.
4. Keep YAML indentation clean.
5. Do practical immediately after theory.
6. Keep one interview answer after every topic.
7. Do not memorize only commands; understand object flow.

