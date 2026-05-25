Todays order:

1. sql/07_claims_seed_or_explore.sql
2. sql/07_training_features_claims.sql
3. app/load_claims.py
4. notes/day_07_claims_bigquery.md


Google Cloud Project
└── BigQuery
    └── intern_prep dataset
        └── claims table


What is one row in this table?
One claim. 

What is the prediction target?
whether the claim is denied or not. 

What columns would be known before denial?
payer, provider, start date, auth.

What columns would only be known after denial? 
status, decision time, rate of denial. 


BigQuery claims table
→ SQL exploration
→ claim-level feature thinking
→ Python loader
→ pandas DataFrame
→ ready for EDA/modeling


Provider performs service
→ claim is created/submitted
→ payer/insurance reviews it
→ claim gets paid, denied, adjusted, etc.

The main business question we are trying to answer is:
Can we identify risky claims before the payer denies them?

Missing prior authorization can increase denial risk.
Eligibility not verified can increase denial risk.
Some payers may deny more often.
Some service lines may be more complex.
High claim amounts may get more scrutiny.
Late submissions may be riskier.

CASE lets me turn raw values into business buckets.
Example:

claim_amount
→ amount bucket
→ count claims
→ compare denial rate

project.dataset.table
gcp-internship-prep.dataset_name.claims

gcloud auth application-default login
gcloud auth application-default set-quota-project gcp-internship-prep


## GCP Intuition

GCP is the cloud environment that sits around the code. In this workflow, BigQuery is the managed cloud database, the GCP project is the container that owns the resources, and billing/permissions determine whether code is allowed to read or write data.

A key idea is that the browser and local Python are two separate access paths into the same cloud project. BigQuery in the browser works through the logged-in Google account, but Python running in VS Code needs local credentials. The command `gcloud auth application-default login` creates Application Default Credentials so local Python libraries can authenticate to GCP.

The mental model is:

```text
VS Code Python
→ local credentials from gcloud
→ GCP project
→ BigQuery
→ pandas DataFrame

So when a Python script runs bigquery.Client(), it is not magically connected to Google Cloud. It looks for credentials, determines the project, sends the SQL query to BigQuery, and then downloads the result into Python.