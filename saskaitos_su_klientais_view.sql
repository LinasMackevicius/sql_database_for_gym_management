-- saskaitos tik su klientais ir pamatyti eilutes saskaitu.

-- CREATE VIEW klientu_saskaitos AS
SELECT
sas.id AS saskaita_id,
kl.vardas,
kl.pavarde,
kl.asmens_kodas,
pa.pavadinimas AS pardavejas,
sas.paslaugu_menuo,
sas.saskaitos_formavimo_data,
sas.apmokejimo_data,
sas.apmokejimo_terminas_iki,
sas.busena,
sas.saskaitos_numeris,
pr.pavadinimas AS preke,
np.kodas
FROM
gym2.saskaita sas LEFT JOIN gym2.klientas kl ON kl.id = sas.klientas_id 
LEFT JOIN gym2.pardavejas pa ON pa.sporto_klubas_id = sas.pardavejas_id
LEFT JOIN gym2.saskaitos_eilute sas_eil ON sas_eil.saskaita_id = sas.id
LEFT JOIN gym2.preke pr ON sas_eil.preke_id = pr.id
LEFT JOIN gym2.narystes_pasiulymas np ON np.id = sas_eil.narystes_pasiulymas_id
WHERE sas.juridinis_asmuo_id IS NULL;


