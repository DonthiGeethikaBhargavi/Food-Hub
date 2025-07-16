-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: fooddeliveryapp
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `MenuId` int NOT NULL AUTO_INCREMENT,
  `RestaurantId` int NOT NULL,
  `ItemName` varchar(100) NOT NULL,
  `Description` text,
  `Price` decimal(10,2) NOT NULL,
  `Ratings` decimal(3,2) DEFAULT '0.00',
  `IsAvailable` tinyint(1) DEFAULT '1',
  `ImagePath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MenuId`),
  UNIQUE KEY `RestaurantId` (`RestaurantId`,`ItemName`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`RestaurantId`) REFERENCES `restaurant` (`RestaurantId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,'Margherita Pizza','Classic cheese and tomato pizza',8.99,4.50,1,'images/margherita.jpg'),(2,1,'Pepperoni Pizza','Spicy pepperoni with mozzarella cheese',10.99,4.70,1,'images/pepperoni.jpg'),(3,2,'Veggie Burger','Fresh veggies with a sesame bun',6.99,4.20,1,'images/veggieburger.jpg'),(4,2,'Chicken Sandwich','Grilled chicken breast with lettuce and mayo',7.99,4.40,1,'images/grilledchicken.jpg'),(5,3,'Pasta Alfredo','Creamy Alfredo sauce with fettuccine',9.99,4.60,1,'images/alfredo.jpg'),(6,3,'Caesar Salad','Fresh lettuce, croutons, and Caesar dressing',5.99,4.30,1,'images/caesarsalad.jpg'),(7,4,'Butter Chicken','Rich tomato-based curry with butter and spices',11.99,4.80,1,'images/butterchicken.jpg'),(8,4,'Paneer Tikka','Grilled paneer cubes with spices',8.99,4.50,1,'images/paneertikka.jpg'),(9,5,'Sushi Roll','Fresh sushi with salmon and avocado',12.99,4.90,1,'images/sushiroll.jpg'),(10,5,'Miso Soup','Traditional Japanese soup with tofu',4.99,4.20,1,'images/misosoup.jpg'),(11,6,'Tacos al Pastor','Marinated pork with pineapple, served on soft corn tortillas.',8.99,4.50,1,'images/tacos_al_pastor.jpg'),(12,6,'Chicken Quesadilla','Grilled flour tortilla filled with melted cheese and shredded chicken.',7.99,4.30,1,'images/chicken_quesadilla.jpg'),(13,7,'Cheeseburger','Juicy beef patty with melted cheese, lettuce, and tomato on a toasted bun.',10.49,4.60,1,'images/cheeseburger.jpg'),(14,7,'Fries','Crispy golden fries with a side of ketchup.',4.99,4.20,1,'images/fries.jpg'),(15,8,'Falafel Wrap','Crispy falafel balls wrapped in pita with hummus, tahini, and veggies.',9.99,4.50,1,'images/falafel_wrap.jpg'),(16,8,'Hummus Platter','Creamy hummus served with olive oil, paprika, and warm pita bread.',7.99,4.40,1,'images/hummus_platter.jpg'),(17,9,'Croissant','Buttery, flaky pastry made with premium French butter.',4.99,4.70,1,'images/croissant.jpg'),(18,9,'French Onion Soup','Rich beef broth with caramelized onions and melted cheese on top.',8.99,4.60,1,'images/french_onion_soup.jpg'),(19,10,'Pad Thai','Classic stir-fried rice noodles with shrimp, tofu, and crushed peanuts.',12.99,4.80,1,'images/pad_thai.jpg'),(20,10,'Mango Sticky Rice','Sweet sticky rice served with ripe mango and coconut milk.',7.99,4.60,1,'images/mango_sticky_rice.jpg');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderhistory`
--

DROP TABLE IF EXISTS `orderhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderhistory` (
  `OrderHistoryID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `OrderId` varchar(20) NOT NULL,
  `OrderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `Status` enum('Delivered','Cancelled','Returned') NOT NULL,
  `RestaurantID` int DEFAULT NULL,
  `MenuItems` text,
  `RestaurantName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`OrderHistoryID`),
  KEY `UserID` (`UserID`),
  KEY `OrderID` (`OrderId`),
  KEY `RestaurantID` (`RestaurantID`),
  CONSTRAINT `orderhistory_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserId`),
  CONSTRAINT `orderhistory_ibfk_2` FOREIGN KEY (`RestaurantID`) REFERENCES `restaurant` (`RestaurantId`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderhistory`
--

LOCK TABLES `orderhistory` WRITE;
/*!40000 ALTER TABLE `orderhistory` DISABLE KEYS */;
INSERT INTO `orderhistory` VALUES (1,1,'ORDFHIBDXMARO57S','2025-02-11 22:41:49',19.98,'Delivered',1,'Margherita Pizza','Italian Bistro'),(2,2,'ORDFHSGESMAR2IFY','2025-02-11 22:41:49',14.98,'Cancelled',2,'Veggie Burger','Spice Garden'),(3,3,'ORDFHSHLJMARFZNT','2025-02-11 22:41:49',15.98,'Delivered',3,'Pasta Alfredo','Sushi House'),(4,4,'ORDFHBNOBMARKR76','2025-02-11 22:41:49',20.98,'Returned',4,'Butter Chicken','BBQ Nation'),(5,5,'ORDFHVDNWMARR49B','2025-02-11 22:41:49',17.98,'Delivered',5,'Sushi Roll','Vegan Delight'),(6,1,'ORDFHSHDXMARP4DR','2025-02-11 22:41:49',9.99,'Cancelled',3,'Caesar Salad','Sushi House'),(7,2,'ORDFHBNESMARWNYM','2025-02-11 22:41:49',11.99,'Delivered',4,'Paneer Tikka','BBQ Nation'),(8,3,'ORDFHVDLJMARD9QZ','2025-02-11 22:41:49',12.99,'Returned',5,'Miso Soup','Vegan Delight'),(9,4,'ORDFHIBOBMARP7GW','2025-02-11 22:41:49',10.99,'Cancelled',1,'Pepperoni Pizza','Italian Bistro'),(10,5,'ORDFHSGNWMARI53T','2025-02-11 22:41:49',7.99,'Delivered',2,'Chicken Sandwich','Spice Garden'),(11,2,'ORDFHVDESMARY0HD','2025-03-21 20:12:30',4.99,'Delivered',5,'Miso Soup','Vegan Delight'),(12,2,'ORDFHVDESMARLZGE','2025-03-21 10:00:20',4.99,'Delivered',5,'Miso Soup','Vegan Delight'),(13,4,'ORDFHVDOBMARC9AT','2025-03-21 18:00:20',12.99,'Delivered',5,'Sushi Roll','Vegan Delight'),(14,4,'ORDFHSHOBMARAI4K','2025-03-22 16:02:37',9.99,'Delivered',3,'Pasta Alfredo (x1)','Sushi House'),(15,4,'ORDFHSGOBMAREUUL','2025-03-22 18:45:53',7.99,'Delivered',2,'Chicken Sandwich (x1)','Spice Garden'),(16,2,'ORDFHIBESMAR32D1','2025-03-22 19:03:13',10.99,'Delivered',1,'Pepperoni Pizza (x1)','Italian Bistro'),(18,2,'ORDFHVDESMARRTXB','2025-03-22 22:33:31',4.99,'Delivered',5,'Miso Soup (x1)','Vegan Delight'),(19,2,'ORDFHSHESMARS1K0','2025-03-23 14:57:23',5.99,'Delivered',3,'Caesar Salad (x1)','Sushi House'),(20,4,'ORDFHVDOBMARZFH3','2025-03-23 18:25:48',12.99,'Delivered',5,'Sushi Roll (x1)','Vegan Delight'),(21,2,'ORDFHSHESMAR39E9','2025-03-25 11:31:12',5.99,'Delivered',3,'Caesar Salad (x1)','Sushi House'),(22,2,'ORDFHBNESJUNITTZ','2025-06-09 18:59:24',23.98,'Delivered',4,'Butter Chicken (x2)','BBQ Nation');
/*!40000 ALTER TABLE `orderhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitem`
--

DROP TABLE IF EXISTS `orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitem` (
  `OrderItemId` int NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(20) NOT NULL,
  `MenuId` int NOT NULL,
  `Quantity` int NOT NULL,
  `TotalPrice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderItemId`),
  UNIQUE KEY `OrderId` (`OrderId`,`MenuId`),
  KEY `MenuId` (`MenuId`),
  CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`MenuId`) REFERENCES `menu` (`MenuId`),
  CONSTRAINT `orderitem_chk_1` CHECK ((`Quantity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitem`
--

LOCK TABLES `orderitem` WRITE;
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
INSERT INTO `orderitem` VALUES (1,'ORDFHIBDXMARO57S',1,2,17.98),(2,'ORDFHSGESMAR2IFY',3,1,6.99),(3,'ORDFHSHLJMARFZNT',5,2,19.98),(4,'ORDFHBNOBMARKR76',7,1,11.99),(5,'ORDFHVDNWMARR49B',9,1,12.99),(6,'ORDFHSHDXMARP4DR',6,1,5.99),(7,'ORDFHBNESMARWNYM',8,1,8.99),(8,'ORDFHVDLJMARD9QZ',10,2,9.98),(9,'ORDFHIBOBMARP7GW',2,1,10.99),(10,'ORDFHSGNWMARI53T',4,1,7.99),(11,'ORDFHBNESMARBEO2',8,1,8.99),(12,'ORDFHVDESMARY0HD',10,1,4.99),(13,'ORDFHVDESMARLZGE',10,1,4.99),(14,'ORDFHVDOBMARC9AT',9,1,12.99),(15,'ORDFHSHOBMARAI4K',5,1,9.99),(16,'ORDFHBNOBMAR9TWV',7,1,11.99),(17,'ORDFHSGOBMAREUUL',4,1,7.99),(18,'ORDFHIBESMAR32D1',2,1,10.99),(20,'ORDFHVDESMARRTXB',10,1,4.99),(21,'ORDFHSHESMARS1K0',6,1,5.99),(22,'ORDFHVDOBMARZFH3',9,1,12.99),(23,'ORDFHSHESMAR39E9',6,1,5.99),(24,'ORDFHBNESJUNITTZ',7,2,11.99);
/*!40000 ALTER TABLE `orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordertable`
--

DROP TABLE IF EXISTS `ordertable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordertable` (
  `OrderId` varchar(20) NOT NULL,
  `UserId` int NOT NULL,
  `RestaurantId` int NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `TotalAmount` decimal(10,2) NOT NULL,
  `Status` enum('Pending','Delivered','Cancelled','In Progress') NOT NULL DEFAULT 'Pending',
  `PaymentMode` enum('UPI','Cash','Debit Card','Credit Card') NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `UserId` (`UserId`),
  KEY `RestaurantId` (`RestaurantId`),
  CONSTRAINT `ordertable_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`),
  CONSTRAINT `ordertable_ibfk_2` FOREIGN KEY (`RestaurantId`) REFERENCES `restaurant` (`RestaurantId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordertable`
--

LOCK TABLES `ordertable` WRITE;
/*!40000 ALTER TABLE `ordertable` DISABLE KEYS */;
INSERT INTO `ordertable` VALUES ('ORDFHBNESJUNITTZ',2,4,'2025-06-09 18:59:23',23.98,'Pending','Cash'),('ORDFHBNESMARBEO2',2,4,'2025-03-21 22:41:49',8.99,'Pending','Cash'),('ORDFHBNESMARWNYM',2,4,'2025-02-11 22:41:49',11.99,'Pending','Credit Card'),('ORDFHBNOBMAR9TWV',4,4,'2025-03-22 00:00:00',11.99,'Pending','Credit Card'),('ORDFHBNOBMARKR76',4,4,'2025-02-11 22:41:49',20.98,'In Progress','Debit Card'),('ORDFHIBDXMARO57S',1,1,'2025-02-11 22:41:49',19.98,'Delivered','Credit Card'),('ORDFHIBESMAR32D1',2,1,'2025-03-22 19:03:13',10.99,'Pending','Cash'),('ORDFHIBESMAR4BPS',2,1,'2025-03-20 22:41:49',8.99,'Pending','UPI'),('ORDFHIBESMARYVYH',2,1,'2025-03-20 22:41:41',8.99,'Pending','Cash'),('ORDFHIBESMARZB1G',2,1,'2025-03-19 22:41:49',8.99,'Pending','UPI'),('ORDFHIBOBMARP7GW',4,1,'2025-02-11 22:41:49',10.99,'Cancelled','Debit Card'),('ORDFHIBOBMARUAJT',4,1,'2025-03-20 22:41:49',19.98,'Pending','Cash'),('ORDFHSGESMAR2IFY',2,2,'2025-02-11 22:41:49',14.98,'Pending','UPI'),('ORDFHSGESMARO7HR',2,2,'2025-03-19 22:41:49',6.99,'Pending','Debit Card'),('ORDFHSGNWMARI53T',5,2,'2025-02-11 22:41:49',7.99,'Delivered','Cash'),('ORDFHSGOBMAREUUL',4,2,'2025-03-22 18:45:53',7.99,'Pending','UPI'),('ORDFHSHDXMARP4DR',1,3,'2025-02-11 22:41:49',9.99,'Delivered','Cash'),('ORDFHSHESMAR39E9',2,3,'2025-03-25 11:31:12',5.99,'Pending','Credit Card'),('ORDFHSHESMARS1K0',2,3,'2025-03-23 14:57:23',5.99,'Pending','Credit Card'),('ORDFHSHLJMARFZNT',3,3,'2025-02-11 22:41:49',15.98,'Cancelled','Cash'),('ORDFHSHOBMARAI4K',4,3,'2025-03-22 00:00:00',9.99,'Pending','Debit Card'),('ORDFHVDESMAR21IV',2,5,'2025-03-22 22:22:23',4.99,'Pending','Cash'),('ORDFHVDESMARLZGE',2,5,'2025-03-21 22:41:49',4.99,'Pending','Credit Card'),('ORDFHVDESMARRTXB',2,5,'2025-03-22 22:33:31',4.99,'Pending','Cash'),('ORDFHVDESMARY0HD',2,5,'2025-03-21 22:41:49',4.99,'Pending','Credit Card'),('ORDFHVDLJMARD9QZ',3,5,'2025-02-11 22:41:49',12.99,'In Progress','UPI'),('ORDFHVDNWMARR49B',5,5,'2025-02-11 22:41:49',17.98,'Delivered','UPI'),('ORDFHVDOBMARC9AT',4,5,'2025-03-21 22:41:49',12.99,'Pending','UPI'),('ORDFHVDOBMARZFH3',4,5,'2025-03-23 18:25:48',12.99,'Pending','Cash');
/*!40000 ALTER TABLE `ordertable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `RestaurantId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Address` text NOT NULL,
  `Rating` decimal(3,2) DEFAULT '0.00',
  `CuisineType` varchar(100) DEFAULT NULL,
  `IsActive` tinyint(1) DEFAULT '1',
  `EstimatedDeliveryTime` int NOT NULL DEFAULT '30',
  `AdminUserId` int DEFAULT NULL,
  `ImagePath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RestaurantId`),
  UNIQUE KEY `Name` (`Name`),
  UNIQUE KEY `AdminUserId` (`AdminUserId`),
  CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`AdminUserId`) REFERENCES `user` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Italian Bistro','123 Main St, New York, NY',4.50,'Italian',1,25,1,'images/italian_bistro.jpg'),(2,'Spice Garden','456 Elm St, Los Angeles, CA',4.70,'Indian',1,30,2,'images/spice_garden.jpg'),(3,'Sushi House','789 Oak St, San Francisco, CA',4.60,'Japanese',1,35,3,'images/sushi_house.jpg'),(4,'BBQ Nation','101 Pine St, Houston, TX',4.30,'BBQ',1,40,4,'images/bbq_nation.jpg'),(5,'Vegan Delight','202 Maple St, Seattle, WA',4.80,'Vegan',1,20,5,'images/vegan_delight.jpg'),(6,'Taco Fiesta','303 Birch St, Austin, TX',4.20,'Mexican',1,30,6,'images/taco_fiesta.jpg'),(7,'Burger Joint','404 Cedar St, Chicago, IL',4.40,'American',1,25,7,'images/burger_joint.jpg'),(8,'Mediterranean Flavors','505 Walnut St, Miami, FL',4.60,'Mediterranean',1,35,8,'images/mediterranean_flavors.jpg'),(9,'French Cafe','606 Cherry St, Boston, MA',4.50,'French',1,30,9,'images/french_cafe.jpg'),(10,'Thai Spice','707 Willow St, Denver, CO',4.70,'Thai',1,30,10,'images/thai_spice.jpg');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Address` text,
  `Role` enum('Customer','RestaurantAdmin','SystemAdmin') NOT NULL,
  `CreatedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastLoginDate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Phone` (`Phone`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Doe','doe','ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f','doe@example.com','1234567890','123 Main St, New York, NY','Customer','2025-02-11 17:11:49',NULL),(2,'Emma Smith','emmasmith','fbb4a8a163ffa958b4f02bf9cabb30cfefb40de803f2c4c346a9d39b3be1b544','emma@example.com','1234567891','456 Elm St, Los Angeles, CA','Customer','2025-02-11 17:11:49',NULL),(3,'Liam Johnson','liamj','7d2f70b98ad545fae9b0c190df99702f4cf64b97d1732bdb36eeb014899fd688','liam@example.com','1234567892','789 Oak St, San Francisco, CA','Customer','2025-02-11 17:11:49',NULL),(4,'Olivia Brown','oliviab','203d53614c56261b89b2ef5e086df12f1d5208f903f0b6099813d1def7e46518','olivia@example.com','1234567893','101 Pine St, Houston, TX','RestaurantAdmin','2025-02-11 17:11:49',NULL),(5,'Noah Wilson','noahw','43a0088bbceeab1fa69770061e3d1a1fafc6b7fcce79953fcfd120fb179cf890','noah@example.com','1234567894','202 Maple St, Seattle, WA','RestaurantAdmin','2025-02-11 17:11:49',NULL),(6,'Ava Taylor','avat','6ce324b867eaa75a4c47eb250697def37fba30e8a5d33f4b5d69d8a7e2717f38','ava@example.com','1234567895','303 Birch St, Austin, TX','RestaurantAdmin','2025-02-11 17:11:49',NULL),(7,'William Martinez','williamm','14761ca7c08ed8e670a0cd11cd72fc137716ca5a946f72be0865d026a74a123d','william@example.com','1234567896','404 Cedar St, Chicago, IL','Customer','2025-02-11 17:11:49',NULL),(8,'Sophia Anderson','sophiaa','3b60679fb67f5bd6af2ffc5fc051981262bd00190f3a9ab011550ec4249586b1','sophia@example.com','1234567897','505 Walnut St, Miami, FL','SystemAdmin','2025-02-11 17:11:49',NULL),(9,'James Thomas','jamest','249bbac706e15fc9f93dba1ba00b5b7cc5a4b6f2a7d57a4a50b944dbd45ecd41','james@example.com','1234567898','606 Cherry St, Boston, MA','SystemAdmin','2025-02-11 17:11:49',NULL),(10,'Isabella White','isabellaw','e5cccf98fc6b77d1b69ee4167163449266648a0774490f0ef529f5cb38f415b0','isabella@example.com','1234567899','707 Willow St, Denver, CO','Customer','2025-02-11 17:11:49',NULL),(11,'Rahul Sharma','rahul123','50ecfb9d5c128b95dbdaa24e71e89115f5c0363c1d4491f4a6fd967497112989','rahul.sharma@gmail.com','9876543210','123, MG Road, Bangalore','Customer','2025-03-23 17:46:59',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-06 13:58:28
