create or replace function permit_len(start_date date, end_date date) returns decimal as $$
    declare
        ret decimal;
    begin
        select round((end_date - start_date)::decimal / 365, 4) into ret;
        return ret;
    end;
$$
language plpgsql;

--1. What is the average permit duration? Which eatery has the longest permit?
SELECT AVG(permit_len(start_date, end_date)) FROM eatery;
SELECT name, permit_number, permit_len(start_date, end_date) AS max_len
FROM eatery where permit_len(start_date, end_date) =
                  (SELECT max(permit_len(start_date, end_date)) from eatery);
--2. What is the count of eateries per year based on permit start date?
select extract(year from start_date) as Year, count(extract(year from start_date)) as count from eatery
GROUP BY extract(year from start_date) ORDER BY Year DESC;

--3. What are the names and eatery types of every eatery in the dataset?
drop table if exists eatery_type cascade;
create table eatery_type(
	eatery_type_id serial constraint eatery_type_pk primary key,
	name text
);
INSERT INTO eatery_type(name) SELECT DISTINCT type_name FROM eatery ON CONFLICT DO NOTHING;

alter table eatery
	add eatery_type_id int;

alter table eatery
	add constraint eatery_eatery_type_eatery_type_id_fk
		foreign key (eatery_type_id) references eatery_type;

UPDATE eatery
SET eatery_type_id = eatery_type.eatery_type_id FROM eatery_type
WHERE eatery.type_name = eatery_type.name;

alter table eatery
    drop column if exists type_name cascade;

SELECT e.name as Name, et.name AS Type FROM eatery e INNER JOIN eatery_type et on et.eatery_type_id = e.eatery_type_id

--4. Which eateries are a cart, and which eateries aren't a cart?
SELECT e.name as Name, CASE WHEN LOWER(et.name) like '%cart' then 'Cart' ELSE et.name END AS type, e.permit_number
FROM eatery e INNER JOIN eatery_type et
    on et.eatery_type_id = e.eatery_type_id;

--5. Can this be easier / how many are carts, and how many are every other type?
CREATE VIEW eatery_report AS SELECT e.name as Name, CASE WHEN LOWER(et.name) like '%cart' then 'Cart' ELSE et.name
    END AS type, e.permit_number  FROM eatery e INNER JOIN eatery_type et
    on et.eatery_type_id = e.eatery_type_id;
SELECT type, count(type) FROM eatery_report GROUP BY type;

--6. How many eateries are there per borough?
select substr(park_id,1,1) as Borough, count(park_id) AS Count from eatery group by substr(park_id,1,1)

--7. Can this be faster?
EXPLAIN ANALYSE SELECT * FROM eatery WHERE name = 'Pushcart';
EXPLAIN ANALYSE SELECT * FROM eatery WHERE eatery_id = 21;
EXPLAIN ANALYZE SELECT * FROM eatery WHERE name != 'Puschart';

