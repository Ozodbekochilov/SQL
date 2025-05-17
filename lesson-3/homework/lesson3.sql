--EASY--
--TASK-1
--BULK INSERT - bu SQL Serverdagi ma’lumotlarni tashqi fayldan (odatda .csv, .txt) to‘g‘ridan-to‘g‘ri jadvalga tez va samarali yuklash uchun ishlatiladigan buyruqdir.



--TASK-2
-----SQL Server'ga import qilish mumkin bo‘lgan to‘rtta fayl formati:

-- 1) CSV (Comma-Separated Values) – har bir ustun vergul bilan ajratilgan.

-- 2) TXT (Plain Text) – oddiy matn fayli, maxsus ajratkichlar bilan.

-- 3) XML (eXtensible Markup Language) – murakkab tuzilmani ifodalash uchun ishlatiladi.

-- 4) JSON (JavaScript Object Notation) – strukturalashtirilgan ma’lumotlar uchun zamonaviy format.



--TASK-3
CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
	ProductName VARCHAR(50) UNIQUE,
	Price DECIMAL(10,2)
)



--TASK-4
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Telefon', 250.00),
(2, 'Noutbuk', 850.50),
(3, 'Quloqchin', 45.99);



--TASK-5
--NULL – qiymat yo‘q degani, Ustunga hech qanday ma’lumot kiritilmagan holat. Bu 0 yoki bo‘sh emas — bu noma’lum degani.
--NOT NULL – qiymat bo‘lishi majburiy, Ustunga har doim biror qiymat kiritilishi kerak. Bo‘sh qoldirib bo‘lmaydi.



--TASK-6
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);


--TASK-7
-- 1) Bitta qatorli izoh — -- bilan yoziladi:
--MISOL:
-- Barcha mahsulotlarni tanlab olish
SELECT * FROM Products;

-- 2) Ko‘p qatorli izoh — /* ... */ bilan yoziladi:
--MISOL:
/*
Bu so‘rov Products jadvalidan
narxi 100 dan katta bo‘lgan mahsulotlarni tanlaydi
*/
SELECT * FROM Products
WHERE Price > 100;



--TASK-8
ALTER TABLE Products
ADD CategoryID INT


--TASK-9
CREATE TABLE Category (
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR(50) UNIQUE
)



--TASK-10
--IDENTITY bu ID uchun iwlatiladi uzi avto ID quwib ketadi IDENTITY(1,1) bu yerdagi 1-chi turgan 1 bowlaniwi 1 ID dan bowlaydi, 2-chida turgan 1 esa quwiliw masalan 1 dan bowlanadi yana bir quwiladi, agarda uwa 2-chida turgan 1 ni 10 qilsan 1 dan bowlab keyngisi esa 11 buladi chunki 1+10=11 ku uwanga.





--MEDIUM
--TASK-1
--Menda BULK INSERT Iwlamadi



--TASK-2
--QILIB BILMADIM



--TASK-3
-- 1) PRIMARY KEY - Bu jadvaldagi asosiy noyob identifikator bo‘lib, qaytarilmas (UNIQUE) va bo‘sh bo‘lmasligi (NOT NULL) shart.
--Xususiyatlari:
-- | Har bir jadvalda faqat bitta PRIMARY KEY bo‘ladi.
-- | NULL ruxsat etilmaydi.
-- | Odatda asosiy identifikator uchun ishlatiladi (masalan, ProductID).

-- 2) UNIQUE KEY (UNIQUE cheklov) - Bu ustundagi qiymatlarni noyob (takrorlanmas) bo‘lishini ta’minlaydi, lekin NULL ruxsat etiladi (ba'zi hollarda bir martagacha).
--Xususiyatlari:
-- | Har bir jadvalda bir nechta UNIQUE cheklov bo‘lishi mumkin.
-- | 1 yoki undan ortiq NULL qiymat bo‘lishi mumkin.
-- | Maqsad: boshqa ustunlarda ham noyoblik talab qilinsa (masalan, ProductName).



--TASK-4
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);



--TASK-5
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;



--TASK-6
SELECT 
    ProductID,
    ProductName,
    ISNULL(Price, 0) AS Price
FROM Products;



--TASK-7
--SQL Server’da FOREIGN KEY cheklovining asosiy maqsadi — ikki jadval orasida ma’lumotlar bog‘liqligini (bog‘lanishini) ta’minlash va ma’lumotlar yaxlitligini (integrity) saqlashdir.
--FOREIGN KEY — bu bir jadvaldagi ustun (yoki ustunlar to‘plami) orqali boshqa jadvaldagi PRIMARY KEY (yoki UNIQUE) ustuniga bog‘lanish.
-- Maqsadi:
--Maqsadi:
--Ma’lumotlar yaxlitligini ta’minlash
--Noto‘g‘ri, mavjud bo‘lmagan ID'lar kiritilishiga yo‘l qo‘ymaydi.

--Jadvallar orasida munosabat o‘rnatish
-- Masalan, Products jadvalidagi CategoryID ustuni Categories jadvalidagi CategoryID ga bog‘lanadi.

--Noto‘g‘ri, mavjud bo‘lmagan ID'lar kiritilishiga yo‘l qo‘ymaydi.

-- 2) Jadvallar orasida munosabat o‘rnatish
-- Masalan, Products jadvalidagi CategoryID ustuni Categories jadvalidagi CategoryID ga bog‘lanadi.




--HARD
--TASK-1
CREATE TABLE Customer (
    CustomerID INT IDENTITY(100, 10) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
	Age INT CHECK(Age >= 18),
    Phone VARCHAR(20)
);


--TASK-2
--Customer Tablega IDENTITY(100, 10) ni iwlatdim


--TASK-3
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID)
);


--TASK-4
-- 1. ISNULL -Faqat ikkita argument oladi:
--ISNULL(expression, replacement_value)
--Agar expression NULL bo‘lsa, replacement_value ni qaytaradi, aks holda expression ni qaytaradi.
--Faollashtirilgan faqat SQL Serverda (ba’zi boshqa DBMSlarda yo‘q).
--Ma’lumot turi qaytarilishi ko‘proq expression ga qarab belgilanadi.
--Tezroq ishlaydi va oddiy vaziyatlarda qulay.
--MISOL:
--SELECT ISNULL(NULL, 'default') AS Result1;  
-- Natija: 'default'

-- 2. COALESCE - Bir yoki undan ortiq argument olishi mumkin:
--COALESCE(expr1, expr2, ..., exprN)
--Berilgan argumentlar ichidan birinchi NULL bo‘lmagan qiymatni qaytaradi.
--Standart SQL funktsiyasi, ko‘plab DBMSda ishlaydi (SQL Server, Oracle, PostgreSQL va boshqalar).
--Ma’lumot turi qaytarilishi, argumentlar orasidagi eng keng turga mos keladi.
--Ko‘proq moslashuvchan.
--MISOL:
--SELECT COALESCE(NULL, NULL, 'default', 'another') AS Result2;  
-- Natija: 'default'


--TASK-5
CREATE TABLE Employees (
	EmpID INT PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(50)
)


--TASK-6
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;
