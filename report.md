# Overview
## About the Data

1. Name / Title: Top 250 Football transfers from 2000 to 2018
2. Link to Data: https://www.kaggle.com/vardan95ghazaryan/top-250-football-transfers-from-2000-to-2018
3. Source / Origin: 
	* Author or Creator: Vardan
	* Publication Date: 3 Years Ago (August 2018)
	* Publisher: Kaggle
	* Version or Data Accessed: Version 1
4. License: Unspecified License
5. Can You Use this Data Set for Your Intended Use Case? Yes, lot's of interesting data can be seen here!

## Column Types (imported directly from Jupyter Notebook, types will change when importing CSV into PSQL)
Name             object

Position         object

Age               int64

Team_from        object

League_from      object

Team_to          object

League_to        object

Season           object

Market_value    float64

Transfer_fee      int64

NOTE: This dataset comes from homework #4 instead of #3 because I found this dataset much more interesting to work with!
# Table Design

I chose to use VARCHAR for most of the column types because most are actually strings, except age, market_value, and transfer_fee, which I made numeiric for obvious reasons.

I also had trouble importing a CSV with null values, so I had to convert the nulls into -1 using the pandas, the changes are all in the convert file

I had to make id the primary key because I figured some transfer fees may be very common figures (ie. 10 million).


# Import

I had to give permission for everyone in my system to access the folder because PSQL was not allowing access to the CSV
I also had to make all the nulls into -1, but that was noted above.


# Database Information
                                                 List of databases
     Name     |  Owner   | Encoding |          Collate           |           Ctype            |   Access privileges
--------------+----------+----------+----------------------------+----------------------------+-----------------------
 
class15      | postgres | UTF8     | English_United States.1252 | English_United States.1252 |
 
homework06   | postgres | UTF8     | English_United States.1252 | English_United States.1252 |
 
postgres     | postgres | UTF8     | English_United States.1252 | English_United States.1252 |
 
template0    | postgres | UTF8     | English_United States.1252 | English_United States.1252 | =c/postgres          +
              |          |          |                            |                            | postgres=CTc/postgres
 
template1    | postgres | UTF8     | English_United States.1252 | English_United States.1252 | =c/postgres          +
              |          |          |                            |                            | postgres=CTc/postgres
 
test_results | postgres | UTF8     | English_United States.1252 | English_United States.1252 |

(6 rows)

            List of relations
 Schema |     Name     | Type  |  Owner
--------+--------------+-------+----------

 public | soccer_sales | table | postgres

(1 row)

                                        Table "public.soccer_sales"
      Column      |         Type          | Collation | Nullable |                 Default
------------------+-----------------------+-----------+----------+------------------------------------------
 
id               | integer               |           | not null | nextval('soccer_sales_id_seq'::regclass)
 
name             | character varying(50) |           | not null |
 
position         | character varying(50) |           | not null |

 age              | integer               |           | not null |
 
team_from        | character varying(50) |           | not null |
 
league_from      | character varying(50) |           | not null |
 
team_to          | character varying(50) |           | not null |
 
league_to        | character varying(50) |           | not null |
 
season           | character varying(50) |           | not null |
 
market_value     | numeric               |           | not null |
 
transfer_fee     | integer               |           | not null |
 
over_100_million | boolean               |           |          |

Indexes:
    
"soccer_sales_pkey" PRIMARY KEY, btree (id)

# Query Results
-- 1. the total number of rows in the database

4700 rows

-- 2. show the first 15 rows, but only display 3 columns (your choice)

Luís Figo,Right Winger,60000000
Hernán Crespo,Centre-Forward,56810000
Marc Overmars,Left Winger,40000000


-- 3. do the same as above, but chose a column to sort on, and sort in descending order

Neymar,Left Winger,222000000
Kylian Mbappé,Right Winger,135000000
Philippe Coutinho,Attacking Midfield,125000000


-- 4. add a new column without a default value

No output

-- 5. set the value of that new column

No output

-- 6. show only the unique (non duplicates) of a column of your choice

Attacking Midfield

Left-Back

Forward

Left Midfield

Defensive Midfield

Goalkeeper

Sweeper

Right Midfield

Centre-Forward

Centre-Back

Central Midfield

Left Winger

Midfielder

Defender

Right Winger

Right-Back

Second Striker




-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group

Alex,8

Fernando,7

Peter Crouch,7

Robbie Keane,6

Paulinho,6

Éder,6

Alberto Gilardino,6

Craig Bellamy,6

Zlatan Ibrahimovic,6

Émerson,6

Carlos Tévez,6

Sokratis,6

Adriano,6

Ciro Immobile,5

Kevin-Prince Boateng,5

Yaya Touré,5

Nicolas Anelka,5

Maicon,5

Djibril Cissé,5

Luís Fabiano,5

-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups

Chelsea,1820650000

Man City,1800520000

Real Madrid,1680650000

FC Barcelona,1673040000

Man Utd,1497360000

Juventus,1470940000

Liverpool,1412420000

Paris SG,1274780000

Inter,1202690000

Spurs,1024400000

-- 9. Top 10 teams that made the most from selling players.

Monaco,948170000

FC Porto,917550000

Real Madrid,891400000

Chelsea,839530000

Liverpool,798410000

Juventus,797980000

Benfica,785750000

Inter,785280000

FC Barcelona,752100000

Atlético Madrid,734400000

-- 10. Average price for each position in descending order.

Left Winger,12904644

Right Winger,11930360

Central Midfield,10096242

Attacking Midfield,9824178

Centre-Forward,9590270

Defensive Midfield,8992019

Second Striker,8790153

Centre-Back,8448592

Right-Back,8254309

Left-Back,7718933

Goalkeeper,7622666

Right Midfield,7404126

Left Midfield,6717126

Sweeper,2250000

Forward,2200000

Defender,2000000

Midfielder,1130000

-- 11. Bottom 5 Teams in the Bundesliga that sold players for the least amount of money total.

Energie Cottbus,1200000

Arm. Bielefeld,3800000

Hansa Rostock,5100000

1860 Munich,7050000

VfL Bochum,12700000

-- 12. Largest purchases from teams that have either bought or sold Zlatan Ibrahimovic (Inclusive of him or not)

Paris SG,Neymar,222000000

Paris SG,Kylian Mbappé,135000000

FC Barcelona,Philippe Coutinho,125000000

Juventus,Cristiano Ronaldo,117000000

FC Barcelona,Ousmane Dembélé,115000000

Juventus,Gonzalo Higuaín,90000000

FC Barcelona,Neymar,88200000

FC Barcelona,Luis Suárez,81720000

FC Barcelona,Zlatan Ibrahimovic,69500000

Paris SG,Edinson Cavani,64500000

Paris SG,Ángel Di María,63000000

Juventus,Gianluigi Buffon,52880000

Paris SG,David Luiz,49500000

AC Milan,Leonardo Bonucci,42000000

AC Milan,Rui Costa,42000000

Paris SG,Javier Pastore,42000000

Paris SG,Thiago Silva,42000000

Juventus,Lilian Thuram,41500000

FC Barcelona,Malcom,41000000

Juventus,João Cancelo,40400000
