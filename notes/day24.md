Day 24 - Kubernetes Namespaces and Deployments

Date: 13 Nov 2026 Where: controller EC2 (class cluster, 3 EC2s). All commands run in any directory.

Short version

A namespace is a folder inside the cluster. A deployment keeps a set number of pod copies running.

Part 1: Namespaces

• kubectl get namespaces shows 4 built-in ones: default, kube-system, kube-public, kube-node-lease.

• kubectl create namespace dev makes my own.

• kubectl run web --image=nginx -n dev starts a pod called web inside dev.

• kubectl get pods -n dev shows it Running.

• kubectl get pods (no -n) shows nothing, because it only looks in default.

• kubectl delete namespace dev removes the folder and everything inside it, pods included.

Key ideas:

• -n name only picks which namespace the command works in. Without it, the command uses default.

• The pod name (web) is just a label. It has nothing to do with what runs inside. The image decides that.

• kubectl get pods -n kube-system shows Kubernetes' own parts (look, do not delete). I saw calico-kube-controllers and calico-node there.

• Calico is the network plug-in. It gives pods addresses and lets them talk across the EC2s. It does not manage Kubernetes.

Part 2: Deployments

• kubectl create deployment web --image=nginx makes a deployment. The type is deployment, web is its name.

• kubectl get deployments shows READY 1/1 (1 wanted, 1 running).

• The pod gets a name like web-76fd95c67-xxxxx. The deployment adds the extra letters.

• Deleting that pod: the deployment makes a new one straight away, with new letters.

• kubectl scale deployment web --replicas=3 changes the copies to 3.

• kubectl scale deployment web --replicas=1 brings it back down to 1.

• To really stop it, delete the deployment: kubectl delete deployment web.

Mini project: two rooms, one app each

1.  Made namespaces dev and prod.

2.  kubectl create deployment site --image=nginx -n dev

3.  Same command with -n prod.

4.  kubectl scale deployment site --replicas=3 -n prod

5.  kubectl get pods -n dev showed 1 pod, kubectl get pods -n prod showed 3.

Result: same deployment name, no clash, because each lives in its own namespace.

Cleanup: kubectl delete namespace dev prod (two names in one command). Only the 4 built-in namespaces were left.

Mistakes I made

• Typed kebectl and kubeclt. The tool is spelled k-u-b-e-c-t-l.

• Wrote --replica instead of --replicas (two dashes, s at the end).

• Cut kube-system short to system. The full name has the dash.

• Thought kubectl deployment alone was enough. It needs create, then the type, name and image.

• Thought Calico manages Kubernetes. It only handles the network.

Learned in one line each

• Namespace = folder in the cluster.

• Deleting a namespace deletes everything inside it.

• Deployment = manager that always keeps the number of copies I asked for.

• Delete a pod and the deployment brings it back. Delete the deployment to stop it.

