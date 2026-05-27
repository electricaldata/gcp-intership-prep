-- Day 9: Feature Engineering + Leakage Audit

SELECT
  claim_id,
  provider_id,
  payer_id,
  patient_age_bucket,
  service_line,

  claim_amount,
  prior_auth_required,
  procedure_group,

  SAFE_DIVIDE(allowed_amount, claim_amount) AS allowed_to_claim_ratio,
  SAFE_DIVIDE(patient_responsibility, claim_amount) AS patient_responsibility_ratio,

  submitted_at,
  eligibility_verified,
  prior_auth_present,
  days_to_submit,

  CASE
    WHEN prior_auth_required = 1 AND prior_auth_present = 0 THEN 1
    ELSE 0
  END AS auth_required_and_not_present,

  CASE
    WHEN eligibility_verified = 0 THEN 1
    ELSE 0
  END AS missing_eligibility_flag,

  CASE
    WHEN days_to_submit > 30 THEN 1
    ELSE 0
  END AS late_submission_flag,

  EXTRACT(MONTH FROM submitted_at) AS months,
  EXTRACT(DAYOFWEEK FROM submitted_at) AS days,
  days_to_submit,
  was_denied
  

FROM `gcp-internship-prep.dataset_name.claims`
WHERE was_denied IS NOT NULL;