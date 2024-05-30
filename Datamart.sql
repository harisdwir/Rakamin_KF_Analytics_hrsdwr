 --PERFORM THIS QUERY TO CREATE A DATAMART FOR FURTHER DATA ANALYSIS
-- USE COMMON TABLE EXPRESSION TO IMPROVE CODE READABILITY AND QUERYING PERFORMANCE
/* SINCE BIG QUERY DOESN'T ALLOW USING CREATE TABLE COMMAND WITHIN A QUERY THAT INCLUDE CTE DIRECTLY,
EXPORT THE RESULT INTO NEW TABLE USING SAVE RESULTS MENU
*/

WITH analytic_table AS (
 SELECT
 FT.transaction_id,
 FT.date,
 KC.branch_id,
 KC.branch_name,
 KC.kota as Kota,
 KC.provinsi as Provinsi,
 KC.rating AS rating_cabang,
 FT.customer_name,
 FT.product_id,
 PD.product_name,
 FT.price AS actual_price,
 FT.discount_percentage,
 FT.persentase_gross_laba,
 FT.nett_sales,
 FT.nett_profit,
 FT.rating AS rating_transaksi
 FROM
 `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Final Transaction` AS FT
 LEFT JOIN
 `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Kantor Cabang` AS KC
 ON
 FT.branch_id = KC.branch_id
 LEFT JOIN
 `rakamin-kf-analytics-hrsdwr.Kimia_Farma.Product` AS PD
 ON
 FT.product_id = PD.product_id
)
SELECT * FROM analytic_table; -- to retrieve all the data from the CTE command
