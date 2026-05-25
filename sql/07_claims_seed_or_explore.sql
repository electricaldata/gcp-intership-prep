-- ============================================================
-- Day 7 - Claims BigQuery Setup
-- File: sql/07_claims_seed_or_explore.sql
-- ============================================================


-- Problem 1 - Explore healthcare/public datasets

SELECT
  table_name
FROM `bigquery-public-data.cms_medicare.INFORMATION_SCHEMA.TABLES`
ORDER BY creation_time;


-- Problem 2 - Inspect columns from one table

SELECT
  column_name,
  data_type
FROM `bigquery-public-data.cms_medicare.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'actual_table_name_from_problem_1'
ORDER BY ordinal_position;


-- Problem 3 - Create your dataset if needed

CREATE SCHEMA IF NOT EXISTS `gcp-internship-prep.dataset_name`;


-- Problem 4 - Create your own fake claims table

CREATE OR REPLACE TABLE `gcp-internship-prep.dataset.dataset_name` (
  claim_id STRING,
  provider_id STRING,
  payer_id STRING,
  patient_age_bucket STRING,
  service_line STRING,
  procedure_group STRING,
  claim_amount FLOAT64,
  allowed_amount FLOAT64,
  patient_responsibility FLOAT64,
  days_to_submit INT64,
  prior_auth_required INT64,
  prior_auth_present INT64,
  eligibility_verified INT64,
  submitted_at DATE,
  claim_status STRING,
  was_denied INT64
);


-- Problem 5 - Insert synthetic claims

INSERT INTO `___.___.___`
SELECT
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___,
  ___
FROM UNNEST(GENERATE_ARRAY(___, ___));


-- Problem 6 - Check row count

SELECT
  COUNT(*)
FROM `___.___.___`;


-- Problem 7 - Preview the claims tableok

SELECT
  *
FROM `___.___.___`
LIMIT ___;


-- Problem 8 - Check denial target balance

SELECT
  ___,
  COUNT(*)
FROM `___.___.___`
GROUP BY ___
ORDER BY ___;


-- Problem 9 - Check denial rate by payer

SELECT
  ___,
  COUNT(*),
  AVG(___)
FROM `___.___.___`
GROUP BY ___
ORDER BY ___;


-- Problem 10 - Check denial rate by service line

SELECT
  ___,
  COUNT(*),
  AVG(___)
FROM `___.___.___`
GROUP BY ___
ORDER BY ___;


-- Problem 11 - Check prior authorization pattern

SELECT
  ___,
  ___,
  COUNT(*),
  AVG(___)
FROM `___.___.___`
GROUP BY ___, ___
ORDER BY ___, ___;


-- Problem 12 - Check eligibility verification pattern

SELECT
  ___,
  COUNT(*),
  AVG(___)
FROM `___.___.___`
GROUP BY ___
ORDER BY ___;


-- Problem 13 - Check late submission pattern

SELECT
  CASE
    WHEN ___ THEN ___
    ELSE ___
  END,
  COUNT(*),
  AVG(___)
FROM `___.___.___`
GROUP BY ___
ORDER BY ___;


-- Problem 14 - Check claim amount bucket pattern

SELECT
  CASE
    WHEN ___ THEN ___
    WHEN ___ THEN ___
    WHEN ___ THEN ___
    ELSE ___
  END,
  COUNT(*),
  AVG(___)
FROM `___.___.___`
GROUP BY ___
ORDER BY ___;


-- Problem 15 - Leakage audit

SELECT
  ___,
  ___,
  COUNT(*)
FROM `___.___.___`
GROUP BY ___, ___
ORDER BY ___;