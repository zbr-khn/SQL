SHOW DATABASES;
CREATE DATABASE AirbnbDB;
USE AirbnbDB;
SELECT DATABASE();
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    ProfilePicture BLOB,
    UserType VARCHAR(20)
);
SHOW TABLES;
USE airbnbdb;
CREATE TABLE Guest (
    GuestID INT PRIMARY KEY,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);
SHOW TABLES;
CREATE TABLE Host (
    HostID INT PRIMARY KEY,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);
SHOW TABLES;
INSERT INTO User VALUES
(1, 'Michael Keith', 'michael@gmail.com', '9999999999', NULL, 'Guest'),
(2, 'Ali Ahmed', 'ali@gmail.com', '8888888888', NULL, 'Host'),
(3, 'Sara Khan', 'sara@gmail.com', '7777777777', NULL, 'Guest'),
(4, 'John Doe', 'john@gmail.com', '6666666666', NULL, 'Host');
SELECT * FROM User;
INSERT INTO Guest VALUES
(1, 1),
(2, 3);

INSERT INTO Host VALUES
(1, 2),
(2, 4);

SELECT * FROM Guest;
SELECT * FROM Host;

CREATE TABLE Accommodation (
    AccommodationID INT PRIMARY KEY,
    HostID INT,
    Title VARCHAR(100),
    Location VARCHAR(100),
    PricePerNight DECIMAL(10,2),
    FOREIGN KEY (HostID) REFERENCES Host(HostID)
);
SHOW TABLES;
INSERT INTO Accommodation VALUES
(1, 1, 'Sea View Apartment', 'Goa', 5000.00),
(2, 2, 'Mountain Cabin', 'Manali', 3000.00);

SELECT * FROM Accommodation;

CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    GuestID INT,
    AccommodationID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);

SHOW TABLES;

INSERT INTO Booking VALUES
(1, 1, 1, '2024-04-10', '2024-04-15', 25000.00),
(2, 2, 2, '2024-05-01', '2024-05-05', 12000.00);
SELECT * FROM Booking;

SELECT 
    Booking.BookingID,
    User.Name AS GuestName,
    Accommodation.Title,
    Booking.CheckInDate,
    Booking.CheckOutDate
FROM Booking
JOIN Guest ON Booking.GuestID = Guest.GuestID
JOIN User ON Guest.UserID = User.UserID
JOIN Accommodation ON Booking.AccommodationID = Accommodation.AccommodationID;

SELECT 
    User.Name AS HostName,
    Accommodation.Title,
    Accommodation.Location,
    Accommodation.PricePerNight
FROM Accommodation
JOIN Host ON Accommodation.HostID = Host.HostID
JOIN User ON Host.UserID = User.UserID;

SELECT 
    User.Name AS HostName,
    SUM(Booking.TotalPrice) AS TotalEarnings
FROM Booking
JOIN Accommodation ON Booking.AccommodationID = Accommodation.AccommodationID
JOIN Host ON Accommodation.HostID = Host.HostID
JOIN User ON Host.UserID = User.UserID
GROUP BY User.Name;

SHOW TABLES;

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    BookingID INT,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
    );
    
    CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY,
    BookingID INT,
    BookingDate DATETIME,
    CheckIn DATETIME,
    CheckOut DATETIME,
    PaymentID INT,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    ReviewerID INT,
    ReviewedID INT,
    Rating FLOAT,
    Comments VARCHAR(255),
    FOREIGN KEY (ReviewerID) REFERENCES User(UserID),
    FOREIGN KEY (ReviewedID) REFERENCES User(UserID)
);

CREATE TABLE Complaint (
    ComplaintID INT PRIMARY KEY,
    Explanation VARCHAR(255),
    Status VARCHAR(50),
    ResolutionDate DATETIME,
    RelatedGuestID INT,
    RelatedHostID INT,
    FOREIGN KEY (RelatedGuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (RelatedHostID) REFERENCES Host(HostID)
);

CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY,
    UserID INT,
    Message VARCHAR(255),
    CreatedAt DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

SHOW TABLES;

CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    Country VARCHAR(100),
    Region VARCHAR(100),
    City VARCHAR(100),
    Street VARCHAR(100),
    PostCode VARCHAR(20)
);

CREATE TABLE HouseRules (
    HouseRulesID INT PRIMARY KEY,
    RuleText VARCHAR(255)
);

CREATE TABLE Place (
    PlaceID INT PRIMARY KEY,
    PlaceLocationID INT,
    NumberOfRooms INT,
    PlaceSize FLOAT,
    MaxGuests INT,
    HouseRulesID INT,
    FOREIGN KEY (PlaceLocationID) REFERENCES Location(LocationID),
    FOREIGN KEY (HouseRulesID) REFERENCES HouseRules(HouseRulesID)
);

SHOW TABLES;

CREATE TABLE Amenity (
    AmenityID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(255)
);

CREATE TABLE AmenityListing (
    PRIMARY KEY (PlaceID, AmenityID),
    PlaceID INT,
    AmenityID INT,
    FOREIGN KEY (PlaceID) REFERENCES Place(PlaceID),
    FOREIGN KEY (AmenityID) REFERENCES Amenity(AmenityID)
);

CREATE TABLE Media (
    MediaID INT PRIMARY KEY,
    Type VARCHAR(50),
    Media BLOB
);

CREATE TABLE Listing (
    ListingID INT PRIMARY KEY,
    ListedPlaceID INT,
    CoverPhotoID INT,
    Description VARCHAR(255),
    FOREIGN KEY (ListedPlaceID) REFERENCES Place(PlaceID),
    FOREIGN KEY (CoverPhotoID) REFERENCES Media(MediaID)
);

SHOW TABLES;

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Language (
    LanguageID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE UserLanguage (
    UserID INT,
    LanguageID INT,
    PRIMARY KEY (UserID, LanguageID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID)
);

CREATE TABLE Income (
    IncomeID INT PRIMARY KEY,
    HostID INT,
    Amount DECIMAL(10,2),
    Date DATE,
    FOREIGN KEY (HostID) REFERENCES Host(HostID)
);

SHOW TABLES;

ALTER TABLE Accommodation
ADD Description VARCHAR(255),
ADD Photos BLOB,
ADD Availability DATETIME;

ALTER TABLE Booking
ADD PaymentStatus VARCHAR(50),
ADD TransactionDetails VARCHAR(255);

ALTER TABLE Accommodation
ADD PlaceID INT,
ADD FOREIGN KEY (PlaceID) REFERENCES Place(PlaceID),
CHANGE PricePerNight Pricing DECIMAL(10,2);

DESCRIBE Accommodation;
DESCRIBE Booking;

INSERT INTO User (UserID, Name, Email, PhoneNumber, ProfilePicture, UserType) VALUES
(5, 'User5', 'user5@mail.com', '9000000005', NULL, 'Guest'),
(6, 'User6', 'user6@mail.com', '9000000006', NULL, 'Host'),
(7, 'User7', 'user7@mail.com', '9000000007', NULL, 'Guest'),
(8, 'User8', 'user8@mail.com', '9000000008', NULL, 'Host'),
(9, 'User9', 'user9@mail.com', '9000000009', NULL, 'Guest'),
(10, 'User10', 'user10@mail.com', '9000000010', NULL, 'Host'),
(11, 'User11', 'user11@mail.com', '9000000011', NULL, 'Guest'),
(12, 'User12', 'user12@mail.com', '9000000012', NULL, 'Host'),
(13, 'User13', 'user13@mail.com', '9000000013', NULL, 'Guest'),
(14, 'User14', 'user14@mail.com', '9000000014', NULL, 'Host'),
(15, 'User15', 'user15@mail.com', '9000000015', NULL, 'Guest'),
(16, 'User16', 'user16@mail.com', '9000000016', NULL, 'Host'),
(17, 'User17', 'user17@mail.com', '9000000017', NULL, 'Guest'),
(18, 'User18', 'user18@mail.com', '9000000018', NULL, 'Host'),
(19, 'User19', 'user19@mail.com', '9000000019', NULL, 'Guest'),
(20, 'User20', 'user20@mail.com', '9000000020', NULL, 'Host'),
(21, 'User21', 'user21@mail.com', '9000000021', NULL, 'Guest'),
(22, 'User22', 'user22@mail.com', '9000000022', NULL, 'Host'),
(23, 'User23', 'user23@mail.com', '9000000023', NULL, 'Guest'),
(24, 'User24', 'user24@mail.com', '9000000024', NULL, 'Host');

SELECT COUNT(*) FROM User;

INSERT INTO Guest (GuestID, UserID) VALUES
(3, 5),
(4, 7),
(5, 9),
(6, 11),
(7, 13),
(8, 15),
(9, 17),
(10, 19),
(11, 21),
(12, 23),
(13, 6),
(14, 8),
(15, 10),
(16, 12),
(17, 14),
(18, 16),
(19, 18),
(20, 20),
(21, 22),
(22, 24);

SELECT COUNT(*) FROM Guest;

INSERT INTO Host (HostID, UserID) VALUES
(3, 6),
(4, 8),
(5, 10),
(6, 12),
(7, 14),
(8, 16),
(9, 18),
(10, 20),
(11, 22),
(12, 24),
(13, 2),
(14, 4),
(15, 1),
(16, 3),
(17, 5),
(18, 7),
(19, 9),
(20, 11),
(21, 13),
(22, 15);

SELECT COUNT(*) FROM Host;

SELECT COUNT(*) FROM Place;

INSERT INTO Location (LocationID, Country, Region, City, Street, PostCode) VALUES
(1,'India','North','Delhi','Street 1','110001'),
(2,'India','North','Delhi','Street 2','110002'),
(3,'India','North','Delhi','Street 3','110003'),
(4,'India','North','Delhi','Street 4','110004'),
(5,'India','North','Delhi','Street 5','110005'),
(6,'India','North','Delhi','Street 6','110006'),
(7,'India','North','Delhi','Street 7','110007'),
(8,'India','North','Delhi','Street 8','110008'),
(9,'India','North','Delhi','Street 9','110009'),
(10,'India','North','Delhi','Street 10','110010'),
(11,'India','South','Bangalore','Street 11','560001'),
(12,'India','South','Bangalore','Street 12','560002'),
(13,'India','South','Bangalore','Street 13','560003'),
(14,'India','South','Bangalore','Street 14','560004'),
(15,'India','South','Bangalore','Street 15','560005'),
(16,'India','West','Mumbai','Street 16','400001'),
(17,'India','West','Mumbai','Street 17','400002'),
(18,'India','West','Mumbai','Street 18','400003'),
(19,'India','West','Mumbai','Street 19','400004'),
(20,'India','West','Mumbai','Street 20','400005');

INSERT INTO HouseRules (HouseRulesID, RuleText) VALUES
(1,'No smoking'),
(2,'No pets'),
(3,'No loud music'),
(4,'Check-in after 2 PM'),
(5,'Check-out before 11 AM'),
(6,'No parties'),
(7,'Keep clean'),
(8,'No outsiders'),
(9,'Respect neighbors'),
(10,'No damage'),
(11,'No smoking'),
(12,'No pets'),
(13,'No loud music'),
(14,'Check-in after 2 PM'),
(15,'Check-out before 11 AM'),
(16,'No parties'),
(17,'Keep clean'),
(18,'No outsiders'),
(19,'Respect neighbors'),
(20,'No damage');

INSERT INTO Place 
(PlaceID, PlaceLocationID, NumberOfRooms, PlaceSize, MaxGuests, HouseRulesID)
VALUES
(1,1,2,500,3,1),
(2,2,3,600,4,2),
(3,3,1,400,2,3),
(4,4,2,550,3,4),
(5,5,3,700,5,5),
(6,6,2,520,3,6),
(7,7,1,350,2,7),
(8,8,2,580,4,8),
(9,9,3,750,5,9),
(10,10,2,600,4,10),
(11,11,1,300,2,11),
(12,12,2,450,3,12),
(13,13,3,650,5,13),
(14,14,2,500,4,14),
(15,15,1,350,2,15),
(16,16,2,550,3,16),
(17,17,3,700,5,17),
(18,18,2,520,4,18),
(19,19,1,300,2,19),
(20,20,2,480,3,20);

SELECT COUNT(*) FROM Location;
SELECT COUNT(*) FROM HouseRules;
SELECT COUNT(*) FROM Place;

INSERT INTO Accommodation 
(AccommodationID, HostID, Title, Location, PricePerNight, Description, Photos, Availability, PlaceID)
VALUES
(3,1,'Stay 1','Delhi',2000,'Nice place 1',NULL,'2024-05-01',1),
(4,2,'Stay 2','Delhi',2500,'Nice place 2',NULL,'2024-05-02',2),
(5,3,'Stay 3','Delhi',3000,'Nice place 3',NULL,'2024-05-03',3),
(6,4,'Stay 4','Delhi',3500,'Nice place 4',NULL,'2024-05-04',4),
(7,5,'Stay 5','Delhi',4000,'Nice place 5',NULL,'2024-05-05',5),
(8,6,'Stay 6','Bangalore',4500,'Nice place 6',NULL,'2024-05-06',6),
(9,7,'Stay 7','Bangalore',5000,'Nice place 7',NULL,'2024-05-07',7),
(10,8,'Stay 8','Bangalore',5500,'Nice place 8',NULL,'2024-05-08',8),
(11,9,'Stay 9','Bangalore',6000,'Nice place 9',NULL,'2024-05-09',9),
(12,10,'Stay 10','Bangalore',6500,'Nice place 10',NULL,'2024-05-10',10),
(13,11,'Stay 11','Mumbai',7000,'Nice place 11',NULL,'2024-05-11',11),
(14,12,'Stay 12','Mumbai',7500,'Nice place 12',NULL,'2024-05-12',12),
(15,13,'Stay 13','Mumbai',8000,'Nice place 13',NULL,'2024-05-13',13),
(16,14,'Stay 14','Mumbai',8500,'Nice place 14',NULL,'2024-05-14',14),
(17,15,'Stay 15','Mumbai',9000,'Nice place 15',NULL,'2024-05-15',15),
(18,16,'Stay 16','Delhi',9500,'Nice place 16',NULL,'2024-05-16',16),
(19,17,'Stay 17','Delhi',10000,'Nice place 17',NULL,'2024-05-17',17),
(20,18,'Stay 18','Delhi',10500,'Nice place 18',NULL,'2024-05-18',18),
(21,19,'Stay 19','Delhi',11000,'Nice place 19',NULL,'2024-05-19',19),
(22,20,'Stay 20','Delhi',11500,'Nice place 20',NULL,'2024-05-20',20);

SELECT COUNT(*) FROM ACCOMMODATION;

INSERT INTO Booking 
(BookingID, GuestID, AccommodationID, CheckInDate, CheckOutDate, TotalPrice, PaymentStatus, TransactionDetails)
VALUES
(3,1,1,'2024-06-01','2024-06-05',8000,'Paid','TXN001'),
(4,2,2,'2024-06-02','2024-06-06',9000,'Paid','TXN002'),
(5,3,3,'2024-06-03','2024-06-07',10000,'Pending','TXN003'),
(6,4,4,'2024-06-04','2024-06-08',11000,'Paid','TXN004'),
(7,5,5,'2024-06-05','2024-06-09',12000,'Paid','TXN005'),
(8,6,6,'2024-06-06','2024-06-10',13000,'Pending','TXN006'),
(9,7,7,'2024-06-07','2024-06-11',14000,'Paid','TXN007'),
(10,8,8,'2024-06-08','2024-06-12',15000,'Paid','TXN008'),
(11,9,9,'2024-06-09','2024-06-13',16000,'Pending','TXN009'),
(12,10,10,'2024-06-10','2024-06-14',17000,'Paid','TXN010'),
(13,11,11,'2024-06-11','2024-06-15',18000,'Paid','TXN011'),
(14,12,12,'2024-06-12','2024-06-16',19000,'Pending','TXN012'),
(15,13,13,'2024-06-13','2024-06-17',20000,'Paid','TXN013'),
(16,14,14,'2024-06-14','2024-06-18',21000,'Paid','TXN014'),
(17,15,15,'2024-06-15','2024-06-19',22000,'Pending','TXN015'),
(18,16,16,'2024-06-16','2024-06-20',23000,'Paid','TXN016'),
(19,17,17,'2024-06-17','2024-06-21',24000,'Paid','TXN017'),
(20,18,18,'2024-06-18','2024-06-22',25000,'Pending','TXN018'),
(21,19,19,'2024-06-19','2024-06-23',26000,'Paid','TXN019'),
(22,20,20,'2024-06-20','2024-06-24',27000,'Paid','TXN020');

SELECT COUNT(*) FROM Booking;

INSERT INTO Payment 
(PaymentID, BookingID, PaymentMethod, PaymentStatus, PaymentDate)
VALUES
(1,1,'Credit Card','Paid','2024-06-01'),
(2,2,'PayPal','Paid','2024-06-02'),
(3,3,'Debit Card','Pending','2024-06-03'),
(4,4,'Bank Transfer','Paid','2024-06-04'),
(5,5,'Credit Card','Paid','2024-06-05'),
(6,6,'PayPal','Pending','2024-06-06'),
(7,7,'Debit Card','Paid','2024-06-07'),
(8,8,'Credit Card','Paid','2024-06-08'),
(9,9,'Bank Transfer','Pending','2024-06-09'),
(10,10,'PayPal','Paid','2024-06-10'),
(11,11,'Credit Card','Paid','2024-06-11'),
(12,12,'Bank Transfer','Pending','2024-06-12'),
(13,13,'Debit Card','Paid','2024-06-13'),
(14,14,'Credit Card','Paid','2024-06-14'),
(15,15,'Bank Transfer','Pending','2024-06-15'),
(16,16,'PayPal','Paid','2024-06-16'),
(17,17,'Credit Card','Paid','2024-06-17'),
(18,18,'Bank Transfer','Pending','2024-06-18'),
(19,19,'Debit Card','Paid','2024-06-19'),
(20,20,'Credit Card','Paid','2024-06-20');

ALTER TABLE Payment
ADD PaymentDate DATE;

SELECT COUNT(*) FROM Payment;

DESCRIBE Reservation;

INSERT INTO Reservation 
(ReservationID, BookingID, BookingDate, CheckIn, CheckOut, PaymentID)
VALUES
(1,1,'2024-05-25','2024-06-01','2024-06-05',1),
(2,2,'2024-05-26','2024-06-02','2024-06-06',2),
(3,3,'2024-05-27','2024-06-03','2024-06-07',3),
(4,4,'2024-05-28','2024-06-04','2024-06-08',4),
(5,5,'2024-05-29','2024-06-05','2024-06-09',5),
(6,6,'2024-05-30','2024-06-06','2024-06-10',6),
(7,7,'2024-05-31','2024-06-07','2024-06-11',7),
(8,8,'2024-06-01','2024-06-08','2024-06-12',8),
(9,9,'2024-06-02','2024-06-09','2024-06-13',9),
(10,10,'2024-06-03','2024-06-10','2024-06-14',10),
(11,11,'2024-06-04','2024-06-11','2024-06-15',11),
(12,12,'2024-06-05','2024-06-12','2024-06-16',12),
(13,13,'2024-06-06','2024-06-13','2024-06-17',13),
(14,14,'2024-06-07','2024-06-14','2024-06-18',14),
(15,15,'2024-06-08','2024-06-15','2024-06-19',15),
(16,16,'2024-06-09','2024-06-16','2024-06-20',16),
(17,17,'2024-06-10','2024-06-17','2024-06-21',17),
(18,18,'2024-06-11','2024-06-18','2024-06-22',18),
(19,19,'2024-06-12','2024-06-19','2024-06-23',19),
(20,20,'2024-06-13','2024-06-20','2024-06-24',20);

SELECT COUNT(*) FROM Reservation;

INSERT INTO Review 
(ReviewID, ReviewerID, ReviewedID, Rating, Comments)
VALUES
(1,1,2,4,'Good stay'),
(2,3,4,5,'Excellent'),
(3,5,6,3,'Average'),
(4,7,8,4,'Nice'),
(5,9,10,5,'Perfect'),
(6,11,12,2,'Not great'),
(7,13,14,4,'Good'),
(8,15,16,5,'Amazing'),
(9,17,18,3,'Okay'),
(10,19,20,4,'Nice'),
(11,2,1,5,'Great host'),
(12,4,3,4,'Good'),
(13,6,5,3,'Okay'),
(14,8,7,5,'Excellent'),
(15,10,9,4,'Nice'),
(16,12,11,2,'Bad'),
(17,14,13,4,'Good'),
(18,16,15,5,'Perfect'),
(19,18,17,3,'Average'),
(20,20,19,4,'Nice');

SELECT COUNT(*) FROM Review;

DESCRIBE NOTIFICATION;

INSERT INTO Complaint 
(ComplaintID, Explanation, Status, ResolutionDate, RelatedGuestID, RelatedHostID)
VALUES
(1,'Noise issue','Resolved','2024-06-01',1,1),
(2,'Cleanliness issue','Pending',NULL,2,2),
(3,'Late check-in','Resolved','2024-06-02',3,3),
(4,'Payment issue','Resolved','2024-06-03',4,4),
(5,'Booking error','Pending',NULL,5,5),
(6,'Host unavailable','Resolved','2024-06-04',6,6),
(7,'Wrong listing','Resolved','2024-06-05',7,7),
(8,'Security issue','Pending',NULL,8,8),
(9,'Overcharge','Resolved','2024-06-06',9,9),
(10,'No response','Resolved','2024-06-07',10,10),
(11,'Noise issue','Resolved','2024-06-08',11,11),
(12,'Cleanliness issue','Pending',NULL,12,12),
(13,'Late check-in','Resolved','2024-06-09',13,13),
(14,'Payment issue','Resolved','2024-06-10',14,14),
(15,'Booking error','Pending',NULL,15,15),
(16,'Host unavailable','Resolved','2024-06-11',16,16),
(17,'Wrong listing','Resolved','2024-06-12',17,17),
(18,'Security issue','Pending',NULL,18,18),
(19,'Overcharge','Resolved','2024-06-13',19,19),
(20,'No response','Resolved','2024-06-14',20,20);

INSERT INTO Notification 
(NotificationID, UserID, Message, Date)
VALUES
(1,1,'Booking confirmed','2024-06-01'),
(2,2,'Payment received','2024-06-02'),
(3,3,'New message','2024-06-03'),
(4,4,'Booking cancelled','2024-06-04'),
(5,5,'Reminder','2024-06-05'),
(6,6,'Booking confirmed','2024-06-06'),
(7,7,'Payment received','2024-06-07'),
(8,8,'New message','2024-06-08'),
(9,9,'Booking cancelled','2024-06-09'),
(10,10,'Reminder','2024-06-10'),
(11,11,'Booking confirmed','2024-06-11'),
(12,12,'Payment received','2024-06-12'),
(13,13,'New message','2024-06-13'),
(14,14,'Booking cancelled','2024-06-14'),
(15,15,'Reminder','2024-06-15'),
(16,16,'Booking confirmed','2024-06-16'),
(17,17,'Payment received','2024-06-17'),
(18,18,'New message','2024-06-18'),
(19,19,'Booking cancelled','2024-06-19'),
(20,20,'Reminder','2024-06-20');

SHOW TABLES;

SELECT COUNT(*) FROM Complaint;
SELECT COUNT(*) FROM Notification;

INSERT INTO Income (IncomeID, HostID, Amount, Date)
VALUES
(1,1,8000,'2024-06-01'),
(2,2,9000,'2024-06-02'),
(3,3,10000,'2024-06-03'),
(4,4,11000,'2024-06-04'),
(5,5,12000,'2024-06-05'),
(6,6,13000,'2024-06-06'),
(7,7,14000,'2024-06-07'),
(8,8,15000,'2024-06-08'),
(9,9,16000,'2024-06-09'),
(10,10,17000,'2024-06-10'),
(11,11,18000,'2024-06-11'),
(12,12,19000,'2024-06-12'),
(13,13,20000,'2024-06-13'),
(14,14,21000,'2024-06-14'),
(15,15,22000,'2024-06-15'),
(16,16,23000,'2024-06-16'),
(17,17,24000,'2024-06-17'),
(18,18,25000,'2024-06-18'),
(19,19,26000,'2024-06-19'),
(20,20,27000,'2024-06-20');

INSERT INTO Amenity (AmenityID, Name, Description)
VALUES
(1,'WiFi','Internet access'),
(2,'AC','Air conditioning'),
(3,'TV','Television'),
(4,'Parking','Car parking'),
(5,'Pool','Swimming pool'),
(6,'Gym','Fitness center'),
(7,'Kitchen','Cooking area'),
(8,'Washer','Laundry'),
(9,'Heater','Heating'),
(10,'Balcony','Outdoor space'),
(11,'WiFi','Internet access'),
(12,'AC','Air conditioning'),
(13,'TV','Television'),
(14,'Parking','Car parking'),
(15,'Pool','Swimming pool'),
(16,'Gym','Fitness center'),
(17,'Kitchen','Cooking area'),
(18,'Washer','Laundry'),
(19,'Heater','Heating'),
(20,'Balcony','Outdoor space');

INSERT INTO AmenityListing (PlaceID, AmenityID)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20);

DESCRIBE AmenityListing;

INSERT INTO Language (LanguageID, Name)
VALUES
(1,'English'),
(2,'German'),
(3,'French'),
(4,'Spanish'),
(5,'Italian'),
(6,'Dutch'),
(7,'Portuguese'),
(8,'Russian'),
(9,'Chinese'),
(10,'Japanese'),
(11,'English'),
(12,'German'),
(13,'French'),
(14,'Spanish'),
(15,'Italian'),
(16,'Dutch'),
(17,'Portuguese'),
(18,'Russian'),
(19,'Chinese'),
(20,'Japanese');

INSERT INTO UserLanguage (UserID, LanguageID)
VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10),
(11,11),(12,12),(13,13),(14,14),(15,15),
(16,16),(17,17),(18,18),(19,19),(20,20);

SHOW TABLES;
SELECT COUNT(*) FROM each_table;
