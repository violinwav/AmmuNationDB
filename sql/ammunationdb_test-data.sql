USE AmmuNationDB
GO

--===============================================================
--      INSERT INTO TABLES
--===============================================================

-- todo AmmoType

INSERT INTO WeaponCategory
        (Id,                                        [Name])
VALUES  ('94135ec0-8515-403c-8879-9fbef6891376',    'Assault Rifle')
       ,('be0f6fee-0cd5-4aac-b19a-e925cd8e3709',    'Shotgun')
       ,('2018d72b-00e7-4a3b-aa38-d4c949af0123',    'Light Machine Gun')
       ,('8bc9d81c-1ed4-4026-bf6e-eae8a793d6c0',    'Sub Machine Gun')
       ,('21c355f8-f062-471f-85fc-c1ede943ffae',    'Sniper Rifle')
       ,('ec947540-e185-11ec-8fea-0242ac120002',    'Pistol')

-- todo Add Relations and other
INSERT INTO Weapon
        (Designation)
VALUES  ('Kalishnakov AK-47')
       ,('ColT M4A1')
       ,('SIG 556 PSD')
       ,('H&K G-36')
       ,('FN Scar-H')

INSERT INTO AttachmentType
        (Id,                                        Designation)
VALUES  ('4f34c75e-f195-4c0d-9c22-a3a44db08d7e',    'Silencer')
       ,('bf49e2a5-39f8-41f9-b818-9bc4fdb7b8a9',    'Scope')
       ,('2c190c2a-f6e0-413b-b44d-1e7e9d0ac252',    'Lazer Light')
       ,('92684592-a49f-4103-8f03-5aaba59fe6e3',    'Handle')
       ,('65f52ad7-23f1-4e88-8d64-80795fa6d0e3',    'Magazine')

-- todo Attachment
-- todo WeaponPerAttachment
