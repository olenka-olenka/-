/* 1.Перегляд наступної інформації про книгу: назва, автори, ціна.*/
SELECT 
    B.name AS Book_name, 
    GROUP_CONCAT(A.first_name, ' ', A.last_name) AS Authors,
    B.price AS Price
FROM 
    Book B
JOIN 
    Publication P ON B.book_id = P.book_id
JOIN 
    Author A ON P.author_id = A.author_id
GROUP BY 
    B.name, B.price;
    
    
/* 2.Список трьох книг, які найчастіше купили клієнти за певний час.*/
SELECT 
    B.name AS Book_name,
    COUNT(*) AS Total_Sales
FROM 
    `Order` O
JOIN 
    Book B ON O.book_id = B.book_id
WHERE 
    O.order_datetime >= '2024-01-16' AND O.order_datetime <= '2024-04-21'
GROUP BY 
    B.book_id
ORDER BY 
    Total_Sales DESC
LIMIT 3;

/* 3.Кінцева сума замовлення для X рахунку.*/
SELECT 
    I.invoice_id,
    I.customer_id,
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_name,
    SUM(B.price * O.quantity) AS Total_amount
FROM 
    `Order` O
JOIN 
    Book B ON O.book_id = B.book_id
JOIN 
    Invoice I ON O.invoice_id = I.invoice_id
JOIN 
    Customer C ON I.customer_id = C.customer_id
WHERE 
    I.invoice_id = 190
GROUP BY 
    I.invoice_id, I.customer_id, C.first_name, C.last_name;


/* 4.Список усіх книг, які купляв покупець Х і скільки заплатив.*/
SELECT 
    B.name AS Book_name,
    O.quantity AS Quantity,
    O.quantity * B.price AS Total_price
FROM 
    `Invoice` I
JOIN 
    `Order` O ON I.invoice_id = O.invoice_id
JOIN 
    Book B ON O.book_id = B.book_id
WHERE 
    I.customer_id = 16;
    

/* 5.Список клієнтів, які купляли книги в магазині більше 5 разів. */
SELECT 
    C.first_name,
    C.last_name,
    COUNT(O.order_id) AS Total_orders
FROM 
    Customer C
JOIN 
    `Invoice` I ON C.customer_id = I.customer_id
JOIN 
    `Order` O ON I.invoice_id = O.invoice_id
GROUP BY 
    C.customer_id
HAVING 
    COUNT(O.order_id) > 5;
    


/* 6.На яку суму обробив замовлення кожен працівник за певний час. */
SELECT 
    E.employee_id,
    CONCAT(E.first_name, ' ', E.last_name) AS Employee_name,
    SUM(O.quantity * B.price) AS Total_amount
FROM 
    Employee E
JOIN 
    `Invoice` I ON E.employee_id = I.employee_id
JOIN 
    `Order` O ON I.invoice_id = O.invoice_id
JOIN 
    Book B ON O.book_id = B.book_id
WHERE 
    I.transaction_moment >= '2024-02-01' AND I.transaction_moment <= '2024-02-29'
GROUP BY 
    E.employee_id, E.first_name, E.last_name;
    

/* 7.Кількість проданих книг, всіх авторів проданих в У місяці.*/
SELECT 
    A.first_name,
    A.last_name,
    COUNT(*) AS Sold_books
FROM 
    `Order` O
JOIN 
    Book B ON O.book_id = B.book_id
JOIN 
    Publication P ON B.book_id = P.book_id
JOIN 
    Author A ON P.author_id = A.author_id
WHERE 
    MONTH(O.order_datetime) = 3
GROUP BY 
    A.author_id;

/* 8.Статистика продажу книжок різних типів.*/
SELECT 
    B.type_book AS Category,
    COUNT(*) AS Total_sales,
    SUM(B.price) AS Total_revenue
FROM 
    `Order` O
JOIN 
    Book B ON O.book_id = B.book_id
GROUP BY 
    B.type_book;
    
/* 9.Показати список клієнтів, загальна сума покупки, яких перевищує 1500 грн.*/
SELECT 
    C.first_name,
    C.last_name,
    SUM(B.price * O.quantity) AS Total_purchase_amount
FROM 
    Customer C
JOIN 
    `Invoice` I ON C.customer_id = I.customer_id
JOIN 
    `Order` O ON I.invoice_id = O.invoice_id
JOIN 
    Book B ON O.book_id = B.book_id
GROUP BY 
    C.customer_id
HAVING 
    SUM(B.price * O.quantity) > 1500;


/* 10.Показати книги які ніхто не купив.*/
SELECT 
	B.book_id,
    B.name AS Book_name
FROM 
    Book B
LEFT JOIN 
    `Order` O ON B.book_id = O.book_id
WHERE 
    O.order_id IS NULL;
    
/* 11.Показати книги, які мають різні роки видання.*/
SELECT 
    B.name AS Book_name,
    GROUP_CONCAT(DISTINCT P.year_publication ORDER BY P.year_publication ASC SEPARATOR ', ') AS Publication_years
FROM 
    Book B
JOIN 
    Publication P ON B.book_id = P.book_id
GROUP BY 
    B.book_id, B.name
HAVING 
    COUNT(DISTINCT P.year_publication) > 1;

/* 12.Видалення книги з таблиці Book, у якої book_id дорівнює 24.*/
DELETE FROM Book 
WHERE book_id = 24;

/* 13.Оновлення бонусу працівника у таблиці Employee, у якого employee_id дорівнює 1, встановивши бонус у розмірі 7000.00.*/
UPDATE Employee 
SET bonus = 7000.00 
WHERE employee_id = 1;

/* 14.Додавання нового запису до таблиці Customer.*/
INSERT INTO Customer (customer_id, first_name, last_name, phone_number, email, discount, country, city, street, house_number) 
VALUES (101, 'Ангеліна', ‘Носик’, '+380631234567', 'angelina@gmail.com', 0.10, 'Україна', 'Одеса', 'вул. Стуса', 15);


/*	1.Список книг, які були куплені більше 5 разів.*/
SELECT 
    B.name AS Book_name
FROM 
    Book B
WHERE 
    B.book_id IN (
        SELECT 
            book_id
        FROM 
            `Order`
        GROUP BY 
            book_id
        HAVING 
            COUNT(*) > 5
    );
    
/* 2.Показати клієнтів, які зробили покупки на суму більше середньої вартості покупки*/
SELECT 
    C.customer_id,
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_name,
    SUM(B.price * O.quantity) AS Total_amount
FROM 
    Customer C
JOIN 
    `Invoice` I ON C.customer_id = I.customer_id
JOIN 
    `Order` O ON I.invoice_id = O.invoice_id
JOIN 
    Book B ON O.book_id = B.book_id
GROUP BY 
    C.customer_id
HAVING 
    SUM(B.price * O.quantity) > (
        SELECT 
            AVG(total_amount)
        FROM 
            (
                SELECT 
                    SUM(B.price * O.quantity) AS total_amount
                FROM 
                    `Order` O
                JOIN 
                    Book B ON O.book_id = B.book_id
                GROUP BY 
                    O.invoice_id
            ) AS avg_amounts
    );


/* 3.Показати список клієнтів, які купували лише електронні книги.*/
SELECT 
    C.customer_id,
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_name
FROM 
    Customer C
WHERE 
    C.customer_id NOT IN (
        SELECT 
            I.customer_id
        FROM 
            `Invoice` I
        JOIN 
            `Order` O ON I.invoice_id = O.invoice_id
        JOIN 
            Book B ON O.book_id = B.book_id
        WHERE 
            B.type_book = 'Паперова книга'
    )
AND
    C.customer_id IN (
        SELECT 
            I.customer_id
        FROM 
            `Invoice` I
        JOIN 
            `Order` O ON I.invoice_id = O.invoice_id
        JOIN 
            Book B ON O.book_id = B.book_id
        WHERE 
            B.type_book = 'Електронна книга'
    );


