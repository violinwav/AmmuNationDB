--===============================================================
--        DROP AND RECREATE DATABASE
--===============================================================

USE master
GO
DROP DATABASE IF EXISTS AmmuNationDB
GO
CREATE DATABASE AmmuNationDB
GO
USE AmmuNationDB
GO

--===============================================================
--        CREATE TABLES
--===============================================================

CREATE TABLE WeaponCategory
(
    Id                      INT IDENTITY(1, 1)  NOT NULL    CONSTRAINT  PK_WeaponCategory       PRIMARY KEY
   ,[Name]                  NVARCHAR(50)        NOT NULL
)

CREATE TABLE AmmoType
(
    Id                      INT IDENTITY(1, 1)  NOT NULL    CONSTRAINT  PK_AmmoType             PRIMARY KEY
   ,Designation             NVARCHAR(50)        NOT NULL
   ,LengthInMilliMetre      INT                 NULL             
)

CREATE TABLE Weapon
(
    Id                      INT IDENTITY(1, 1)  NOT NULL    CONSTRAINT  PK_Weapon               PRIMARY KEY
   ,WeaponCategoryId        INT                 NOT NULL
   ,AmmoTypeId              INT                 NOT NULL
   ,Designation             NVARCHAR(50)        NOT NULL
   ,WeightInKilogram        INTEGER             NULL
   ,Origin                  NVARCHAR(50)        NULL
   ,MarketPriceInUsd        MONEY               NULL
   ,IsLegal                 BIT                 NULL
   ,DateOfManufacture       DATE                NULL
   ,TimePeriod              NVARCHAR(50)        NULL
)

CREATE TABLE AttachmentType
(
    Id                      INT IDENTITY(1, 1)  NOT NULL    CONSTRAINT  PK_AttachmentType       PRIMARY KEY
   ,Designation             NVARCHAR(50)        NOT NULL
)

CREATE TABLE Attachment
(
    Id                      INT IDENTITY(1, 1)  NOT NULL    CONSTRAINT  PK_Attachment           PRIMARY KEY
   ,AttachmentTypeId        INT                 NOT NULL
   ,Designation             NVARCHAR(50)        NOT NULL
)

CREATE TABLE WeaponPerAttachment
(
    Id                      INT IDENTITY(1, 1)  NOT NULL    CONSTRAINT  PK_WeaponPerAttachment  PRIMARY KEY
   ,WeaponId                INT                 NOT NULL
   ,AttachmentId            INT                 NOT NULL
)

GO

--===============================================================
--        ADD FOREIGN KEYS
--===============================================================

ALTER TABLE     Weapon
ADD CONSTRAINT  FK_Weapon_AmmoType
    FOREIGN KEY     (AmmoTypeId) 
        REFERENCES  AmmoType(Id)

ALTER TABLE     Weapon
ADD CONSTRAINT  FK_Weapon_WeaponCategory
    FOREIGN KEY     (WeaponCategoryId) 
        REFERENCES  WeaponCategory(Id)

ALTER TABLE     Attachment
ADD CONSTRAINT  FK_Attachment_AttachmentType
    FOREIGN KEY     (AttachmentTypeId) 
        REFERENCES  AttachmentType(Id)

ALTER TABLE     WeaponPerAttachment
ADD CONSTRAINT  FK_WeaponPerAttachment_Weapon
    FOREIGN KEY     (WeaponId) 
        REFERENCES  Weapon(Id)

ALTER TABLE     WeaponPerAttachment
ADD CONSTRAINT  FK_WeaponPerAttachment_Attachment
    FOREIGN KEY     (AttachmentId) 
        REFERENCES  Attachment(Id)

GO