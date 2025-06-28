INSERT INTO `gym2`.`miestas` (`pavadinimas`) VALUES
('Vilnius'),
('Kaunas'),
('Panevezys');


INSERT INTO `gym2`.`klientas` (`vardas`, `pavarde`, `asmens_kodas`, `adresas`, `miestas_id`) VALUES
('Jonas', 'Kazlauskas', '39001010001', 'Gedimino pr. 10', 1),
('Ieva', 'Petrauskaitė', '49102020002', 'Žirmūnų g. 15-3', 1),
('Tomas', 'Jankauskas', '38503150003', 'Kalvarijų g. 33', 1),
('Monika', 'Stankevičiūtė', '49804040004', 'Ozo g. 7', 1),
('Darius', 'Bieliauskas', '38005050005', 'Savanorių pr. 100', 2),
('Simona', 'Vaitkutė', '49506060006', 'Taikos pr. 55', 2),
('Rokas', 'Urbonas', '38707070007', 'A. Mickevičiaus g. 12', 2),
('Eglė', 'Paulauskaitė', '49208080008', 'Kovo 11-osios g. 20', 2),
('Mantas', 'Žukauskas', '38909090009', 'Naugarduko g. 3', 1),
('Greta', 'Sabaliauskaitė', '49410100010', 'Laisvės pr. 66', 1);

INSERT INTO `gym2`.`juridinis_asmuo` 
(`pavadinimas`, `pvm_moketojo_kodas`, `imones_kodas`, `adresas`, `miestas_id`) VALUES
('UAB Fitness Solutions', 'LT100200300', '3030303030303', 'Vilniaus g. 10', 1),
('AB Sporto Klubas', 'LT200300400', '4040404040404', 'Kauno g. 20', 2),
('UAB GymPro', 'LT300400500', '5050505050505', 'Gedimino pr. 15', 1),
('UAB Active Life', 'LT400500600', '6060606060606', 'Taikos pr. 5', 2),
('UAB Sportas Plus', 'LT500600700', '7070707070707', 'Savanorių pr. 30', 1),
('UAB Healthy Move', 'LT600700800', '8080808080808', 'Kęstučio g. 45', 2),
('UAB Fit4Life', 'LT700800900', '9090909090909', 'A. Mickevičiaus g. 11', 1),
('UAB Strong Body', 'LT800900100', '1010101010101', 'Vilkpėdės g. 50', 2),
('UAB Gym Active', 'LT900100200', '2020202020202', 'Laisvės al. 23', 1),
('UAB Power Gym', 'LT100200300', '3030303030304', 'Žalgirio g. 9', 2);

INSERT INTO `gym2`.`naryste` (`pavadinimas`, `menesio_kaina`) VALUES
('Start', 19.99),
('Easy', 29.99),
('Flexi', 39.99);

INSERT INTO `gym2`.`preke` (`pavadinimas`, `aprasymas`, `tipas`) VALUES
('Asmeninė treniruotė', 'Individuali treniruotė su treneriu', 'paslauga'),
('Masažo seansas', '45 min. sportinis masažas', 'paslauga'),
('Grupinė joga', 'Grupinė jogos treniruotė visiems lygiams', 'paslauga'),
('Baltyminiai milteliai', '1kg išrūgų baltymų papildas', 'preke'),
('Sportinis rankšluostis', 'Mikropluošto sportinis rankšluostis', 'preke'),
('Vandens buteliukas', '1L BPA-free daugkartinis buteliukas', 'preke');

INSERT INTO `gym2`.`prekes_kaina` (`preke_id`, `standartine_kaina`, `nuolaida`, `galiojimo_pradzia`, `galiojimo_pabaiga`) VALUES
(1, 30.00, NULL, '2025-06-01', NULL),
(2, 45.00, 10.00, '2025-06-01', NULL),
(3, 15.00, 0.00, '2025-06-01', NULL),
(4, 25.00, 5.00, '2025-06-01', NULL),
(5, 10.00, NULL, '2025-06-01', NULL),
(6, 8.00, 20.00, '2025-06-01', NULL);

INSERT INTO `gym2`.`narystes_pasiulymas` 
(`naryste_id`, `kodas`, `salies_kodas`, `kaina`, `valiuta`, `akcijos_kodas`, `aprasymas`) 
VALUES
(1, 'TD12', 'LTU', 24.90, 'EUR', 'akc202308slapta', 'Start narystės pasiūlymas su akcija Lietuvoje'),
(1, 'TD13', 'LTU', 19.99, 'EUR', 'akc202309basic', 'Start narystė rudens pasiūlymas'),
(2, 'EZ25', 'LTU', 29.99, 'EUR', NULL, 'Easy narystė be akcijos'),
(2, 'EZ25S', 'LTU', 26.99, 'EUR', 'akc202308vasara', 'Easy vasaros pasiūlymas'),
(3, 'FLX45', 'LTU', 39.99, 'EUR', NULL, 'Flexi narystė su pilna kaina'),
(3, 'FLX45D', 'LTU', 34.99, 'EUR', 'akc202310nuolaida', 'Flexi nuolaida spalio mėnesiui');

INSERT INTO `gym2`.`paskyros_busena` (`pavadinimas`) VALUES
('Aktyvi'),
('Neaktyvi'),
('Nepatvirtinta'),
('Uzblokuota');

INSERT INTO `gym2`.`kliento_paskyra` 
(`klientas_id`, `el_pastas`, `slaptazodis_hash`, `paskyros_busena_id`)
VALUES
(1, 'Jonas.Kazlauskas@gmail.com', '$2y$10$abc123abc123abc123abc1', 1),
(2, 'Ieva.Petrauskaitė@gmail.com', '$2y$10$def456def456def456def4', 1),
(3, 'Tomas.Jankauskas@gmail.com', '$2y$10$ghi789ghi789ghi789ghi7', 1),
(4, 'Monika.Stankevičiūtė@gmail.com', '$2y$10$jkl012jkl012jkl012jkl0', 1),
(5, 'Darius.Bieliauskas@gmail.com', '$2y$10$mno345mno345mno345mno3', 2),
(6, 'Simona.Vaitkutė@gmail.com', '$2y$10$pqr678pqr678pqr678pqr6', 1),
(7, 'Rokas.Urbonas@gmail.com', '$2y$10$stu901stu901stu901stu9', 3),
(8, 'Eglė.Paulauskaitė@gmail.com', '$2y$10$vwx234vwx234vwx234vwx2', 1),
(9, 'Mantas.Žukauskas@gmail.com', '$2y$10$yz1234yz1234yz1234yz12', 1),
(10, 'Greta.Sabaliauskaitė@gmail.com', '$2y$10$zxc567zxc567zxc567zxc5', 4);

INSERT INTO `gym2`.`identifikavimo_tipas` (`pavadinimas`, `aprasymas`) VALUES
('kortele', 'Fizinis plastikinis įėjimo leidimas'),
('pin_kodas', 'Skaičių kombinacija'),
('nfc_bluetooth', 'Išmanusis telefonas su NFC ar Bluetooth'),
('biometrinis', 'Piršto atspaudas arba veido atpažinimas'),
('barcode_qrcode', 'Nuskenuojamas QR arba brūkšninis kodas');

INSERT INTO `gym2`.`kliento_identifikavimas` 
(`klientas_id`, `identifikavimo_kodas`, `identifikavimo_tipas_id`)
VALUES
(1, 'CARD-0001', 1),
(2, 'CARD-0002', 1),
(2, 'PIN-0002', 2),
(3, 'NFC-0003', 3),
(4, 'PIN-0004', 2),
(4, 'BIO-0004', 4),
(5, 'BARCODE-0005', 5),
(6, 'NFC-0006', 3),
(6, 'BIO-0006', 4),
(7, 'CARD-0007', 1),
(8, 'PIN-0008', 2),
(9, 'BARCODE-0009', 5),
(10, 'CARD-0010', 1),
(10, 'NFC-0010', 3);

INSERT INTO `gym2`.`sporto_klubas` (`pavadinimas`, `telefonas`) VALUES
('Titanas Gym', '+37061234567'),
('Forma Fitness', '+37069876543'),
('Energija Klubas', '+37061211223');


INSERT INTO `gym2`.`sporto_klubo_filialas` (`sporto_klubas_id`, `miestas_id`, `adresas`) VALUES
-- Titanas Gym
(1, 1, 'Gedimino pr. 10'),
(1, 1, 'Kalvarijų g. 22'),
(1, 1, 'Ozo g. 5'),
(1, 2, 'Savanorių pr. 100'),
(1, 2, 'Kovo 11-osios g. 33'),
(1, 2, 'Karaliaus Mindaugo pr. 1'),

-- Forma Fitness
(2, 1, 'Žirmūnų g. 15'),
(2, 1, 'Naugarduko g. 20'),
(2, 1, 'Pylimo g. 7'),
(2, 2, 'Vilniaus g. 45'),
(2, 2, 'Taikos pr. 77'),
(2, 2, 'Laisvės al. 12'),

-- Energija Klubas
(3, 1, 'Antakalnio g. 4'),
(3, 1, 'Šeškinės g. 18'),
(3, 1, 'Viršuliškių g. 11'),
(3, 2, 'Pramonės pr. 19'),
(3, 2, 'Šilainiai g. 5'),
(3, 2, 'Radvilėnų pl. 10'),


INSERT INTO `gym2`.`kliento_apsilankymas` 
(`sporto_klubo_filialas_id`, `kliento_identifikavimas_id`)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(1, 2),
(2, 4),
(3, 6),
(4, 10),
(5, 12),
(6, 14);


INSERT INTO `gym2`.`pardavejas`
(`sporto_klubas_id`, `miestas_id`, `adresas`, `pavadinimas`, `imones_kodas`, `pvm_moketojo_kodas`, `banko_pavadinimas`, `banko_saskaita`)
VALUES
(1, 1, 'Gedimino pr. 10, Vilnius', 'UAB Titanas Gym', '302123456', 'LT100012345617', 'Swedbank', 'LT12 7300 0101 1234 5678'),
(2, 1, 'Savanorių pr. 100, Kaunas', 'AB Forma Fitness', '304654321', 'LT100065432198', 'SEB bankas', 'LT33 7044 0510 9876 5432'),
(3, 3, 'Respublikos g. 12, Panevezys', 'UAB Energija Klubas', '303789456', 'LT100078945612', 'Luminor', 'LT44 4010 0424 6789 3210');



-- Juridinis asmuo (companies)
INSERT INTO `gym2`.`saskaita` (`juridinis_asmuo_id`, `pardavejas_id`, `paslaugu_menuo`, `saskaitos_formavimo_data`, `apmokejimo_data`, `apmokejimo_terminas_iki`, `busena`, `saskaitos_numeris`) VALUES
(1, 1, '2025-05-01', '2025-05-01', '2025-05-10', '2025-05-15', 'apmoketa', 'JUR-001-202505'),
(2, 2, '2025-05-01', '2025-05-01', NULL, '2025-05-20', 'neapmoketa', 'JUR-002-202505'),
(3, 1, '2025-06-01', '2025-06-01', '2025-06-07', '2025-06-15', 'apmoketa', 'JUR-003-202506'),
(4, 3, '2025-06-01', '2025-06-01', NULL, '2025-06-25', 'neapmoketa', 'JUR-004-202506'),
(5, 2, '2025-04-01', '2025-04-01', '2025-04-15', '2025-04-20', 'apmoketa', 'JUR-005-202504'),
(6, 1, '2025-03-01', '2025-03-01', NULL, '2025-03-20', 'neapmoketa', 'JUR-006-202503');

-- Klientas (individuals)
INSERT INTO `gym2`.`saskaita` (`klientas_id`, `pardavejas_id`, `paslaugu_menuo`, `saskaitos_formavimo_data`, `apmokejimo_data`, `apmokejimo_terminas_iki`, `busena`, `saskaitos_numeris`) VALUES
(2, 1, '2025-05-01', '2025-05-01', '2025-05-12', '2025-05-15', 'apmoketa', 'KLI-002-202505'),
(4, 2, '2025-06-01', '2025-06-01', NULL, '2025-06-20', 'neapmoketa', 'KLI-004-202506'),
(6, 3, '2025-06-01', '2025-06-01', NULL, '2025-06-15', 'neapmoketa', 'KLI-006-202506'),
(8, 1, '2025-04-01', '2025-04-01', '2025-04-09', '2025-04-15', 'apmoketa', 'KLI-008-202504'),
(10, 2, '2025-03-01', '2025-03-01', NULL, '2025-03-20', 'neapmoketa', 'KLI-010-202503');



-- Lines with preke_id
INSERT INTO `gym2`.`saskaitos_eilute` 
(`saskaita_id`, `preke_id`, `narystes_pasiulymas_id`, `kiekis`, `kaina_be_pvm`, `pvm_tarifas`) VALUES
(1, 1, NULL, 2, 30.00, 21.00),   -- 2x Asmeninė treniruotė
(2, 4, NULL, 1, 25.00, 21.00),   -- 1x Baltyminiai milteliai
(3, 6, NULL, 3, 5.00, 21.00),    -- 3x Vandens buteliukas
(4, 2, NULL, 1, 40.00, 21.00);   -- 1x Masažo seansas

-- Lines with narystes_pasiulymas_id
INSERT INTO `gym2`.`saskaitos_eilute` 
(`saskaita_id`, `preke_id`, `narystes_pasiulymas_id`, `kiekis`, `kaina_be_pvm`, `pvm_tarifas`) VALUES
(5, NULL, 1, 1, 50.00, 21.00),   -- 1x Basic Membership
(6, NULL, 3, 1, 70.00, 21.00),   -- 1x Group Training Plan
(7, NULL, 5, 2, 60.00, 21.00),   -- 2x Student Membership
(8, NULL, 2, 1, 90.00, 21.00);   -- 1x Premium Membership


INSERT INTO `gym2`.`apmokejimo_budas` (`aprasymas`) VALUES
('El. bankininkystė'),
('Mokėjimo kortele'),
('Grynaisiais'),
('Dovanų kuponas'),
('Mobilioji programėlė'),
('Banko pavedimu');



INSERT INTO `gym2`.`apmokejimas` (`saskaita_id`, `apmokejimo_budas_id`, `suma`) VALUES
(1, 1, 120.00),   -- el. bankininkystė
(3, 2, 89.99),    -- grynieji
(5, 4, 150.50),   -- pavedimas
(7, 1, 59.00),    -- el. bankininkystė
(10, 3, 45.00),   -- dovanų kuponas
(11, 1, 72.30);   -- el. bankininkystė



INSERT INTO `gym2`.`kliento_telefonas` (`telefonas`, `klientas_id`) VALUES
('+37061234501', 1),
('+37061234502', 2),
('+37061234503', 3),
('+37061234504', 4),
('+37061234505', 5),
('+37061234506', 6),
('+37061234507', 7),
('+37061234508', 8),
('+37061234509', 9),
('+37061234510', 10);


INSERT INTO `gym2`.`asmeninis_treneris` (`vardas`, `pavarde`) VALUES
('Marius', 'Jankauskas'),
('Simona', 'Petrauskaitė'),
('Tomas', 'Kazlauskas'),
('Rasa', 'Zelionytė'),
('Lukas', 'Stonys'),
('Inga', 'Kavaliauskienė'),
('Dainius', 'Matulevičius'),
('Eglė', 'Norkutė'),
('Rokas', 'Mažeika'),
('Aušra', 'Brazdeikytė'),
('Justinas', 'Vaitkus'),
('Monika', 'Šimkutė'),
('Erikas', 'Grigonis'),
('Giedrė', 'Mickutė'),
('Vilius', 'Dambrauskas'),
('Sandra', 'Paškevičiūtė'),
('Edgaras', 'Sakalauskas'),
('Aistė', 'Žukauskaitė'),
('Paulius', 'Petraitis'),
('Jolita', 'Baranauskaitė'),
('Andrius', 'Urbonas'),
('Kristina', 'Navickaitė'),
('Tautvydas', 'Rimkus'),
('Vaida', 'Girdauskienė');


-- Coaches 1–4 work at 2 clubs each
INSERT INTO `gym2`.`asmeninio_trenerio_klubas` (`asmeninis_treneris_id`, `sporto_klubo_filialas_id`) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3),
(3, 4),
(4, 4),
(4, 5),

-- Coaches 5 and 6 work at same 2 clubs (filialas 5 and 6)
(5, 5),
(5, 6),
(5, 7),
(6, 6),
(6, 7),
(6, 8),

-- Coaches 7–24 assigned uniquely to one filialas
(7, 1),
(8, 1),
(9, 2),
(10, 2),
(11, 3),
(12, 3),
(13, 4),
(14, 4),
(15, 5),
(16, 5),
(17, 6),
(18, 6),
(19, 1),
(20, 2),
(21, 3),
(22, 4),
(23, 5),
(24, 6);


INSERT INTO `gym2`.`pareigos` (`pavadinimas`) VALUES
('Administratorius'),
('Valytojas'),
('Buhalteris'),
('Treneris'),
('Registratorius'),
('Techninės priežiūros specialistas'),
('Marketingo specialistas'),
('Personalas'),
('Vadovas'),
('Klientų aptarnavimo specialistas'),
('Saugos darbuotojas'),
('Mitybos konsultantas'),
('Fizinės terapijos specialistas'),
('IT specialistas');


