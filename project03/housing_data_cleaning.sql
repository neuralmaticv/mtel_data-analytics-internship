-- Data Cleaning
-- Used dataset: https://www.kaggle.com/tmthyjames/nashville-housing-data

SELECT * FROM nashville_housing_data;



-- Populate Property Address data
SELECT
    *
FROM
    nashville_housing_data
-- WHERE propertyaddress IS NULL
ORDER BY
    parcelid;

-- Self join
/*
    join the same exact table to itself
    if a.propertyaddress is NULL then take b.propertyaddress and stick it in there
*/
SELECT 
    a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, NVL(a.propertyaddress, b.propertyaddress)
FROM nashville_housing_data a
JOIN nashville_housing_data b
    ON a.parcelid = b.parcelid
    AND a.uniqueid_ != b.uniqueid_
WHERE a.propertyaddress is null;


CREATE TABLE address (
    id VARCHAR2(128 BYTE),
    prop_address VARCHAR2(150 BYTE)
);

INSERT INTO address
    ( SELECT
        a.parcelid,
        nvl(a.propertyaddress, b.propertyaddress)
    FROM
             nashville_housing_data a
        JOIN nashville_housing_data b ON a.parcelid = b.parcelid
                                         AND a.uniqueid_ != b.uniqueid_
    WHERE
        a.propertyaddress IS NULL
    );
    
-- select * from address;

UPDATE nashville_housing_data t1
SET
    t1.propertyaddress = (
        SELECT
            t2.prop_address
        FROM
            address t2
        WHERE
            t1.parcelid = t2.id and rownum = 1
    )
WHERE
    t1.parcelid IN (
        SELECT
            t2.id
        FROM
            address t2
        WHERE
            t1.parcelid = t2.id and rownum = 1
    );
/*
Error that was occurred:
ERROR - ora-01427: single-row subquery returns more than one row
and because of that we specify rownum limit
*/
-- Check
SELECT 
    a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, NVL(a.propertyaddress, b.propertyaddress)
FROM nashville_housing_data a
JOIN nashville_housing_data b
    ON a.parcelid = b.parcelid
    AND a.uniqueid_ != b.uniqueid_
WHERE a.propertyaddress is null;





-- Breaking out PropertyAddress into Individual Columns (Address, City)
SELECT
    propertyaddress
FROM
    nashville_housing_data;
    
SELECT
    substr(propertyaddress, 1, instr(propertyaddress, ',', 1) - 1) AS address,
    substr(propertyaddress, instr(propertyaddress, ',', 1) + 1, length(propertyaddress)) AS city
FROM
    nashville_housing_data;


alter table nashville_housing_data
add property_split_address VARCHAR2(150 BYTE);

update nashville_housing_data
set property_split_address = substr(propertyaddress, 1, instr(propertyaddress, ',', 1) - 1);

alter table nashville_housing_data
add property_split_city VARCHAR2(150 BYTE);

update nashville_housing_data
set property_split_city = substr(propertyaddress, instr(propertyaddress, ',', 1) + 1, length(propertyaddress));

SELECT
    *
FROM
    nashville_housing_data;


-- Breaking out OwnerAddress into Individual Columns (Address, City, State)
SELECT
    owneraddress
FROM
    nashville_housing_data;

SELECT
    regexp_substr(owneraddress, '[^,]+', 1, 1),
    regexp_substr(owneraddress, '[^,]+', 1, 2),
    regexp_substr(owneraddress, '[^,]+', 1, 3)
FROM
    nashville_housing_data;
    
    
alter table nashville_housing_data
add owner_split_address VARCHAR2(150 BYTE);

update nashville_housing_data
set owner_split_address = regexp_substr(owneraddress, '[^,]+', 1, 1);

alter table nashville_housing_data
add owner_split_city VARCHAR2(150 BYTE);

update nashville_housing_data
set owner_split_city = regexp_substr(owneraddress, '[^,]+', 1, 2);

alter table nashville_housing_data
add owner_split_state VARCHAR2(150 BYTE);

update nashville_housing_data
set owner_split_state = regexp_substr(owneraddress, '[^,]+', 1, 3);

SELECT
    *
FROM
    nashville_housing_data;




-- Change Y and N to Yes and No in SoldAsVacant column
SELECT DISTINCT
    ( soldasvacant ),
    COUNT(soldasvacant)
FROM
    nashville_housing_data
GROUP BY
    soldasvacant
ORDER BY
    2;
    
UPDATE nashville_housing_data
SET
    soldasvacant =
        CASE
            WHEN soldasvacant = 'Y' THEN
                'Yes'
            WHEN soldasvacant = 'N' THEN
                'No'
            ELSE
                soldasvacant
        END;

-- CHECK
SELECT DISTINCT
    ( soldasvacant ),
    COUNT(soldasvacant)
FROM
    nashville_housing_data
GROUP BY
    soldasvacant
ORDER BY
    2;




-- Remove duplicates
/*
    Identify duplicates rows, here we using one option with row number
    partition data by things that should be unique to each row
*/
SELECT
    nashville_housing_data.*,
    ROW_NUMBER()
    OVER(PARTITION BY parcelid, propertyaddress, saledate, saleprice, legalreference
         ORDER BY
             uniqueid_
    ) AS row_num
FROM
    nashville_housing_data
ORDER BY
    parcelid;


DELETE FROM nashville_housing_data
WHERE
    uniqueid_ IN (
        WITH row_num_cte AS (
            SELECT
                nashville_housing_data.*, 
                ROW_NUMBER() OVER(PARTITION BY 
                                        parcelid, 
                                        propertyaddress, 
                                        saledate, 
                                        saleprice, 
                                        legalreference
                                    ORDER BY
                                        uniqueid_
                                    ) AS row_num
            FROM
                nashville_housing_data
        )
        SELECT
            uniqueid_
        FROM
            row_num_cte
        WHERE
            row_num > 1
    );



-- Delete Unused Columns
SELECT
    *
FROM
    nashville_housing_data;

ALTER TABLE nashville_housing_data DROP ( bedrooms,
                                          fullbath,
                                          halfbath );

SELECT
    *
FROM
    nashville_housing_data;