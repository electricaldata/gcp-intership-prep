Before I trust a model, I need to understand the data.

But before modeling, you need to know:

What am I predicting?
Is the target balanced?
Which columns seem useful?
Which columns are dangerous leakage?
Do the patterns match the business story?

load data
→ understand row grain
→ inspect target
→ check feature patterns
→ look for leakage
→ only then model

EDA means: 
Can I inspect the data well enough to know what is safe, useful, suspicious, or broken?

How many claims do I have?
How many are denied?
Do some payers deny more?
Do some service lines deny more?
Does missing prior auth matter?
Does eligibility verification matter?
Do high-dollar claims behave differently?
Is any column leaking the answer?


Do not assume the data has the pattern.
Check it.

A good notebook should have:
1. Load data
2. Basic shape/head/dtypes
3. Target balance
4. Denial rate by payer
5. Denial rate by service line
6. Prior auth analysis
7. Eligibility analysis
8. Claim amount analysis
9. Leakage audit
10. Short written findings

A good EDA answers four questions:

```text
1. What is one row?
2. What is the target?
3. Which features seem useful?
4. Which columns are unsafe or suspicious?

One of the most important EDA jobs is finding leakage.

A leakage column is a column that gives away the answer or would only be known after the prediction moment.

count = how many examples are in each group
mean = average value or rate
min/max = range of values
median = typical value less affected by outliers
standard deviation = spread/variability


GOOD EXPLANATION TO BOSSES:
The denial rate is 42%, the target is not severely imbalanced, payer and service-line patterns show differences in denial rates, and claim_status appears to be leakage because it reveals the target after adjudication.