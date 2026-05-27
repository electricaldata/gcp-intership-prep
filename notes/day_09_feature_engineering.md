A raw column says:

prior_auth_required = 1
prior_auth_present = 0

A better feature says:

missing_required_prior_auth = 1

That second one is more direct. It tells the model:
“Hey, this claim had a required authorization, but the authorization was missing.”

That is the whole point of Day 9.

Before adding a feature, ask:

1. Is this known before the payer makes a decision?
2. Does this describe claim risk?
3. Would this exist in production at prediction time?
4. Is this secretly the answer in disguise?

Why ratios matter:

claim_amount alone = how much was billed
allowed_amount / claim_amount = how much of the billed amount is allowed
patient_responsibility / claim_amount = how much of the bill shifts to patient responsibility

Data Leakage:
Do not memorize this. Use the rule:

Could I know this before the payer decides the claim?

If yes:

safe


Use this rule only:

Could I know this before the payer decides the claim?

If yes:

safe

If no:

leakage


payer/provider/service info
claim amount info
prior auth info
eligibility info
submission timing info
engineered flags
engineered ratios, if known before adjudication



## Leakage Audit

| Column | Safe, Leakage, or Depends? | Why? |
|---|---|---|
| claim_amount | Safe | The billed claim amount is known when the claim is submitted. |
| payer_id | Safe | The payer/insurance company is known before adjudication. |
| service_line | Safe | The type of service is known before the payer decision. |
| prior_auth_present | Safe | If captured before submission, it tells whether authorization documentation was present. |
| eligibility_verified | Safe | If checked before submission, it is a pre-adjudication operational signal. |
| denial_reason | Leakage | This only exists after a claim is denied. |
| claim_status | Leakage | This directly reveals whether the claim was denied, paid, or pending. |
| adjudicated_at | Leakage | Adjudication happens after the payer has made a decision. |
| paid_at | Leakage | Payment timing is only known after the claim is processed. |
| days_to_submit | Safe | Once the claim is submitted, the submission delay is known before adjudication. |
| appeal_submitted_at | Leakage | Appeals usually happen after a denial. |
| amount_paid | Leakage | The paid amount is only known after the payer processes the claim. |

## Features I would allow into the model before adjudication

| Feature | Why it is safe |
|---|---|
| claim_amount | Known at submission and may indicate financial risk. |
| payer_id | Known before adjudication and different payers may have different denial patterns. |
| service_line | Known before adjudication and some services may carry higher denial risk. |
| procedure_group | Known before adjudication and may capture complexity of the claim. |
| prior_auth_required | Known before adjudication and signals whether authorization rules apply. |
| prior_auth_present | Known before adjudication if documentation is checked before submission. |
| eligibility_verified | Known before adjudication if eligibility is checked before submission. |
| days_to_submit | Known once the claim is submitted and may capture late-filing risk. |
| allowed_to_claim_ratio | Safe only if allowed_amount is estimated or known before adjudication in this synthetic workflow. |
| patient_responsibility_ratio | Safe only if patient responsibility is estimated or known before adjudication in this synthetic workflow. |
| missing_prior_auth_flag | Built from pre-adjudication prior authorization fields. |
| missing_eligibility_flag | Built from pre-adjudication eligibility verification. |
| late_submission_flag | Built from days_to_submit, which is known once submitted. |
| submitted_month | Built from submitted_at, which is known at submission. |
| submitted_day_of_week | Built from submitted_at, which is known at submission. |

