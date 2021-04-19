-- 1. This query shows that the columns product_code and description are related by having each product code relate to the same description across the table.

| product\_code | description | product\_code\_count | description\_count |
| :--- | :--- | :--- | :--- |
| 12 |  Cheese/Cheese Prod | 121 | 121 |
| 13 |  Ice Cream Prod | 313 | 313 |
| 14 |  Filled Milk/Imit Milk Prod | 61 | 61 |
| 15 |  Egg/Egg Prod | 59 | 59 |
| 16 | Fishery/Seafood Prod | 1 | 1 |
| 16 |  Fishery/Seafood Prod | 516 | 516 |
| 17 |  Meat, Meat Products and Poultry | 76 | 76 |
| 18 |  Vegetable Protein Prod | 23 | 23 |
| 2 |  Whole Grain/Milled Grain Prod/Starch | 149 | 149 |
| 20 |  Fruit/Fruit Prod | 288 | 288 |
| 20 | Fruit/Fruit Prod | 1 | 1 |
| 21 |  Fruit/Fruit Prod | 284 | 284 |
| 22 |  Fruit/Fruit Prod | 99 | 99 |

I've truncated this table output, but the rest of the table is consistent with what I believe
is true of the relationship between columns: I assume from the output that there is a one to one relation between product code and description, as well as
   a many to one relation between product code to product code and description.

-- 2. this query tries to determine whether or not report id is unique

| equal |
| :--- |
| FALSE |

So yeah, report_id isn't a unique value. 

-- 3. This query will return the count of every column to see if they're related in any way

| distinct report\_id | distinct created\_date | distinct event\_date | distinct product\_type | distinct product | distinct product\_code | distinct description | distinct patient\_age | distinct age\_units | distinct sex | distinct terms | distinct outcomes |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 34123 | 1225 | 2655 | 2 | 21773 | 47 | 47 | 103 | 5 | 3 | 16214 | 155 |


--4. Getting the respective column names and types 

| column\_name | data\_type |
| :--- | :--- |
| caers\_event\_id | integer |
| report\_id | character varying |
| created\_date | date |
| event\_date | date |
| product\_type | text |
| product | text |
| product\_code | text |
| description | text |
| patient\_age | integer |
| age\_units | character varying |
| sex | character varying |
| terms | text |
| outcomes | text |

I am surprised product code and report id are both text types, text and varchar respectively. Why is this the case?
No idea.
