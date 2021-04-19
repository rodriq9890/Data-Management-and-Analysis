-- 1. This query shows that the columns product_code and description are related by having each product code relate to the same description across the table.
SELECT product_code, description, COUNT(product_code) AS product_code_count, count(description) AS description_count
FROM staging_caers_event GROUP BY product_code, description ORDER BY product_code;

-- 2. this query tries to determine whether or not report id is unique
SELECT (CASE WHEN COUNT(*) = COUNT(DISTINCT report_id) THEN 'TRUE' ELSE 'FALSE' END) as Equal FROM staging_caers_event;

-- 3. This query will return the count of every column to see if they're related in any way
SELECT COUNT(DISTINCT report_id) "distinct report_id",
       COUNT(DISTINCT created_date) "distinct created_date",
       COUNT(DISTINCT event_date) "distinct event_date",
       COUNT(DISTINCT product_type) "distinct product_type",
       COUNT(DISTINCT product) "distinct product",
       COUNT(DISTINCT product_code) "distinct product_code",
       COUNT(DISTINCT description) "distinct description",
       COUNT(DISTINCT patient_age) "distinct patient_age",
       COUNT(DISTINCT age_units) "distinct age_units",
       COUNT(DISTINCT sex) "distinct sex",
       COUNT(DISTINCT terms) "distinct terms",
       COUNT(DISTINCT outcomes) "distinct outcomes"
  FROM staging_caers_event;

-- 4. Getting every column name and their respective data types
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'staging_caers_event';