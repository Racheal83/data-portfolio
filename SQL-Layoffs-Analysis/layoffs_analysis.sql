
-- Global Layoffs Data Cleaning & Exploratory SQL Analysis

-- Step 1: Create a staging table to preserve the raw data
CREATE TABLE layoffs_staging LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- Step 2: Remove duplicates using ROW_NUMBER() with a staging table
CREATE TABLE layoffs_staging2 AS
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE FROM layoffs_staging2
WHERE row_num > 1;

-- Standardize company names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Standardize industry values
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Clean up country names
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Convert and clean the date column
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- Replace blank industry entries with NULL
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Fill NULL industry values based on same company/location
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
 AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Delete rows where both total_laid_off and percentage_laid_off are NULL
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Remove row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Exploratory Data Analysis

-- Max values
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Companies with 100% layoffs
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Company layoffs summary
SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;

-- Layoff date range
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Industry with most layoffs
SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_laid_off DESC;

-- Country with most layoffs
SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;

-- US locations with most layoffs
SELECT country, location, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE country = 'United States'
GROUP BY country, location
ORDER BY total_laid_off DESC;

-- Yearly layoffs
SELECT YEAR(`date`) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY year DESC;

-- Company stages with highest layoffs
SELECT company, stage, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, stage
ORDER BY total_laid_off DESC;

-- Monthly layoff totals
SELECT DATE_FORMAT(`date`, '%Y-%m') AS `month`, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY `month`
ORDER BY `month` DESC;

-- Rolling total
WITH rolling_total AS (
  SELECT DATE_FORMAT(`date`, '%Y-%m') AS `month`, SUM(total_laid_off) AS total_off
  FROM layoffs_staging2
  GROUP BY `month`
)
SELECT `month`, total_off,
       SUM(total_off) OVER(ORDER BY `month`) AS cumulative_total
FROM rolling_total;

-- Company layoffs by year
SELECT company, YEAR(`date`) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, year
ORDER BY company ASC;

-- Top 5 companies by layoffs per year
WITH company_year AS (
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, years
),
company_year_rank AS (
  SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM company_year
  WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE ranking <= 5;
