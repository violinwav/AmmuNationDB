USE AmmuNationDB
GO

--===============================================================
--      INSERT INTO TABLES
--===============================================================

-- todo AmmoType

INSERT INTO WeaponCategory
        ([Name])
VALUES  ('Assault Rifle')
       ,('Shotgun')
       ,('Light Machine Gun')
       ,('Sub Machine Gun')
       ,('Sniper Rifle')
       ,('Pistol')

INSERT INTO AmmoType
        (Designation)
VALUES  ('Type1')
       ,('Type2')
       ,('Type3')
       ,('Type4')
       ,('Type5')

-- todo Add Relations and other
INSERT INTO Weapon
        (Designation,           WeaponCategoryId,       AmmoTypeId)
VALUES  ('Kalishnakov AK-47',   1,                      1)
       ,('ColT M4A1',           2,                      2)
       ,('SIG 556 PSD',         3,                      3)
       ,('H&K G-36',            4,                      4)
       ,('FN Scar-H',           5,                      5)

INSERT INTO AttachmentType
        (Designation)
VALUES  ('Silencer')
       ,('Scope')
       ,('Lazer Light')
       ,('Handle')
       ,('Magazine')

INSERT INTO Attachment
        (AttachmentTypeId, Designation)
VALUES  (1,          'Attachment1')
       ,(2,          'Attachment2')
       ,(3,          'Attachment3')
       ,(4,          'Attachment4')
       ,(5,          'Attachment5')
