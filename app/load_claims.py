from google.cloud import bigquery
import pandas as pd

QUERY = """
SELECT
    *
FROM `gcp-internship-prep.dataset_name.claims`
WHERE claim_id IS NOT NULL 
LIMIT 50
"""


def load_claims() -> pd.DataFrame:
    client = bigquery.Client(project="gcp-internship-prep")
    df = client.query(QUERY).to_dataframe()
    return df


if __name__ == "__main__":
    df = load_claims()

    print(df.shape)
    print(df.head())
    print(df.dtypes)
    print(df["was_denied"].value_counts())