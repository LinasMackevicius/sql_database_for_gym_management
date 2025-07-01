INSERT INTO `gym2`.`miestas` (`pavadinimas`) VALUES
('Vilnius'),
('Kaunas');

INSERT INTO `gym2`.`adresas` (`gatve`, `namo_numeris`, `miestas_id`) VALUES
('Gedimino pr.', '10', 1),
('Žirmūnų g.', '15-3', 1),
('Kalvarijų g.', '33', 1),
('Ozo g.', '7', 1),
('Savanorių pr.', '100', 2),
('Taikos pr.', '55', 2),
('A. Mickevičiaus g.', '12', 2),
('Kovo 11-osios g.', '20', 2),
('Naugarduko g.', '3', 1),
('Laisvės pr.', '66', 1),

('Vilniaus g.', '10', 1),
('Kauno g.', '20', 2),
('Gedimino pr.', '15', 1),
('Taikos pr.', '5', 2),
('Savanorių pr.', '30', 1),
('Kęstučio g.', '45', 2),
('A. Mickevičiaus g.', '11', 1),
('Vilkpėdės g.', '50', 2),
('Laisvės al.', '23', 1),
('Žalgirio g.', '9', 2),

('Kalvarijų g', '22', 1),
('Ozo g.', '5', 2),
('Mėtų g.', '33', 1);

INSERT INTO `gym2`.`klientas` (`vardas`, `pavarde`, `asmens_kodas`, `adresas_id`) VALUES
('Jonas', 'Kazlauskas', '39001010001', 1),
('Ieva', 'Petrauskaitė', '49102020002', 2),
('Tomas', 'Jankauskas', '38503150003', 3),
('Monika', 'Stankevičiūtė', '49804040004', 4),
('Darius', 'Bieliauskas', '38005050005', 5),
('Simona', 'Vaitkutė', '49506060006', 6),
('Rokas', 'Urbonas', '38707070007', 7),
('Eglė', 'Paulauskaitė', '49208080008', 8),
('Mantas', 'Žukauskas', '38909090009', 9),
('Greta', 'Sabaliauskaitė', '49410100010', 10);

INSERT INTO `gym2`.`juridinis_asmuo` 
(`pavadinimas`, `pvm_moketojo_kodas`, `imones_kodas`, `adresas_id`) VALUES
('UAB Fitness Solutions', 'LT100200600', '3030303030303', 11),
('AB Sporto Klubas', 'LT200300400', '4040404040404', 12),
('UAB GymPro', 'LT300400500', '5050505050505', 13),
('UAB Active Life', 'LT400500600', '6060606060606', 14),
('UAB Sportas Plus', 'LT500600700', '7070707070707', 15),
('UAB Healthy Move', 'LT600700800', '8080808080808', 16),
('UAB Fit4Life', 'LT700800900', '9090909090909', 17), 
('UAB Strong Body', 'LT800900100', '1010101010101', 18),
('UAB Gym Active', 'LT900100200', '2020202020202', 19),
('UAB Power Gym', 'LT100200300', '3030303030304', 20);

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
(`klientas_id`, `el_pastas`, `slaptazodis_hash`, `paskyros_busena_id`, `sukurimo_data`)
VALUES
(1, 'Jonas.Kazlauskas@gmail.com',     '$2y$10$abc123abc123abc123abc1', 1, '2024-06-01 09:00:00'),
(2, 'Ieva.Petrauskaitė@gmail.com',    '$2y$10$def456def456def456def4', 1, '2022-06-02 09:15:00'),
(3, 'Tomas.Jankauskas@gmail.com',     '$2y$10$ghi789ghi789ghi789ghi7', 1, '2024-06-03 10:00:00'),
(4, 'Monika.Stankevičiūtė@gmail.com', '$2y$10$jkl012jkl012jkl012jkl0', 1, '2023-06-04 11:30:00'),
(5, 'Darius.Bieliauskas@gmail.com',   '$2y$10$mno345mno345mno345mno3', 2, '2024-06-05 12:00:00'),
(6, 'Simona.Vaitkutė@gmail.com',      '$2y$10$pqr678pqr678pqr678pqr6', 1, '2023-06-06 14:10:00'),
(7, 'Rokas.Urbonas@gmail.com',        '$2y$10$stu901stu901stu901stu9', 3, '2024-06-07 08:45:00'),
(8, 'Eglė.Paulauskaitė@gmail.com',    '$2y$10$vwx234vwx234vwx234vwx2', 1, '2024-06-08 16:20:00'),
(9, 'Mantas.Žukauskas@gmail.com',     '$2y$10$yz1234yz1234yz1234yz12', 1, '2024-06-09 13:35:00'),
(10, 'Greta.Sabaliauskaitė@gmail.com','$2y$10$zxc567zxc567zxc567zxc5', 4, '2024-06-10 10:25:00');


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
('Titanas Gym', '+37061234567');

INSERT INTO `gym2`.`sporto_klubo_filialas` (`sporto_klubas_id`, `adresas_id`) VALUES
-- Titanas Gym
(1, 1),
(1, 21),
(1, 23);

-- Klientas 1 with CARD-0001 (id=1), visiting filialas_id=1
INSERT INTO `gym2`.`kliento_apsilankymas` (`apsilankymo_laikas`, `sporto_klubo_filialas_id`, `kliento_identifikavimas_id`) VALUES
('2025-06-01 08:15:00', 1, 1),
('2025-06-03 07:50:00', 1, 1),
('2025-06-05 08:05:00', 1, 1);

-- Klientas 2 with CARD-0002 (id=2), visiting filialas_id=2
INSERT INTO `gym2`.`kliento_apsilankymas` (`apsilankymo_laikas`, `sporto_klubo_filialas_id`, `kliento_identifikavimas_id`) VALUES
('2025-06-02 18:20:00', 2, 2),
('2025-06-04 18:15:00', 2, 2),
('2025-06-06 17:55:00', 2, 2);

-- Klientas 2 with PIN-0002 (id=3), same filialas
INSERT INTO `gym2`.`kliento_apsilankymas` (`apsilankymo_laikas`, `sporto_klubo_filialas_id`, `kliento_identifikavimas_id`) VALUES
('2025-06-02 18:21:00', 2, 3),
('2025-06-04 18:16:00', 2, 3);

-- Klientas 3 with NFC-0003 (id=4), visiting filialas_id=3
INSERT INTO `gym2`.`kliento_apsilankymas` (`apsilankymo_laikas`, `sporto_klubo_filialas_id`, `kliento_identifikavimas_id`) VALUES
('2025-06-01 10:00:00', 3, 4),
('2025-06-05 10:15:00', 3, 4),
('2025-06-07 10:10:00', 3, 4);

-- Klientas 4 with PIN-0004 (id=5), visiting filialas_id=1
INSERT INTO `gym2`.`kliento_apsilankymas` (`apsilankymo_laikas`, `sporto_klubo_filialas_id`, `kliento_identifikavimas_id`) VALUES
('2025-06-03 07:45:00', 1, 5),
('2025-06-06 07:40:00', 1, 5);


INSERT INTO `gym2`.`pardavejas`
(`sporto_klubas_id`, `adresas_id`, `pavadinimas`, `imones_kodas`, `pvm_moketojo_kodas`, `banko_pavadinimas`, `banko_saskaita`)
VALUES
(1, 23, 'UAB Titanas Gym', '302123456', 'LT100012345617', 'Swedbank', 'LT12 7300 0101 1234 5678');


-- Juridinis asmuo (companies)
INSERT INTO `gym2`.`saskaita` (`juridinis_asmuo_id`, `pardavejas_id`, `paslaugu_menuo`, `saskaitos_formavimo_data`, `apmokejimo_data`, `apmokejimo_terminas_iki`, `busena`, `saskaitos_numeris`) VALUES
(1, 1, '2025-05-01', '2025-05-01', '2025-05-10', '2025-05-15', 'apmoketa', 'JUR-001-202505'),
(2, 1, '2025-05-01', '2025-05-01', NULL, '2025-05-20', 'neapmoketa', 'JUR-002-202505'),
(3, 1, '2025-06-01', '2025-06-01', '2025-06-07', '2025-06-15', 'apmoketa', 'JUR-003-202506'),
(4, 1, '2025-06-01', '2025-06-01', NULL, '2025-06-25', 'neapmoketa', 'JUR-004-202506'),
(5, 1, '2025-04-01', '2025-04-01', '2025-04-15', '2025-04-20', 'apmoketa', 'JUR-005-202504'),
(6, 1, '2025-03-01', '2025-03-01', NULL, '2025-03-20', 'neapmoketa', 'JUR-006-202503');

-- Klientas (individuals)
INSERT INTO `gym2`.`saskaita` (`klientas_id`, `pardavejas_id`, `paslaugu_menuo`, `saskaitos_formavimo_data`, `apmokejimo_data`, `apmokejimo_terminas_iki`, `busena`, `saskaitos_numeris`) VALUES
(2, 1, '2025-05-01', '2025-05-01', '2025-05-12', '2025-05-15', 'apmoketa', 'KLI-002-202505'),
(4, 1, '2025-06-01', '2025-06-01', NULL, '2025-06-20', 'neapmoketa', 'KLI-004-202506'),
(6, 1, '2025-06-01', '2025-06-01', NULL, '2025-06-15', 'neapmoketa', 'KLI-006-202506'),
(8, 1, '2025-04-01', '2025-04-01', '2025-04-09', '2025-04-15', 'apmoketa', 'KLI-008-202504'),
(10, 1, '2025-03-01', '2025-03-01', NULL, '2025-03-20', 'neapmoketa', 'KLI-010-202503');



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


INSERT INTO `gym2`.`asmeninio_trenerio_klubas` (`asmeninis_treneris_id`, `sporto_klubo_filialas_id`) VALUES
-- Coaches 1–4 work at 2 clubs each (distribute across 1–3)
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3),
(3, 1),
(4, 1),
(4, 3),

-- Coaches 5 and 6 work at same 2 clubs (e.g. 2 and 3)
(5, 2),
(5, 3),
(6, 2),
(6, 3),

-- Coaches 7–24 assigned uniquely to one of the 3 clubs (cycled)
(7, 1),
(8, 2),
(9, 3),
(10, 1),
(11, 2),
(12, 3),
(13, 1),
(14, 2),
(15, 3),
(16, 1),
(17, 2),
(18, 3),
(19, 1),
(20, 2),
(21, 3),
(22, 1),
(23, 2),
(24, 3);

INSERT INTO `gym2`.`pareigos` (`pavadinimas`) VALUES
('Valytojas'),
('Administratorius'),
('Buhalteris'),
('Techninės priežiūros specialistas'),
('Marketingo specialistas'),
('Vadovas'),
('Klientų aptarnavimo specialistas'),
('IT specialistas');

INSERT INTO `gym2`.`darbuotojas` (`vardas`, `pavarde`, `sporto_klubas_id`, `pareigos_id`) VALUES
-- Only in 'Titanas Gym'  
-- IT specialistas (3)
('Tomas', 'Petraitis', 1, 8),
('Eglė', 'Žemaitė', 1, 8),
('Martynas', 'Stankus', 1, 8),

-- Klientų aptarnavimo specialistas (3)
('Greta', 'Bartašiūtė', 1, 7),
('Andrius', 'Sabaliauskas', 1, 7),
('Ieva', 'Grigonienė', 1, 7),

-- Valytojas (5)
('Dalia', 'Jankauskaitė', 1, 1),
('Romas', 'Kairys', 1, 1),
('Neringa', 'Aleknienė', 1, 1),
('Jonas', 'Urbonas', 1, 1),
('Viktorija', 'Kučinskaitė', 1, 1),

('Laura', 'Stonienė', 1, 2),
('Mantas', 'Kvedaras', 1, 3),
('Aivaras', 'Vasiliauskas', 1, 4),
('Justina', 'Šarka', 1, 5),
('Saulius', 'Bieliauskas', 1, 6);

INSERT INTO `gym2`.`el_pasto_paskirtis` (`pavadinimas`) VALUES
('Reklamos galimybės'),
('Žiniasklaidai ir spaudai'),
('Pasiūlymai dėl IT sistemų ir programėlių'),
('Sporto narystes įmonėms'),
('Bendra Informacija'),
('Pasiūlymai plėtrai'),
('Atsiliepimai ir skundai');


INSERT INTO `gym2`.`el_pastas` (`el_pasto_adresas`, `sporto_klubas_id`, `el_pasto_paskirtis_id`) VALUES
('reklama@titanasgym.lt', 1, 1),
('media@titanasgym.lt', 1, 2),
('it@titanasgym.lt', 1, 3),
('imonems@titanasgym.lt', 1, 4),
('info@titanasgym.lt', 1, 5),
('pletra@titanasgym.lt', 1, 6),
('atsiliepimai@titanasgym.lt', 1, 7);

INSERT INTO `gym2`.`grupes_treneris` (`vardas`, `pavarde`) VALUES
('Greta', 'Sabaliauskaitė'),
('Mantas', 'Kvietkus'),
('Simona', 'Petrauskienė'),
('Lukas', 'Bieliauskas'),
('Agnė', 'Mickutė'),
('Tomas', 'Valančius');

-- Greta works at filialas 1 and 2
INSERT INTO `gym2`.`grupes_trenerio_klubas` (`grupes_treneris_id`, `sporto_klubo_filialas_id`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(2, 3);

INSERT INTO `gym2`.`mokejimo_daznis` (`aprasymas`) VALUES
('Mokėjimas kas mėnesi'),
('Mokėjimas kas puse metų'),
('Mokėjimas už metus');

INSERT INTO `gym2`.`kliento_abonementas`
(klientas_id, narystes_pasiulymas_id, mokejimo_daznis_id, sutarties_numeris, galiojimo_pradzia, galiojimo_pabaiga, statusas) VALUES
-- Klientas 1
(1, 1, 1, 'SUT-0001', '2023-01-01', '2024-01-01', 'aktyvuotas'),
-- Klientas 2 (galiojimo_pabaiga NULL, paying monthly (id=1))
(2, 2, 1, 'SUT-0002', '2023-06-01', NULL, 'aktyvuotas'),
-- Klientas 3, two abonementai, consecutive years, both ended
(3, 3, 3, 'SUT-0003', '2021-08-01', '2022-08-01', 'neaktyvuotas'),
(3, 3, 3, 'SUT-0004', '2022-08-01', '2023-08-01', 'neaktyvuotas'),
(3, 5, 3, 'SUT-0005','2023-08-01', NULL, 'aktyvuotas'),
-- Klientas 4
(4, 4, 2, 'SUT-0005', '2023-03-15', '2024-03-15', 'aktyvuotas'),
-- Klientas 5
(5, 5, 1, 'SUT-0006', '2023-05-01', '2024-05-01', 'aktyvuotas');



INSERT INTO `gym2`.`asmenine_treniruote`
(asmeninis_treneris_id, sporto_klubo_filialas_id, klientas_id, treniruotes_pradzia, treniruotes_pabaiga) VALUES

-- klientas 1 with coach 4, one session
(4, 1, 1, '2023-05-01 10:00:00', '2023-05-01 11:00:00'),

-- klientas 1 switched to coach 1, three sessions 3 days apart
(1, 1, 1, '2023-05-10 09:00:00', '2023-05-10 10:00:00'),
(1, 1, 1, '2023-05-13 09:00:00', '2023-05-13 10:00:00'),
(1, 1, 1, '2023-05-16 09:00:00', '2023-05-16 10:00:00'),

-- coach 2 trains klientas 4, 5, 6 (one session each, different filialai)
(2, 2, 4, '2023-06-01 14:00:00', '2023-06-01 15:00:00'),
(2, 3, 5, '2023-06-02 15:00:00', '2023-06-02 16:00:00'),
(2, 1, 6, '2023-06-03 16:00:00', '2023-06-03 17:00:00'),

-- other trainers with one klientas each
(3, 2, 2, '2023-07-01 10:00:00', '2023-07-01 11:00:00'),
(5, 3, 3, '2023-07-02 11:00:00', '2023-07-02 12:00:00');

INSERT INTO `gym2`.`grupine_treniruote` (`pavadinimas`, `intensyvumas`, `sudetingumas`) VALUES
('Joga pradedantiesiems', 'zemas', 'zemas'),
('HIIT kardio', 'aukstas', 'aukstas'),
('Pilates', 'vidutinis', 'vidutinis');

INSERT INTO `gym2`.`grupines_treniruotes_sesija` 
(`pradzios_laikas`, `pabaigos_laikas`, `grupes_treneris_id`, `sporto_klubo_filialas_id`, `grupine_treniruote_id`) VALUES

('2025-07-01 08:00:00', '2025-07-01 09:00:00', 1, 1, 1),  
('2025-07-01 18:00:00', '2025-07-01 19:00:00', 2, 2, 2),  
('2025-07-02 07:00:00', '2025-07-02 08:00:00', 3, 1, 3),  
('2025-07-02 19:00:00', '2025-07-02 20:00:00', 4, 3, 3),  
('2025-07-03 17:00:00', '2025-07-03 18:00:00', 5, 1, 2),  
('2025-07-04 08:00:00', '2025-07-04 09:00:00', 1, 2, 1),  
('2025-07-04 18:00:00', '2025-07-04 19:00:00', 2, 3, 2);  

INSERT INTO `gym2`.`kliento_grupines_treniruotes_sesija` (`klientas_id`, `grupines_treniruotes_sesija_id`) VALUES
-- Session 1 (Joga pradedantiesiems, treneris 1, filialas 1)
(1, 1),
(2, 1),
(3, 1),
(4, 1),
-- Session 2 (HIIT kardio, treneris 2, filialas 2)
(5, 2),
(6, 2),
(7, 2),
-- Session 3 (Pilates, treneris 3, filialas 1)
(8, 3),
(9, 3),
(10, 3),
-- Session 4 (Pilates, treneris 4, filialas 3)
(1, 4),
(2, 4),
-- Session 5 (HIIT kardio, treneris 5, filialas 1)
(3, 5),
(4, 5),
(5, 5),
-- Session 6 (Joga pradedantiesiems, treneris 1, filialas 2)
(6, 6),
(7, 6),
(8, 6),
-- Session 7 (HIIT kardio, treneris 2, filialas 3)
(9, 7),
(10, 7);

INSERT INTO `gym2`.`paslauga` (`pavadinimas`) VALUES
('Neribotas lankymas 24/7'),
('Filtruotas vanduo'),
('Nemokama įvadinė treniruotė'),
('Visų klubų lankymas'),
('Pirtis'),
('Narystės „Atostogos“ iki 30 dienų'),
('Sutarties perrašymas kitam asmeniui'),
('REFORMER+ treniruotės'),
('Soliariumas'),
('Grupinės treniruotės'),
('Galimybės už papildomą mokestį');


-- Start narystė paslaugos
INSERT INTO `gym2`.`narystes_paslauga` (`naryste_id`, `paslauga_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7);

-- Easy narystė paslaugos (inherits Start + extra)
INSERT INTO `gym2`.`narystes_paslauga` (`naryste_id`, `paslauga_id`) VALUES
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10);

-- Flexi narystė
INSERT INTO `gym2`.`narystes_paslauga` (`naryste_id`, `paslauga_id`) VALUES
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(3, 11);

INSERT INTO `gym2`.`gamintojas` (`pavadinimas`, `aprasymas`) VALUES
('Technogym', 'Itališkas sporto įrangos gamintojas, žinomas dėl aukštos kokybės treniruoklių'),
('Rogue Fitness', 'Amerikiečių gamintojas, specializuojasi jėgos sporto įrangoje');

INSERT INTO `gym2`.`inventoriaus_elementas` (`gamintojas_id`, `pavadinimas`, `aprasymas`) VALUES
(1, 'Leg Press Machine', 'Technogym kojų spaudimo treniruoklis'),
(1, 'Hack Squat Machine', 'Technogym įranga šlaunų treniruotei'),
(1, 'Adjustable Bench', 'Reguliuojamas suolelis spaudimui'),
(1, 'Cable Crossover', 'Daugiafunkcis treniruoklis viršutinei kūno daliai'),
(1, 'Pull-up Bar Station', 'Stacionarus prisitraukimų rėmas'),

(2, 'Squat Rack', 'Rogue tvirtas pritūpimų stovas'),
(2, 'Barbell 20kg', 'Standartinė olimpinio svorio štanga'),
(2, 'Dumbbell Set (2-30kg)', 'Pilnas hantelių komplektas nuo 2 iki 30kg'),
(2, 'Flat Bench', 'Stacionarus suolelis štangos spaudimui'),
(2, 'Deadlift Platform', 'Rogue platforma saugiam irklavimui ir traukai');

-- Filialas 1 - Gedimino pr. 10
INSERT INTO `gym2`.`sporto_klubo_inventorius` (`sporto_klubo_filialas_id`, `inventoriaus_elementas_id`, `kiekis`) VALUES
(1, 6, 3),  
(1, 3, 2),  
(1, 4, 1),  
(1, 5, 2),  
(1, 8, 1),  
(1, 7, 1),  
(1, 9, 1), 
(1, 1, 1),  
(1, 10, 3); 

-- Filialas 2 - Kalvarijų g. 22
INSERT INTO `gym2`.`sporto_klubo_inventorius` (`sporto_klubo_filialas_id`, `inventoriaus_elementas_id`, `kiekis`) VALUES
(2, 6, 3),
(2, 3, 2),
(2, 4, 1),
(2, 5, 2),
(2, 8, 1),
(2, 7, 1),
(2, 9, 1),
(2, 2, 1),  
(2, 10, 1); 

-- Filialas 3 - Ozo g. 5
INSERT INTO `gym2`.`sporto_klubo_inventorius` (`sporto_klubo_filialas_id`, `inventoriaus_elementas_id`, `kiekis`) VALUES
(3, 6, 3),
(3, 3, 2),
(3, 4, 1),
(3, 5, 2),
(3, 8, 1),
(3, 7, 1),
(3, 9, 1),
(3, 1, 1),  
(3, 2, 1),
(3, 10, 2); 
