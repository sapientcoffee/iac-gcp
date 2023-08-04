# Cloud Resource Accelerator (CRA)
This is some examples/demos of me playing with CRA to better understand its capabilities.

https://github.com/bkauf/cloud-resource-accelerator/blob/main/samples/gcp-gke-nodepool.yaml


## Setup
Enable APIs;
```
gcloud services enable krmapihosting.googleapis.com \
container.googleapis.com  \
cloudresourcemanager.googleapis.com \
serviceusage.googleapis.com
```

If going to use on EKS/AKS aslo enable;
```
gcloud services enable gkemulticloud.googleapis.com
gcloud services enable gkeconnect.googleapis.com
gcloud services enable connectgateway.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable anthos.googleapis.com
gcloud services enable logging.googleapis.com
gcloud services enable monitoring.googleapis.com
gcloud services enable opsconfigmonitoring.googleapis.com
```

```
export PROJECT_ID=iac-playpen
export ACP_CLUSTER_NAME=resource-accelerator
```


Create a CRA cluster in Google Cloud that will use as a fleet project

```
gcloud alpha anthos config controller create ${ACP_CLUSTER_NAME} \
  --location europe-west1 \
  --master-ipv4-cidr-block="172.16.10.0/28" \
  --experimental-features CRA 
  ```


Will take upto 15 minutes.

Connect the the CRA instance after creation:
```
gcloud container clusters get-credentials krmapihost-${ACP_CLUSTER_NAME} --region europe-west1 --project ${PROJECT_ID}
```

Setup Google Cloud auth with workload identity 
```
export SA_EMAIL="$(kubectl get ConfigConnectorContext -n config-control \
-o jsonpath='{.items[0].spec.googleServiceAccount}' 2> /dev/null)"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member "serviceAccount:${SA_EMAIL}" \
    --role "roles/owner" \
    --project $PROJECT_ID
```

## Examples

Spin up and down infra

### Google Cloud

Some examples;
 * [GKE Cluster](./demos/gcp-gke.yaml)
 * [GKE Nodepool](./demos/gcp-gke-nodepool.yaml)


[Supported](https://cloud.google.com/anthos/clusters/docs/multi-cloud/crx/googlecloud/table) Google Cloud Resources.

#### Create

#### Delete

#### Update

#### Import Existing Cluster



#### Kustomize

`kubectl get managed`
`kubectl apply --dry-run=client -o yaml -k ./demos`
`kubectl apply -k ./demos`