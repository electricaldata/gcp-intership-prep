from pathlib import Path

import joblib
import pandas as pd

print("the script runs")

# Lets us apply different preprocessing steps to different columns
from sklearn.compose import ColumnTransformer

# The machine learning model we will train for classification
from sklearn.ensemble import RandomForestClassifier

# Tools to evaluate how well the classification model performed
from sklearn.metrics import classification_report, roc_auc_score

# Splits the data into training and testing sets
from sklearn.model_selection import train_test_split

# Chains preprocessing and modeling steps into one clean workflow
from sklearn.pipeline import Pipeline

# Converts categorical text columns into numeric columns
from sklearn.preprocessing import OneHotEncoder

from app.load_claims import load_claims

MODEL_PATH = Path(__file__).parent / "model.joblib"

def train_model() -> Pipeline:
    df = load_claims()

    target = "was_denied"

    feature_cols = [
    "provider_id",
    "payer_id",
    "patient_age_bucket",
    "service_line",
    "procedure_group",
    "claim_amount",
    "allowed_amount",
    "patient_responsibility",
    "days_to_submit",
    "prior_auth_required",
    "prior_auth_present",
    "eligibility_verified",
    ]

    numeric_features = [
    "claim_amount",
    "allowed_amount",
    "patient_responsibility",
    "days_to_submit",
    ]

    categorical_features = [
    "provider_id",
    "payer_id",
    "patient_age_bucket",
    "service_line",
    "procedure_group",
    ]

    binary_features = [
    "prior_auth_required",
    "prior_auth_present",
    "eligibility_verified",
    ]

    X = df[feature_cols]
    y = df[target]

    preprocessor = ColumnTransformer(
        transformers=[
            ("num", "passthrough", numeric_features),
            ("cat", OneHotEncoder(handle_unknown="ignore"), categorical_features),
            ("bin", "passthrough", binary_features),
        ]
    )

    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=.20,
        random_state=42,
        stratify=y,
    )

    # Train 100 trees
    # Make results repeatable so the split/tree randomness is the same each run
    #
    model = RandomForestClassifier(
        n_estimators=100,
        random_state=42,
        class_weight="balanced",
    )

    pipeline = Pipeline(
        steps=[
            ("preprocessor", preprocessor),
            ("model", model),
        ]
    )

    pipeline.fit(X_train, y_train)

    y_pred = pipeline.predict(X_test)
    y_prob = pipeline.predict_proba(X_test)[:, 1]

    print(classification_report(y_test, y_pred))
    print("ROC AUC:", roc_auc_score(y_test, y_prob))

    return pipeline


def save_model(model: Pipeline) -> None:
    joblib.dump(model, MODEL_PATH)


if __name__ == "__main__":
    trained_model = train_model()
    save_model(trained_model)
    print(f"Saved model to {MODEL_PATH}")