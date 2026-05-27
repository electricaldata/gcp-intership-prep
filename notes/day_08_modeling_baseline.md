What “baseline model” means:

Its purpose is to answer:

Can the full modeling workflow run end-to-end?
Can we get reasonable metrics?
Can we save a model artifact?
Do we have a reference point for future improvements?


precision = when the model predicts denial, how often is it right?
recall = out of all actual denials, how many did the model catch?

If a denied claim is expensive to miss, recall matters.
If staff can only review a small number of claims, precision matters.

ROC AUC is a general ranking metric. It asks:
Can the model generally rank denied claims as riskier than non-denied claims?

What is my target?
What columns are safe features?
Which are numeric/categorical/binary?
What should X be?
What should y be?
What needs encoding?
What should be saved?


## What is `joblib`?

`joblib` is a Python library commonly used to **save and load Python objects**, especially machine learning models.

It is often used with `scikit-learn` because it can efficiently store models, pipelines, encoders, scalers, and other fitted objects.


END OF DAY 8:
The pipeline works, but the synthetic data is probably too deterministic/easy. The point was the baseline workflow, not realistic performance yet.

BigQuery claims data
→ Python loader
→ pandas DataFrame
→ feature/target split
→ preprocessing
→ train/test split
→ baseline model
→ evaluation metrics
→ saved model artifact

stratify=y was used so the denied/not-denied ratio stays similar in both train and test sets.

The baseline model was a RandomForestClassifier.

The purpose of a baseline is to answer:

Can the modeling pipeline run end-to-end?
Can the model train successfully?
Can the model make predictions?
Can the model produce metrics?
Can the model be saved for later use?




Recall

Recall answers:

Out of all actual denied claims, how many did the model catch?

High recall means the model misses fewer denials.

F1-score

F1-score balances precision and recall.

Support

Support means how many actual examples existed for each class in the test set.

ROC AUC

ROC AUC measures how well the model ranks denied claims as riskier than non-denied claims.



`X = df[feature_cols]` selects the model input features, while `y = df[target]` selects the target column.

Feature lists should contain column-name strings, not full pandas Series like `df["claim_amount"]`.

`ColumnTransformer` applies different preprocessing to numeric, categorical, and binary feature groups.

`OneHotEncoder(handle_unknown="ignore")` converts categories into numeric columns and avoids crashing on new future categories.

`train_test_split(..., stratify=y)` keeps the target balance similar in training and testing data.

`Pipeline` chains preprocessing and modeling into one reusable object.

`predict_proba(X_test)[:, 1]` returns the predicted probability of denial.

`joblib.dump(model, MODEL_PATH)` saves the trained pipeline for later use.