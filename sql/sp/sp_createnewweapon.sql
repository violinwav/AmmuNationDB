/*

 -----------------------------------------------------------------------------
     _                              _   _       _   _             ____  ____  
    / \   _ __ ___  _ __ ___  _   _| \ | | __ _| |_(_) ___  _ __ |  _ \| __ ) 
   / _ \ | '_ ` _ \| '_ ` _ \| | | |  \| |/ _` | __| |/ _ \| '_ \| | | |  _ \ 
  / ___ \| | | | | | | | | | | |_| | |\  | (_| | |_| | (_) | | | | |_| | |_) |
 /_/   \_\_| |_| |_|_| |_| |_|\__,_|_| \_|\__,_|\__|_|\___/|_| |_|____/|____/

 -----------------------------------------------------------------------------

    Name:           SP_CreateNewWeapon
    Author:         Alessio Vangelisti
    Description:    Creates a new Weapon. Based on existance, can create a new WeaponCategory and / or AmmoType.

*/

USE AmmunationDB
GO

DROP PROCEDURE IF EXISTS SP_CreateNewWeapon
GO

CREATE PROCEDURE SP_CreateNewWeapon
    @Designation            NVARCHAR(50)
   ,@CategoryName           NVARCHAR(50)
   ,@AmmoTypeDesignation    NVARCHAR(50)
   ,@WeightInKilogram       INTEGER
   ,@Origin                 NVARCHAR(50)
   ,@IsLegal                BIT
   ,@MarketPriceInUsd       MONEY
   ,@DateOfManufacture      DATE
AS
    BEGIN TRY
        DECLARE @TranCounter INT = @@TRANCOUNT

        IF @TranCounter > 0
        BEGIN
            SAVE TRANSACTION CreateNewWeaponSave
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION 
        END

        DECLARE @WeaponCategoryId   INT
               ,@AmmoTypeId         INT

        SET @WeaponCategoryId =
           (SELECT  Id
            FROM    WeaponCategory
            WHERE   [Name] = @CategoryName)

        IF (@WeaponCategoryId IS NULL)
        BEGIN
            INSERT INTO WeaponCategory
                    ([Name])
            VALUES  (@CategoryName)

            SET @WeaponCategoryId = @@IDENTITY
        END

        SET @AmmoTypeId =
           (SELECT  Id
            FROM    AmmoType
            WHERE   Designation = @AmmoTypeDesignation)

        IF (@AmmoTypeId IS NULL)
        BEGIN
            INSERT INTO AmmoType
                    (Designation)
            VALUES  (@AmmoTypeDesignation)

            SET @AmmoTypeId = @@IDENTITY
        END

        INSERT INTO Weapon
            (WeaponCategoryId       
            ,AmmoTypeId 
            ,Designation      
            ,WeightInKilogram 
            ,Origin           
            ,MarketPriceInUsd 
            ,IsLegal          
            ,DateOfManufacture)

        VALUES  (@AmmoTypeId
            ,@WeaponCategoryId
            ,@Designation
            ,@WeightInKilogram 
            ,@Origin           
            ,@IsLegal          
            ,@MarketPriceInUsd       
            ,@DateOfManufacture)
        
        IF @TranCounter = 0
        BEGIN
            COMMIT TRANSACTION 
        END
    END TRY
    BEGIN CATCH
        IF @TranCounter = 0
        BEGIN
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            IF XACT_STATE() <> -1
            BEGIN
                ROLLBACK TRANSACTION CreateNewSupplierOrderSave
            END
        END
    END CATCH
GO