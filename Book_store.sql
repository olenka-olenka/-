CREATE DATABASE Book_store;
USE Book_store;

CREATE TABLE `Employee` (
	`employee_id` int NOT NULL,
	`user_name` varchar(30) NOT NULL UNIQUE,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`position` varchar(15) NOT NULL,
	`manager_id` int,
	`employment_date` date NOT NULL,
	`email` varchar(50) NOT NULL UNIQUE,
	`phone_number` varchar(15) NOT NULL,
	`salary` decimal(10,2) NOT NULL,
	`bonus` decimal(10,2),
	PRIMARY KEY (`employee_id`)
);

CREATE TABLE `Book` (
	`book_id` int NOT NULL,
	`ISBN` int NOT NULL,
	`name` varchar(60) NOT NULL,
	`price` decimal(10,2) NOT NULL,
	`description_book`  varchar(256) NOT NULL,
	`type_book` varchar(25) NOT NULL,
	`language` varchar(25) NOT NULL,
	`genre` varchar(50) NOT NULL,
	`number_of_pages` int NOT NULL,
	PRIMARY KEY (`book_id`)
);

CREATE TABLE `Author` (
	`author_id` int NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`date_birth` date NOT NULL,
	PRIMARY KEY (`author_id`)
);

CREATE TABLE `Order` (
	`order_id` int NOT NULL,
	`book_id` int NOT NULL,
	`quantity` int NOT NULL,
	`order_datetime` datetime NOT NULL,
	`invoice_id` int NOT NULL,
	PRIMARY KEY (`order_id`)
);

CREATE TABLE `Customer` (
	`customer_id` int NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`phone_number` varchar(15) NOT NULL,
	`email` varchar(50) NOT NULL,
	`discount` decimal(5,2),
	`country` varchar(25),
	`city` varchar(25),
	`street` varchar(25),
	`house_number` int,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE `Invoice` (
	`invoice_id` int NOT NULL,
	`employee_id` int NOT NULL,
	`customer_id` int NOT NULL,
	`payment_method` int NOT NULL,
	`transaction_moment` datetime NOT NULL,
	`status` varchar(12) NOT NULL,
	PRIMARY KEY (`invoice_id`)
);

CREATE TABLE `Publication` (
	`publication_id` int NOT NULL,
	`book_id` int NOT NULL,
	`year_publication` year NOT NULL,
	`author_id` int NOT NULL
);

ALTER TABLE `Employee` ADD CONSTRAINT `Employee_fk5` FOREIGN KEY (`manager_id`) REFERENCES `Employee`(`employee_id`);
ALTER TABLE `Order` ADD CONSTRAINT `Order_fk1` FOREIGN KEY (`book_id`) REFERENCES `Book`(`book_id`);
ALTER TABLE `Order` ADD CONSTRAINT `Order_fk4` FOREIGN KEY (`invoice_id`) REFERENCES `Invoice`(`invoice_id`);
ALTER TABLE `Invoice` ADD CONSTRAINT `Invoice_fk1` FOREIGN KEY (`employee_id`) REFERENCES `Employee`(`employee_id`);
ALTER TABLE `Invoice` ADD CONSTRAINT `Invoice_fk2` FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`customer_id`);
ALTER TABLE `Publication` ADD CONSTRAINT `Publication_fk1` FOREIGN KEY (`book_id`) REFERENCES `Book`(`book_id`);
ALTER TABLE `Publication` ADD CONSTRAINT `Publication_fk3` FOREIGN KEY (`author_id`) REFERENCES `Author`(`author_id`);

