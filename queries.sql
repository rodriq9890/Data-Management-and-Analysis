-- 1. the total number of rows in the database
SELECT count(*) AS exact_count FROM public.soccer_sales;

-- 2. show the first 15 rows, but only display 3 columns (your choice)
SELECT name, position, transfer_fee FROM public.soccer_sales LIMIT 3;

-- 3. do the same as above, but chose a column to sort on, and sort in descending order
SELECT name, position, transfer_fee FROM public.soccer_sales ORDER BY transfer_fee DESC LIMIT 3;

-- 4. add a new column without a default value
ALTER TABLE public.soccer_sales ADD COLUMN over_100_million BOOLEAN;

-- 5. set the value of that new column
UPDATE public.soccer_sales SET over_100_million = transfer_fee>100000000;

-- 6. show only the unique (non duplicates) of a column of your choice
SELECT DISTINCT position FROM public.soccer_sales;

-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group
SELECT name, COUNT(name) FROM homework06.public.soccer_sales GROUP BY name ORDER BY count(name) DESC LIMIT 20;

-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups
SELECT team_to, sum(transfer_fee) AS total_paid FROM homework06.public.soccer_sales GROUP BY team_to
HAVING SUM(transfer_fee)>1000000000 ORDER BY total_paid DESC;

-- 9. Top 10 teams that made the most from selling players.
SELECT team_from, sum(transfer_fee) AS sold_for FROM homework06.public.soccer_sales
GROUP BY team_from ORDER BY sold_for DESC LIMIT 10;

-- 10. Average price for each position in descending order.
SELECT position, sum(transfer_fee)/COUNT(position) AS average
FROM homework06.public.soccer_sales GROUP BY position ORDER BY average DESC;

-- 11. Teams in the Bundesliga that sold players for the least amount of money total.
SELECT team_from, sum(transfer_fee) AS total_sold FROM homework06.public.soccer_sales
WHERE league_from='1.Bundesliga' GROUP BY team_from ORDER BY total_sold LIMIT 5;

-- 12. Largest purchases from teams that have either bought or sold Zlatan Ibrahimovic (Inclusive of him or not)
SELECT team_to, name, transfer_fee FROM homework06.public.soccer_sales
WHERE team_to IN (SELECT team_from as teams_with_zlatan FROM homework06.public.soccer_sales
WHERE name='Zlatan Ibrahimovic' UNION SELECT team_to FROM homework06.public.soccer_sales
WHERE name='Zlatan Ibrahimovic') GROUP BY team_to, name, transfer_fee ORDER BY transfer_fee DESC LIMIT 20;