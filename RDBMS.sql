CREATE DATABASE RDBMS;
USE RDBMS;

CREATE TABLE Customer (
    CustomerID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NULL,
    Address VARCHAR(255) NULL,
    RegistrationDate DATE NOT NULL,
    LoyaltyPoints INT UNSIGNED NOT NULL DEFAULT 0
);

CREATE TABLE Vendor (
    VendorID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    VendorName VARCHAR(50) NOT NULL,
    ContactName VARCHAR(50) NOT NULL,
    ContactEmail VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NULL,
    Address VARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    ProductID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    StockQuantity INT UNSIGNED NOT NULL DEFAULT 0,
    Weight DECIMAL(10, 2) NULL CHECK (Weight >= 0),
    Dimensions VARCHAR(50) NULL,
    VendorID INT UNSIGNED,
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Order` (
    OrderID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT UNSIGNED NOT NULL,
    OrderDate DATE NOT NULL,
    ShippingAddress VARCHAR(255) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    OrderStatus VARCHAR(50) NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0),
    TaxAmount DECIMAL(10, 2) NOT NULL CHECK (TaxAmount >= 0),
    ShippingFee DECIMAL(10, 2) NOT NULL CHECK (ShippingFee >= 0),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE OrderItem (
    OrderItemID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    OrderID INT UNSIGNED NOT NULL,
    ProductID INT UNSIGNED NOT NULL,
    Quantity INT UNSIGNED NOT NULL DEFAULT 1 CHECK (Quantity > 0),
    Subtotal DECIMAL(10, 2) NOT NULL CHECK (Subtotal >= 0),
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Review (
    ReviewID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ProductID INT UNSIGNED NOT NULL,
    CustomerID INT UNSIGNED NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT NULL,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Customer (FirstName, LastName, Email, Phone, Address, RegistrationDate, LoyaltyPoints)
VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Elm Street', '2023-01-15', 100),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak Avenue', '2023-02-20', 200),
('Tom', 'Jones', 'tom.jones@example.com', '345-678-9012', '789 Pine Road', '2023-03-10', 150),
('Emily', 'Davis', 'emily.davis@example.com', '456-789-0123', '321 Maple Lane', '2023-04-15', 180),
('Michael', 'Brown', 'michael.brown@example.com', '567-890-1234', '654 Birch Blvd', '2023-05-20', 250),
('Sarah', 'Wilson', 'sarah.wilson@example.com', '678-901-2345', '987 Cedar Ct', '2023-06-25', 220),
('David', 'Clark', 'david.clark@example.com', '789-012-3456', '111 Spruce St', '2023-07-30', 300),
('Linda', 'Martinez', 'linda.martinez@example.com', '890-123-4567', '222 Fir St', '2023-08-05', 270),
('Robert', 'Lopez', 'robert.lopez@example.com', '901-234-5678', '333 Willow Dr', '2023-09-10', 350),
('Karen', 'Harris', 'karen.harris@example.com', '012-345-6789', '444 Poplar Ave', '2023-10-15', 400);

INSERT INTO Vendor (VendorName, ContactName, ContactEmail, Phone, Address)
VALUES
('Tech Supplies Co.', 'Alice Johnson', 'alice.johnson@techsupplies.com', '123-456-7890', '789 Pine Road'),
('Global Electronics', 'Bob Smith', 'bob.smith@globalelectronics.com', '234-567-8901', '123 Maple Street'),
('Home Essentials', 'Catherine Lee', 'catherine.lee@homeessentials.com', '345-678-9012', '456 Oak Avenue'),
('Office Gear', 'David Brown', 'david.brown@officegear.com', '456-789-0123', '789 Cedar Blvd'),
('Outdoor Equipment', 'Emily Davis', 'emily.davis@outdoorequipment.com', '567-890-1234', '321 Birch Lane'),
('Kitchen Pro', 'Frank Wilson', 'frank.wilson@kitchenpro.com', '678-901-2345', '654 Spruce Court'),
('Fitness World', 'Grace Miller', 'grace.miller@fitnessworld.com', '789-012-3456', '987 Willow Street'),
('Auto Parts Ltd.', 'Henry Taylor', 'henry.taylor@autoparts.com', '890-123-4567', '111 Elm Avenue'),
('Fashion Hub', 'Irene Martinez', 'irene.martinez@fashionhub.com', '901-234-5678', '222 Fir Road'),
('Beauty Plus', 'Jack Thompson', 'jack.thompson@beautyplus.com', '012-345-6789', '333 Poplar Drive');

INSERT INTO Product (ProductName, Description, Price, StockQuantity, Weight, Dimensions, VendorID)
VALUES
('Laptop', 'High-performance laptop with 16GB RAM and 512GB SSD.', 999.99, 50, 2.5, '35cm x 24cm x 2cm', 1),
('Smartphone', 'Latest model smartphone with a 6.5-inch display.', 699.99, 100, 0.3, '15cm x 7cm x 0.8cm', 2),
('Desk Chair', 'Ergonomic desk chair with lumbar support.', 199.99, 75, 10, '70cm x 70cm x 110cm', 3),
('Wireless Headphones', 'Noise-cancelling wireless headphones.', 149.99, 200, 0.5, '20cm x 15cm x 8cm', 4),
('Backpack', 'Durable backpack with multiple compartments.', 59.99, 150, 1, '50cm x 35cm x 20cm', 5),
('4K Monitor', 'Ultra HD 4K monitor with a 27-inch screen.', 349.99, 60, 7, '62cm x 35cm x 7cm', 6),
('Coffee Maker', 'Automatic coffee maker with a 12-cup capacity.', 89.99, 80, 3.5, '30cm x 25cm x 35cm', 7),
('Running Shoes', 'Lightweight running shoes with cushioned soles.', 129.99, 90, 1.0, '30cm x 10cm x 10cm', 8),
('Tablet', '10-inch tablet with 128GB storage.', 499.99, 120, 0.8, '25cm x 16cm x 0.7cm', 9),
('Gaming Console', 'Next-gen gaming console with 1TB storage.', 499.99, 40, 4.0, '40cm x 30cm x 10cm', 10);

INSERT INTO `Order` (CustomerID, OrderDate, ShippingAddress, PaymentMethod, OrderStatus, TotalAmount, TaxAmount, ShippingFee)
VALUES
(1, '2023-03-01', '123 Elm Street', 'Credit Card', 'Shipped', 1050.00, 50.00, 20.00),
(2, '2023-03-05', '456 Oak Avenue', 'PayPal', 'Delivered', 960.00, 40.00, 10.00),
(3, '2023-03-10', '789 Pine Road', 'Credit Card', 'Processing', 1000.00, 45.00, 15.00),
(4, '2023-03-15', '321 Maple Lane', 'Debit Card', 'Cancelled', 1400.00, 50.00, 20.00),
(5, '2023-03-20', '654 Birch Blvd', 'Credit Card', 'Shipped', 901.00, 30.00, 10.00),
(6, '2023-03-25', '987 Cedar Ct', 'PayPal', 'Delivered', 1500.00, 70.00, 30.00),
(7, '2023-03-30', '111 Spruce St', 'Credit Card', 'Processing', 1700.00, 85.00, 35.00),
(8, '2023-04-01', '222 Fir St', 'Debit Card', 'Delivered', 2000.00, 100.00, 40.00),
(9, '2023-04-05', '333 Willow Dr', 'Credit Card', 'Shipped', 1800.00, 90.00, 25.00),
(10, '2023-04-10', '444 Poplar Ave', 'PayPal', 'Processing', 1200.00, 60.00, 15.00);

INSERT INTO OrderItem (OrderID, ProductID, Quantity, Subtotal)
VALUES
(1, 1, 1, 999.99),
(2, 2, 1, 699.99),
(3, 3, 1, 199.99),
(4, 4, 1, 149.99),
(5, 5, 1, 59.99),
(6, 6, 1, 349.99),
(7, 7, 1, 89.99),
(8, 8, 1, 129.99),
(9, 9, 1, 499.99),
(10, 10, 1, 499.99);



INSERT INTO Review (ProductID, CustomerID, Rating, ReviewText, ReviewDate)
VALUES
(1, 1, 5, 'Excellent product!', '2023-03-02'),
(2, 2, 4, 'Very good, but could be better.', '2023-03-03'),
(3, 3, 5, 'Outstanding quality!', '2023-03-04'),
(4, 4, 3, 'Average performance.', '2023-03-05'),
(5, 5, 4, 'Good value for money.', '2023-03-06'),
(6, 6, 5, 'Highly recommended!', '2023-03-07'),
(7, 7, 2, 'Disappointed with the product.', '2023-03-08'),
(8, 8, 4, 'Great features.', '2023-03-09'),
(9, 9, 3, 'Could be improved.', '2023-03-10'),
(10, 10, 5, 'Love it!', '2023-03-15');

SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.OrderStatus
FROM `Order` o
JOIN Customer c ON o.CustomerID = c.CustomerID
WHERE c.Email = 'john.doe@example.com';



SELECT ProductName, StockQuantity
FROM Product
WHERE StockQuantity <= 80;


SELECT 
    r.ReviewText,
    r.Rating,
    r.ReviewDate,
    c.FirstName,
    c.LastName
FROM
    Review r
        JOIN
    Customer c ON r.CustomerID = c.CustomerID
        JOIN
    Product p ON r.ProductID = p.ProductID
WHERE
    p.ProductName = 'Smartphone';


SELECT v.VendorName, SUM(oi.Subtotal) AS TotalRevenue
FROM OrderItem oi
JOIN Product p ON oi.ProductID = p.ProductID
JOIN Vendor v ON p.VendorID = v.VendorID
GROUP BY v.VendorName
ORDER BY TotalRevenue DESC;
SELECT * FROM Customer;
SELECT * FROM Vendor;
SELECT * FROM Product;
SELECT * FROM `Order`;
SELECT * FROM OrderItem;


SELECT * FROM Review;



