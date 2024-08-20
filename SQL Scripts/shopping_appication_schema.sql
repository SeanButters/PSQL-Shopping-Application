-- Create Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    balance NUMERIC (10,2)
);

-- Create Customer Shipping Address Table
CREATE TABLE Shipping_addresses (
	customer_id INT,
	address_id INT,
	shipping_address VARCHAR(255),
	PRIMARY KEY (customer_id, address_id),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Staff table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
	address VARCHAR(255),
    salary NUMERIC (10,2) CHECK (salary >= 0 ),
    job_title VARCHAR(255)
);
-- Create Credit Card table
CREATE TABLE CreditCard (
	credit_card_id		INT,
    card_number VARCHAR(16) UNIQUE NOT NULL,
    customer_id INT,
    payment_address VARCHAR(255) NOT NULL,
	PRIMARY KEY (credit_card_id, customer_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Product table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price NUMERIC(10,2) CHECK (price >= 0 ),
    category VARCHAR(255),
    brand VARCHAR(255),
    size int,
    description TEXT
);

-- Create Supplier table
CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
	address VARCHAR(255)
);

-- Create Supplier_Product_Price table
CREATE TABLE Supplier_Product_Price (
    supplier_id INT,
    product_id INT,
    price NUMERIC (10,2) CHECK (price >= 0),
    PRIMARY KEY (supplier_id, product_id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

-- Create Warehouse table
CREATE TABLE Warehouse (
    warehouse_id INT PRIMARY KEY,
	address VARCHAR(255),
    size int
);

-- Create Stock table
CREATE TABLE Stock (
    product_id INT,
    warehouse_id INT,
    quantity INT,
    PRIMARY KEY (product_id, warehouse_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    status VARCHAR(50),
    credit_card_number VARCHAR(16) NOT NULL,
    total_price NUMERIC (10,2) CHECK (total_price >= 0),
    FOREIGN KEY (credit_card_number) REFERENCES CreditCard(card_number) ON DELETE CASCADE
);

-- Create Order_Items table
CREATE TABLE Order_Items (
	order_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (order_id, product_id),
	FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

-- Create Delivery table
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    type VARCHAR(50),
    delivery_price NUMERIC (10,2) CHECK (delivery_price >= 0),
    delivery_date DATE,
    ship_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
