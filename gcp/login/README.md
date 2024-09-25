# Hashicorp Terraform GCP

# Terraform Backend for state files in GCP

- Login with gcloud wih your service account
```commandline
gcloud auth activate-service-account --key-file=<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY.json>
```

- Bucket creation with gsutil
```commandline
gsutil mb --project PROJECTID gs://<YOUR_BUCKET_NAME>/
gcloud config set project playground-s-11-21b140e7
gsutil mb gs://cloudgeeks-terraform/
```

- Gcp List buckets
```commandline
export GOOGLE_APPLICATION_CREDENTIALS="<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY.json>"
export GOOGLE_APPLICATION_CREDENTIALS=/mnt/gcp/gcp.json
export PROJECT_ID=playground-s-11-21b140e7
gsutil ls -p playground-s-11-d1ce4ef2
```

- Enable versioning for the bucket
```commandline
gsutil versioning set on gs://<YOUR_BUCKET_NAME>/
gsutil versioning set on gs://cloudgeeks-terraform/
```

- Provider configuration
```commandline
credentials = file("<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY.json>")
project     = "<YOUR_PROJECT_ID>"
region      = "<YOUR_REGION>"
export GOOGLE_APPLICATION_CREDENTIALS="<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY.json>"
export GOOGLE_APPLICATION_CREDENTIALS=/mnt/gcp/gcp.json
export GOOGLE_PROJECT=playground-s-11-47a8ae67

make sure to enable gcp api

gcloud config set project VALUE
gcloud config set project playground-s-11-21b140e7

export CLOUDSDK_CORE_PROJECT=playground-s-11-47a8ae67
gcloud services enable compute.googleapis.com
```

- GKE Enable Required APIS
```bash
gcloud services enable container.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable monitoring.googleapis.com
gcloud services enable logging.googleapis.com
```

- GCP Enable APIs
```commandline
gcloud services enable compute.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable dns.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable storage-api.googleapis.com
gcloud services enable storage-component.googleapis.com
gcloud services enable cloudkms.googleapis.com
gcloud services enable cloudfunctions.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable containerregistry.googleapis.com
gcloud services enable servicenetworking.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
```

### tfvars file
```commandline
terraform plan -var-file="vpc.tfvars" -out=tfplan
terraform show tfplan
terraform apply -var-file="vpc.tfvars"
```