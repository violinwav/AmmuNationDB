USE AmmuNationDB
GO

--===============================================================
--      INSERT INTO TABLES
--===============================================================

INSERT INTO AmmoType
        (Designation, LengthInMilliMetre)
VALUES  ('Lead Round Nose', 19)
       ,('Semi Wad Cutter', 38)
       ,('Semi-Jacketed', 40)
       ,('Full Metal Jacket', 9)
       ,('Semi-Jacketed Hollow Point', 24)
       ,('Jacketed Hollow Point', 45)
       ,('Special', NULL)

INSERT INTO WeaponCategory
        ([Name])
VALUES  ('Assault Rifle')
       ,('Shotgun')
       ,('Light Machine Gun')
       ,('Sub Machine Gun')
       ,('Sniper Rifle')
       ,('Pistol')

INSERT INTO Weapon
        (Designation, WeaponCategoryId, AmmoTypeId, WeightInKilogram, Origin, MarketPriceInUsd, IsLegal, DateOfManufacture, TimePeriod)
VALUES  ('Kalishnakov AK-47', 1, 2, 4, 'Soviet union', 3000.00, 0, TO_DATE('17.12.1944', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('17.12.1944', 'DD.MM.YYYY')))
       ,('Colt M4A1',         1, 3, 3, 'US Navy', 268.99, 0, TO_DATE('08.01.1987', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('08.01.1987', 'DD.MM.YYYY')))
       ,('SIG 556 PSD',       1, 4, 4, 'Swiss Arms AG', 2990.00, 1, TO_DATE('22.03.1986', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('22.03.1986', 'DD.MM.YYYY')))
       ,('H&K G-36',          4, 4, 6, 'Heckler & Koch', 11500.00, 0, TO_DATE('01.11.1997', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('01.11.1997', 'DD.MM.YYYY')))
       ,('FN Scar-H',         1, 5, 4, 'FN Herstal', 5434.00, 0, TO_DATE('01.01.2003', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('01.01.2003', 'DD.MM.YYYY')))
       ,('HK MP5',            4, 1, 3, 'Helmut Bareuther', 2499.00, 0, TO_DATE('11.07.1966', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('11.07.1966', 'DD.MM.YYYY')))
       ,('Arctic Warfare',    5, 6, 16, 'Accuracy International Ltd.', 8738.80, 0, TO_DATE('25.05.1982', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('25.05.1982', 'DD.MM.YYYY')))
       ,('Double Barrell'     2, 7, 3, 'Joseph Manton', 1450.00, 0, TO_DATE('24.09.1916', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('24.09.1916', 'DD.MM.YYYY')))
       ,('Glock',             6, 1, 1, 'Gaston Glock', 178.40, 1, TO_DATE('04.02.1980', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('04.02.1980', 'DD.MM.YYYY')))
       ,('RPD'                3, 3, 8, 'Degtjarjowwerk', 5300.00, 1, TO_DATE('01.01.1944', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('01.01.1944', 'DD.MM.YYYY')))
       ,('M60'                3, 6, 11, 'Saco Defense US Ordnance', 6000.00, 0, TO_DATE('19.12.1952', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('19.12.1952', 'DD.MM.YYYY')))
       ,('M1014'              2, 7, 4, 'Benelli Armi SPA', 2149.00, 1, TO_DATE('01.01.1998', 'DD.MM.YYYY'), FN_GetTimePeriod(TO_DATE('01.01.1998', 'DD.MM.YYYY')))

INSERT INTO AttachmentType
        (Designation)
VALUES  ('Silencer')
       ,('Scope')
       ,('Lazer Light')
       ,('Grip')
       ,('Magazine')

INSERT INTO Attachment
        (AttachmentTypeId, Designation)
VALUES  (1,          'CoD4')
       ,(1,          'MWR')
       ,(2,          'Iron Sight')
       ,(2,          'Reflex Sight')
       ,(2,          'Holo') --5
       ,(2,          'Red Dot Sight')
       ,(2,          'ACOG')
       ,(2,          'Infrared Scope')
       ,(2,          'Sniper Scope')
       ,(3,          'Lazer Sight') --10
       ,(4,          'Vertical Grip')
       ,(4,          'Angled Grip')
       ,(5,          'Extended Mag')
       ,(5,          'Box Magazine')
       ,(5,          'PPS Round Drum') --15
       ,(5,          'Thompsons Round Drum')

INSERT INTO WeaponPerAttachment
        (WeaponId, AttachmentId)
VALUES  (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 10), (1, 11), (1, 12), (1, 13)
       ,(2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 10), (2, 11), (2, 12), (2, 13)
       ,(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8), (3, 10), (3, 11), (3, 12), (3, 13), (3, 14)
       ,(4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 8), (4, 10), (4, 11), (4, 12), (4, 14), (4, 15)
       ,(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 10), (5, 11), (5, 12), (5, 13)
       ,(6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 8), (6, 10), (6, 11), (6, 12), (6, 14), (6, 15)
       ,(7, 2), (7, 9), (7, 10), (7, 12)
       ,(8, 5), (8, 10), (8, 11), (8, 12)
       ,(9, 2), (9, 3), (9, 6), (9, 10), (9, 13)
       ,(10, 2), (10, 3), (10, 4), (10, 5), (10, 6), (10, 8), (10, 10), (10, 11), (10, 13), (10, 15)
       ,(11, 2), (11, 3), (11, 4), (11, 5), (11, 6), (11, 8), (11, 10), (11, 11), (11, 13), (11, 15)
       ,(12, 5), (12, 10), (12, 11), (12, 12)