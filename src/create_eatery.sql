drop table if exists eatery cascade;

CREATE TABLE eatery(
    eatery_id INT PRIMARY KEY,
    name TEXT,
    location TEXT,
    park_id TEXT,
    start_date DATE,
    end_date DATE,
    description TEXT,
    permit_number TEXT,
    phone TEXT,
    website TEXT,
    type_name TEXT
);