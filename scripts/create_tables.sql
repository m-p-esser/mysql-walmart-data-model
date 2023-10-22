CREATE DATABASE IF NOT EXISTS `walmart`;

USE `walmart`;

CREATE TABLE IF NOT EXISTS `product` (
    `product_id` INT AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `container` VARCHAR(40),
    `sub_category` VARCHAR(40),
    `category` VARCHAR(40),
    `base_margin` DECIMAL(5, 4) NOT NULL,
    PRIMARY KEY (`product_id`)
);

CREATE TABLE IF NOT EXISTS `customer` (
    `customer_id` INT AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    `age` SMALLINT,
    `segment` ENUM(
        'Consumer',
        'Home Office',
        'Small Business',
        'Corporate'
    ) NOT NULL,
    `city` VARCHAR(40),
    `zip_code` INT,
    `state` VARCHAR(40),
    `region` ENUM('Central', 'West', 'East', 'South'),
    PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `order` (
    `id` INT AUTO_INCREMENT,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `priority` ENUM(
        'Critical',
        'High',
        'Medium',
        'Low',
        'Not Specified'
    ) NOT NULL,
    `quantity` SMALLINT NOT NULL,
    `unit_price` DECIMAL(9, 4) NOT NULL,
    `sales` DECIMAL(11, 4) NOT NULL,
    `shipping_cost` DECIMAL(8, 4) NOT NULL,
    `discount` DECIMAL(5, 4) NOT NULL,
    `profit` DECIMAL(11, 4) NOT NULL,
    `order_date` DATETIME NOT NULL,
    `ship_date` DATETIME,
    `ship_mode` ENUM('Regular Air', 'Delivery Truck', 'Express Air'),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON UPDATE CASCADE ON DELETE NO ACTION
);