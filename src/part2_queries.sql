-- 1. Show the possible values of the year column in the country_stats table sorted by most recent year first.
SELECT DISTINCT year FROM country_stats ORDER BY year DESC;

-- 2. Show the names of the first 5 countries in the database when sorted in alphabetical order by name.
SELECT name FROM countries ORDER BY name LIMIT 5;

-- 3. Adjust the previous query to show both the country name and the gdp from 2018, but this time show the top 5 countries by gdp.
SELECT name, gdp FROM country_stats INNER JOIN countries c on country_stats.country_id = c.country_id
WHERE year = 2018 ORDER BY gdp DESC LIMIT 5;

-- 4. How many countries are associated with each region id?
SELECT region_id, COUNT(region_id) as country_count FROM countries GROUP BY region_id ORDER BY country_count DESC;

-- 5. What is the average area of countries in each region id?
SELECT region_id, CEIL(SUM(area)/count(region_id)) AS avg_area FROM countries GROUP BY region_id ORDER BY avg_area;

-- 6. Use the same query as above, but only show the groups with an average country area less than 1000
SELECT region_id, CEIL(SUM(area)/count(region_id)) AS avg_area FROM countries GROUP BY region_id
HAVING CEIL(SUM(area)/count(region_id)) < 1000 ORDER BY avg_area;

-- 7. Create a report displaying the name and population of every continent in the database from the year 2018 in millions.
SELECT cont.name, ROUND(SUM(cs.population)/1000000.0, 2) as tot_pop FROM country_stats cs INNER JOIN countries c
    ON cs.country_id=c.country_id INNER JOIN regions r ON c.region_id = r.region_id INNER JOIN continents cont
    ON cont.continent_id = r.continent_id WHERE cs.year = 2018 GROUP BY cont.name ORDER BY tot_pop DESC;

-- 8. List the names of all of the countries that do not have a language.
SELECT c.name FROM countries c LEFT JOIN country_languages cl on c.country_id = cl.country_id
WHERE cl.country_id IS NULL;

-- 9. Show the country name and number of associated languages of the top 10 countries with most languages
SELECT c.name, count(cl.country_id) AS lang_count FROM countries c INNER JOIN country_languages cl on c.country_id = cl.country_id
GROUP BY cl.country_id, c.name ORDER BY lang_count DESC, c.name LIMIT 10;

-- 10. Repeat your previous query, but display a comma separated list of spoken languages rather than a count
SELECT c.name, STRING_AGG (l.language, ',') FROM countries c INNER JOIN country_languages cl
    on c.country_id = cl.country_id INNER JOIN languages l on cl.language_id = l.language_id GROUP BY c.name
ORDER BY count(cl.country_id) DESC, c.name LIMIT 10;

-- 11. What's the average number of languages in every country in a region in the dataset? Show both the region's name and the average.
SELECT r.name, round(CAST(ot.lang_count AS decimal)/CAST(COUNT(r.region_id) AS decimal), 1) AS avg_lang_count_per_country
FROM regions r INNER JOIN countries c on c.region_id = r.region_id INNER JOIN (SELECT r.name, count(r.region_id)
        AS lang_count FROM countries c INNER JOIN country_languages cl
            ON c.country_id = cl.country_id INNER JOIN regions r on c.region_id = r.region_id
    GROUP BY r.region_id, r.name ORDER BY lang_count DESC, r.name) ot ON ot.name = r.name
GROUP BY r.region_id, r.name, ot.lang_count ORDER BY avg_lang_count_per_country DESC;

-- 12. Show the country name and its "national day" for the country with the most recent national day and the country with the oldest national day.
(SELECT name, national_day FROM countries WHERE national_day IS NOT NULL ORDER BY national_day DESC LIMIT 1) UNION ALL
(SELECT name, national_day FROM countries WHERE national_day IS NOT NULL ORDER BY national_day LIMIT 1);