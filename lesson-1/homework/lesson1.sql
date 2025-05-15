-----------------------EASY--
--TASK-1
--Data – bu xom, ishlanmagan faktlar (sonlar, matnlar).
--Database – bu ma’lumotlarni tartibli saqlash tizimi.
--Relational Database – jadval ko‘rinishidagi va o‘zaro bog‘langan ma’lumotlar bazasi.
--Table – ma’lumotlarni satr va ustunlarda saqlovchi struktura.


--TASK-2
--SQL Server’ning 5 asosiy xususiyati:

--Katta hajmdagi ma’lumotlarni saqlay oladi
--Yuqori darajadagi xavfsizlikni ta’minlaydi
--BI vositalari bilan integratsiyalashgan
--Trigger va stored procedure’larni qo‘llab-quvvatlaydi
--Yuqori mavjudlik va uzluksizlikni ta’minlaydi (Always On)


--TASK-3
--SQL Server’da autentifikatsiya turlari:

--Windows Authentication
--SQL Server Authentication



--------------------------------MEDIUM----
--TASK-4
--SSMS’da yangi baza yaratish
CREATE DATABASE SchoolDB;


--TASK-5
--Students jadvalini yaratish:

	CREATE TABLE Students (
		StudentID INT PRIMARY KEY,
		Name VARCHAR(50),
		Age INT
	);


--TASK-6
--SQL Server, SSMS va SQL o‘rtasidagi farq:

--SQL Server – bu ma’lumotlar bazasini boshqarish tizimi.

--SSMS – SQL Server bilan ishlash uchun grafik interfeysli dastur.

--SQL – bu ma’lumotlar bazasi bilan ishlash uchun so‘rovlar tili.



-----HARD---------------------
--SQL buyruqlari turlari va misollar:


--DQL (Data Query Language) – ma’lumotni so‘rash:
SELECT * FROM Students;


--DML (Data Manipulation Language) – ma’lumot bilan ishlash:
INSERT INTO Students VALUES (1, 'Ali', 20);
UPDATE Students SET Age = 21 WHERE StudentID = 1;
DELETE FROM Students WHERE StudentID = 1;


--DDL (Data Definition Language) – jadval yaratish, o‘zgartirish:
--CREATE TABLE ..., ALTER TABLE ..., DROP TABLE ...


--DCL (Data Control Language) – huquqlarni boshqarish:
GRANT SELECT ON Students TO User1;
REVOKE SELECT ON Students FROM User1;


--TCL (Transaction Control Language) – tranzaksiyalarni boshqarish:
BEGIN TRAN;
COMMIT;
ROLLBACK;


--TASK-8
--3 ta yozuv qo‘shish:
INSERT INTO Students (StudentID, Name, Age) VALUES
(1, 'Ali', 20),
(2, 'Laylo', 22),
(3, 'Jasur', 19);


--TASK-9
--AdventureWorksDW2022.bak faylini tiklash bosqichlari:
--Tiklash tartibi (SSMS orqali):

-- 1-Faylni yuklab oling:
-- 2-SSMS’ni oching va serverga ulang.
-- 3-"Databases" ustida o‘ng tugmani bosing → "Restore Database…" ni tanlang.
-- 4-"Device" variantini belgilang → .bak faylni ko‘rsating.
-- 5-Fayl tanlangach, "Files" va "Options" bo‘limlarini tekshiring.
-- 6-"OK" tugmasini bosing. Baza tiklanadi





