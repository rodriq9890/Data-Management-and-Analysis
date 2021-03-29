DROP TABLE soccer_sales;
CREATE TABLE soccer_sales(
    id SERIAL primary key UNIQUE ,
    name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL ,
    age INTEGER NOT NULL ,
    team_from VARCHAR(50) NOT NULL,
    league_from VARCHAR(50) NOT NULL,
    team_to VARCHAR(50) NOT NULL,
    league_to VARCHAR(50) NOT NULL,
    season VARCHAR(50) NOT NULL,
    market_value NUMERIC NOT NULL,
    transfer_fee INTEGER NOT NULL
);