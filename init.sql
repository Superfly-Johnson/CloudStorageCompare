CREATE TABLE IF NOT EXISTS Companies (
    ID int GENERATED ALWAYS AS IDENTITY,
    Company_Name varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
    ID int GENERATED ALWAYS AS IDENTITY,
    Provider int REFERENCES Companies (ID) ON DELETE CASCADE,
    Product_Name varchar(255) NOT NULL,
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
CREATE OR REPLACE FUNCTION AddProductFromCompanyID(company_id integer, p_name varchar(255), storage_amount bigint) RETURNS int AS $$
DECLARE
   ret_id int;
BEGIN
-- Somehow need to pass a row here...
    INSERT INTO Products(ID,Select(C.ID) FROM Companies WHERE C.ID = company_id,product_name p_name, StorageAmount storage_amount)
    VALUES(DEFAULT,n)
    ON CONFLICT DO NOTHING
    RETURNING ID INTO ret_id;

    RETURN ret_id;
END;
$$ LANGUAGE plpgsql;
