/*

 -----------------------------------------------------------------------------
     _                              _   _       _   _             ____  ____  
    / \   _ __ ___  _ __ ___  _   _| \ | | __ _| |_(_) ___  _ __ |  _ \| __ ) 
   / _ \ | '_ ` _ \| '_ ` _ \| | | |  \| |/ _` | __| |/ _ \| '_ \| | | |  _ \ 
  / ___ \| | | | | | | | | | | |_| | |\  | (_| | |_| | (_) | | | | |_| | |_) |
 /_/   \_\_| |_| |_|_| |_| |_|\__,_|_| \_|\__,_|\__|_|\___/|_| |_|____/|____/

 -----------------------------------------------------------------------------

    Name:           TR_UpdateWeaponTimePeriod
    Author:         Florian Beqiraj
    Description:    Updates the TimePeriod after Weapon Insert.

*/

USE AmmuNationDB
GO 

DROP TRIGGER IF EXISTS TR_UpdateWeaponTimePeriod
GO

CREATE TRIGGER TR_UpdateWeaponTimePeriod
ON Weapon
AFTER INSERT
AS 
    BEGIN TRY
        DECLARE @TranCounter    INT = @@TRANCOUNT

        IF @TranCounter > 0
        BEGIN
            SAVE TRANSACTION CustomerUpdateSave
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION 
        END

        DECLARE @InsertedWeaponId INT
        SELECT  @InsertedWeaponId = ID FROM INSERTED
        
        DECLARE @WeaponDateOfManufacture DATE = 
           (SELECT  DateOfManufacture
            FROM    Weapon
            WHERE   Id = @InsertedWeaponId)
        

        IF @WeaponDateOfManufacture IS NULL
        BEGIN
            RETURN
        END

        UPDATE  Weapon
        SET     TimePeriod = dbo.FN_GetTimePeriod(@WeaponDateOfManufacture)
        WHERE   Id = @InsertedWeaponId

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
                ROLLBACK TRANSACTION CustomerUpdateSave
            END
        END
    END CATCH
GO