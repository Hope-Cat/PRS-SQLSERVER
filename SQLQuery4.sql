USE MASTER;

DROP DATABASE IF EXISTS prs;
CREATE DATABASE prs; 

USE prs;

CREATE TABLE Users
( ID	    INT				PRIMARY KEY IDENTITY,
  FirstName VARCHAR(50)		NOT NULL,
  LastName  VARCHAR(50)		NOT NULL,
  Phone     VARCHAR(13)     NOT NULL,
  Email     VARCHAR(75)     NOT NULL,
  Username  VARCHAR(20)     NOT NULL UNIQUE,
  Password  VARCHAR(20)     NOT NULL,
  Reviewer  BIT             NOT NULL,
  Admin     BIT             NOT NULL
);

CREATE TABLE PurchaseRequests
( RequestID			  INT				PRIMARY KEY IDENTITY,
  UserID			  INT				NOT NULL,
  Description		  VARCHAR(100)		NOT NULL,
  Justification       VARCHAR(255)      NOT NULL,
  DateNeeded		  Date				NOT NULL,
  DeliveryMode        VARCHAR(25)		NOT NULL,
  Status              VARCHAR(20)		NOT NULL,
  Total               SMALLMONEY		NOT NULL,
  SubmittedDate       DATETIME2			NOT NULL,
  ReasonForRejection  VARCHAR(255),
  CONSTRAINT FK_PRUser FOREIGN KEY (UserID)
  REFERENCES Users(ID)
);

CREATE TABLE Vendors
( VendorID			  INT				PRIMARY KEY IDENTITY,
  Code				  VARCHAR(10)       NOT NULL,
  Name                VARCHAR(255)      NOT NULL,
  Street              VARCHAR(255)      NOT NULL,
  City                VARCHAR(255)      NOT NULL,
  State               VARCHAR(2)        NOT NULL,
  Zip                 VARCHAR(10)       NOT NULL, 
  Email               VARCHAR(100)      NOT NULL,
  Phone               VARCHAR(13)       NOT NULL,
);

CREATE TABLE Products
( ProductID			  INT				PRIMARY KEY IDENTITY,
  VendorID			  INT		        NOT NULL,
  PartNumber          VARCHAR(50)       NOT NULL,
  Price               SMALLMONEY        NOT NULL,
  Name                VARCHAR(150)      NOT NULL,
  Unit                VARCHAR(255),
  Photopath           VARCHAR(255),
  FOREIGN KEY (VendorID)
  REFERENCES Vendors(VendorID)
  );
CREATE TABLE LineItems
  (LineItemID        INT               PRIMARY KEY IDENTITY,
   RequestID         INT               NOT NULL,
   ProductID         INT               NOT NULL,
   Quantity          INT               NOT NULL,
   CONSTRAINT PR_Prod UNIQUE(RequestID, ProductID),
   FOREIGN KEY (ProductID) 
   References Products(ProductID),
   FOREIGN KEY (RequestID)
   References PurchaseRequests(RequestID)
  );