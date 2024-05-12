-- PERFORM THIS QUERY TO ADD SOME TABLE FOR ADVANCED ANALYTIC
-- PLEASE MAKE SURE THAT YOU ASSIGN CORRECT DATA TYPE REFER TO BIGQUERY DOCUMENTATION
-- AS MYSQL AND BIGQUERY DATA TYPE IS LITTLE BIT DIFFERENT


-- add nett_sales column and set its data type
ALTER TABLE `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Final Transaction`
ALTER COLUMN nett_sales SET DATA TYPE FLOAT64;

-- update and assign value of nett_sales column
UPDATE `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Final Transaction`
SET nett_sales = price - (price * discount_percentage)
WHERE nett_sales IS NULL;

-- add persentase_gross_laba column and set its data type
ALTER TABLE `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Final Transaction`
ADD COLUMN persentase_gross_laba STRING;

-- update and assign value of persentase_gross_laba column
UPDATE `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Final Transaction`
SET persentase_gross_laba = 
  CASE
    WHEN nett_sales < 50000 THEN 'laba 10%'
    WHEN nett_sales > 50000 AND nett_sales <100000 THEN 'laba 15%'
    WHEN nett_sales > 10000 AND nett_sales <300000 THEN 'laba 20%'
    WHEN nett_sales > 30000 AND nett_sales <500000 THEN 'laba 25%'
    ELSE 'laba 30%'
  END
WHERE persentase_gross_laba IS NULL;

-- add nett_profit column and set its data type
ALTER TABLE `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Final Transaction`
ADD COLUMN nett_profit FLOAT64;

-- update and assign value of nett_profit column
UPDATE `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Final Transaction`
SET nett_profit = 
  CASE
    WHEN persentase_gross_laba = 'laba 10%' THEN nett_sales * 0.1
    WHEN persentase_gross_laba = 'laba 15%' THEN nett_sales * 0.15
    WHEN persentase_gross_laba = 'laba 20%' THEN nett_sales * 0.2
    WHEN persentase_gross_laba = 'laba 25%' THEN nett_sales * 0.25
    ELSE nett_sales*0.3
  END
WHERE nett_profit IS NULL;

-- I do LEFT JOIN on LOOKER STUDIO between Final Transaction and Kantor Cabang table