CREATE TABLE IF NOT EXISTS Companies (
    ID int GENERATED ALWAYS AS IDENTITY,
    Name varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
    ID int GENERATED ALWAYS AS IDENTITY,
    Provider int REFERENCES Companies (ID) ON DELETE CASCADE,
    Name varchar(255) NOT NULL,
    StorageAmount bigint NOT NULL
);

CREATE TYPE CurrUnits AS ENUM (
    'USD',
    'CAD',
    'GBP',
    'EUR'
);

CREATE TABLE IF NOT EXISTS Prices (
    ID int GENERATED ALWAYS AS IDENTITY,
    Price bigint NOT NULL,
    CurrUnit CurrUnits
);

-- Adds a company
CREATE OR REPLACE FUNCTION AddCompany(n varchar(255)) RETURNS int AS $$
DECLARE
   ret_id int;
BEGIN
    INSERT INTO Companies(ID,Name)
    VALUES(DEFAULT,n)
    ON CONFLICT DO NOTHING
    RETURNING ID INTO ret_id;

    RETURN ret_id;
END;
$$ LANGUAGE plpgsql;

-- Adds a Product from a company name.
CREATE OR REPLACE FUNCTION AddProductFromCompanyName(company_name varchar(255), p_name varchar(255), storage_amount bigint) RETURNS int AS $$
DECLARE
	ret_id	int;
	c_id	int;
BEGIN
    INSERT INTO Products(ID,c_id,name,StorageAmount)
    VALUES(DEFAULT,(SELECT ID FROM Companies WHERE Name = company_name),p_name,storage_amount)
    ON CONFLICT DO NOTHING
    RETURNING ID INTO ret_id;

    RETURN ret_id;
END;
$$ LANGUAGE plpgsql;
