

# COUNTRIES WITH A CORRUPTION INDEX HIGHER THAN 60; SORTED ALPHABETICALLY.

SELECT CONCAT(country , '____' , MAX(corruption_index)) AS " Countries with the highest corruption index "
  FROM economy.corruption 
  GROUP BY country , annual_income
 HAVING MAX(corruption_index) > 60
  ORDER BY country ;
  
# COUNTRIES with A PURCHASING POWER HIGHER THAN 90 AND AN UNEMPLOYMENT RATIO LOWER THAN 4.
  
  SELECT l.country , l.purchasing_power_index , u.unemployment_rate
  FROM economy.living l
   JOIN  economy.unemployment u 
   ON l.country = u.country 
WHERE l.purchasing_power_index > 90 and u.unemployment_rate < 5 ;

#  THE RICHEST COUNTRIES WITH A TOURISM GDP INDEX HIGHER THAN 6.0.

SELECT country AS " Higher Tourism GDP " 
  FROM economy.richest
WHERE country in (
     SELECT country 
	   FROM economy.tourism
     WHERE percentage_of_gdp > 6.0
) ; 

#  COUNTRIES WITH A CORRUPTION RATE HIGHER THAN 60% AND AN UNEMPLOYMENT RATE HIGHER THAN 20%.

SELECT c.country , c.corruption_index , u.unemployment_rate
  FROM economy.corruption c
  RIGHT JOIN economy.unemployment u  
  ON c.country = u.country
WHERE c.corruption_index >= 60 AND u.unemployment_rate >= 20 ;

 # THE MOST PROSPEROUS COUNTRIES ACCORDING TO PURCHASING POWER AND GDP PER CAPITA.

SELECT  l.country AS " Most prosperous countries in 2022 " 
  FROM economy.living l 
  JOIN economy.richest r 
  ON l.country = r.country 
WHERE l.purchasing_power_index >= 80 AND r.gdp_per_capita > 70000
 ORDER BY l.country ;
 
# THE COUNTRY WITH THE LOWEST MONTHLY INCOME PER CAPITA.

SELECT country
  FROM economy.living
WHERE monthly_income <= ALL (
     SELECT monthly_income
       FROM economy.living 
) ;   
   
# THE COUNTRY WITH THE HIGHEST COST INDEX.

SELECT country
  FROM economy.living
WHERE cost_index >= ALL (
     SELECT cost_index
       FROM economy.living 
) ;

# THE TOTAL NUMBER OF COUNTRIES THAT MAKE UP THE RICHEST LIST AND THE TOTAL SUM OF THEIR GDP.

SELECT CONCAT(COUNT(COUNTRY), '--------->' , SUM(gdp_per_capita)) AS " Number of countries and their total sum of GDP per capita "
  FROM economy.richest ;
  
  # COUNTRIES THAT RECEIVE THE MOST TOURISTS (+30B) AND HAVE A CORRUPTION INDEX OF +12.

SELECT t.country , MAX(t.receipts_in_billions) , c.corruption_index
  FROM economy.tourism t
  JOIN economy.corruption c
  ON t.country = c.country 
WHERE  c.corruption_index > 12
GROUP BY t.country , c.corruption_index
HAVING  MAX(t.receipts_in_billions) > 30
 ORDER BY c.corruption_index desc ;

# COUNTRIES WITH A GDP PER CAPITA OF LESS THAN 40,000 AND NOT STARTING WITH THE LETTER "D".

SELECT CONCAT(country , '____' ,SUM(gdp_per_capita)) AS " GDP per capita less than 40MIL "
  FROM economy.richest
WHERE country not like 'D%' 
 GROUP BY country
 HAVING SUM(gdp_per_capita) <40000
  ORDER BY country ;
  