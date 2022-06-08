/*

 -----------------------------------------------------------------------------
     _                              _   _       _   _             ____  ____  
    / \   _ __ ___  _ __ ___  _   _| \ | | __ _| |_(_) ___  _ __ |  _ \| __ ) 
   / _ \ | '_ ` _ \| '_ ` _ \| | | |  \| |/ _` | __| |/ _ \| '_ \| | | |  _ \ 
  / ___ \| | | | | | | | | | | |_| | |\  | (_| | |_| | (_) | | | | |_| | |_) |
 /_/   \_\_| |_| |_|_| |_| |_|\__,_|_| \_|\__,_|\__|_|\___/|_| |_|____/|____/

 -----------------------------------------------------------------------------

    Name:           SP_CreateNewAttachmentForEntireCategory
    Author:         Florian Beqiraj
    Description:    Creates a new Attachment for all Weapons of a WeaponCategory. Based on existance, can create a new AttachmentType.

*/

USE AmmunationDB
GO

DROP PROCEDURE IF EXISTS SP_CreateNewAttachmentForEntireCategory
GO

CREATE PROCEDURE SP_CreateNewAttachmentForEntireCategory
    @Designation        NVARCHAR(50)
   ,@WeaponCategoryId   INT
   ,@TypeDesignation    NVARCHAR(50)
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

        DECLARE @AttachmentTypeId   INT
               ,@AttachmentId       INT
               ,@CurrentWeaponId    INT

        SET @AttachmentTypeId =
           (SELECT  Id
            FROM    AttachmentType
            WHERE   Designation = @TypeDesignation)

        IF (@AttachmentTypeId IS NULL)
        BEGIN
            INSERT INTO AttachmentType
                    (Designation)
            VALUES  (@TypeDesignation)

            SET @AttachmentTypeId = @@IDENTITY
        END

        INSERT INTO Attachment
                (AttachmentTypeId
                ,Designation)

        VALUES  (@AttachmentTypeId
                ,@Designation)

        SET @AttachmentId = @@IDENTITY

        DECLARE CR_CategoryWeapon CURSOR
            LOCAL
            FOR SELECT  Id
                FROM    Weapon
                WHERE   WeaponCategoryId = @WeaponCategoryId

        OPEN CR_CategoryWeapon

        FETCH NEXT FROM CR_CategoryWeapon
        INTO    @CurrentWeaponId

        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO WeaponPerAttachment
                    (WeaponId
                    ,AttachmentId)

            VALUES  (@CurrentWeaponId
                    ,@AttachmentId)

            FETCH NEXT FROM CR_CategoryWeapon
            INTO    @CurrentWeaponId
        END

        CLOSE       CR_CategoryWeapon
        DEALLOCATE  CR_CategoryWeapon

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