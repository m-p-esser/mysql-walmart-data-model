-- Load data from CSV into tables
USE `walmart`;

-- Customer Table
SET
    FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `walmart`.`customer`;

LOAD DATA LOCAL INFILE './data/final/customer.csv' INTO TABLE `walmart`.`customer` FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    `name`,
    `age`,
    `segment`,
    `city`,
    `zip_code`,
    `state`,
    `region`
);

SET
    FOREIGN_KEY_CHECKS = 1;

-- Product Table
SET
    FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `walmart`.`product`;

LOAD DATA LOCAL INFILE './data/final/product.csv' INTO TABLE `walmart`.`product` FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    `name`,
    `container`,
    `sub_category`,
    `category`,
    `base_margin`
);

SET
    FOREIGN_KEY_CHECKS = 1;

-- Prepare the order table in `process_data.py`, look up 
-- Order Table
TRUNCATE TABLE `walmart`.`order`;

LOAD DATA LOCAL INFILE './data/final/order.csv' INTO TABLE `walmart`.`order` FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    `order_id`,
    `product_id`,
    `priority`,
    `quantity`,
    `unit_price`,
    `sales`,
    `shipping_cost`,
    `discount`,
    `profit`,
    `order_date`,
    `ship_date`
)
-- Not working properly, FIX
SET
    customer_id = (
        SELECT
            customer_id
        FROM
            `walmart`.`customer`
        WHERE
            name = @customer_name
            AND city = @city
            AND zip_code = @zip_code
            AND state = @state
            AND region = @region
    ),
    product_id = (
        SELECT
            product_id
        FROM
            `walmart`.`product`
        WHERE
            name = @product_name
            AND sub_category = @product_sub_category
    );

;