/*

 -----------------------------------------------------------------------------
     _                              _   _       _   _             ____  ____  
    / \   _ __ ___  _ __ ___  _   _| \ | | __ _| |_(_) ___  _ __ |  _ \| __ ) 
   / _ \ | '_ ` _ \| '_ ` _ \| | | |  \| |/ _` | __| |/ _ \| '_ \| | | |  _ \ 
  / ___ \| | | | | | | | | | | |_| | |\  | (_| | |_| | (_) | | | | |_| | |_) |
 /_/   \_\_| |_| |_|_| |_| |_|\__,_|_| \_|\__,_|\__|_|\___/|_| |_|____/|____/

 -----------------------------------------------------------------------------

    Name:           FN_GetTimePeriod
    Author:         Florian Beqiraj
    Description:    Creates a new Attachment for all Weapons of a WeaponCategory. Based on existance, can create a new AttachmentType.

*/

USE AmmuNationDB
GO

DROP FUNCTION IF EXISTS FN_GetTimePeriod
GO

CREATE FUNCTION FN_GetTimePeriod
(
    @Date   DATE
)
RETURNS NVARCHAR(50)
AS
BEGIN
    IF @Date >= '2000-01-01'
    BEGIN
        RETURN 'AFTER 2000'
    END

    IF @Date >= '1939-09-01'
    BEGIN
        RETURN 'WWII'
    END

    IF @Date >= '1914-07-28' AND @Date >= '1900-01-01'
    BEGIN
        RETURN 'WWI'
    END

    RETURN 'BEFORE 1900'
END
GO

