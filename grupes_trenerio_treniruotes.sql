CREATE VIEW grupes_trenerio_treniruociu_sesijos AS
SELECT
gt.vardas,
gt.pavarde,
gts.pradzios_laikas,
gts.pabaigos_laikas,
gt_tipas.pavadinimas,
sk_adresas.gatve,
sk_adresas.namo_numeris,
sk.pavadinimas AS sporto_klubo_pavadinimas
FROM gym2.grupes_treneris gt
JOIN gym2.grupines_treniruotes_sesija gts ON gts.grupes_treneris_id = gt.id
JOIN gym2.grupine_treniruote gt_tipas ON gt_tipas.id = gts.grupine_treniruote_id 
JOIN gym2.sporto_klubo_filialas skf ON skf.id = gts.sporto_klubo_filialas_id
JOIN gym2.adresas sk_adresas ON sk_adresas.id = skf.adresas_id
JOIN gym2.sporto_klubas sk ON sk.id = skf.sporto_klubas_id;
