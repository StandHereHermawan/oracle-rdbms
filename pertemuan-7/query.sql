-- SELECT 
--     so.id AS id_service_order,
--     so.date_arrive,
--     so.order_status,
--     so.summary_price,
--     c.fullname AS nama_pelanggan,
--     c.phone_number,
--     v.police_number,
--     v.type AS tipe_kendaraan,
--     b_veh.fullname AS merk_kendaraan,
--     m.fullname AS nama_mekanik,
--     ss.fullname AS nama_jasa,
--     ss.price AS harga_jasa,
--     sp.name AS nama_sparepart,
--     dsp.quantity AS jumlah_sparepart,
--     sp.price AS harga_satuan_sparepart,
--     b_spar.fullname AS merk_sparepart
-- FROM service_order so
-- -- 1. Join ke Pelanggan
-- JOIN customer c ON so.id_customer = c.id
-- -- 2. Join ke Kendaraan (Vehicle)
-- JOIN vehicle v ON so.id_vehicle = v.id
-- -- 3. Join ke Brand Kendaraan
-- LEFT JOIN brand b_veh ON v.id_brand = b_veh.id
-- -- 4. Join ke tabel perantara On Charge (Mekanik)
-- LEFT JOIN on_charge oc ON so.id = oc.id_service_order
-- -- 5. Join ke Master Mekanik
-- LEFT JOIN mechanic m ON oc.id_mechanic = m.id
-- -- 6. Join ke Detail Service (Jasa)
-- LEFT JOIN detail_service_order dso ON so.id = dso.id_service_order
-- -- 7. Join ke Master Specific Service (Jasa)
-- LEFT JOIN specific_service ss ON dso.id_specific_service = ss.id
-- -- 8. Join ke Detail Service Sparepart
-- LEFT JOIN detail_service_order_sparepart dsp ON so.id = dsp.id_service_order
-- -- 9. Join ke Master Sparepart
-- LEFT JOIN sparepart sp ON dsp.id_spare_part = sp.id
-- -- 10. Join ke Brand Sparepart
-- LEFT JOIN brand b_spar ON sp.id_brand = b_spar.id;

-- Query join ke 10 table
SELECT 
    so.id AS id_service_order,
    so.date_arrive,
    so.order_status,
    so.summary_price,
    c.fullname AS nama_pelanggan,
    c.phone_number,
    v.police_number,
    v.type AS tipe_kendaraan,
    b_veh.fullname AS merk_kendaraan,
    m.fullname AS nama_mekanik, 
    ss.fullname AS nama_jasa, 
    ss.price AS harga_jasa, 
    sp.name AS nama_sparepart, 
    dsp.quantity AS jumlah_sparepart, 
    sp.price AS harga_satuan_sparepart, 
    b_spar.fullname AS merk_sparepart  
FROM service_order so  
JOIN customer c ON so.id_customer = c.id  
JOIN vehicle v ON so.id_vehicle = v.id  
LEFT JOIN brand b_veh ON v.id_brand = b_veh.id   
LEFT JOIN on_charge oc ON so.id = oc.id_service_order   
LEFT JOIN mechanic m ON oc.id_mechanic = m.id   
LEFT JOIN detail_service_order dso ON so.id = dso.id_service_order   
LEFT JOIN specific_service ss ON dso.id_specific_service = ss.id   
LEFT JOIN detail_service_order_sparepart dsp ON so.id = dsp.id_service_order   
LEFT JOIN sparepart sp ON dsp.id_spare_part = sp.id   
LEFT JOIN brand b_spar ON sp.id_brand = b_spar.id;   


SELECT 
    so.id AS id_service_order,
    so.date_arrive,
    so.order_status,
    so.summary_price,
    c.fullname AS nama_pelanggan,
    c.phone_number,
    v.police_number,
    v.type AS tipe_kendaraan,
    b_veh.fullname AS merk_kendaraan,
    m.fullname AS nama_mekanik, 
    ss.fullname AS nama_jasa, 
    ss.price AS harga_jasa, 
    sp.name AS nama_sparepart, 
    dsp.quantity AS jumlah_sparepart, 
    sp.price AS harga_satuan_sparepart, 
    b_spar.fullname AS merk_sparepart  
FROM service_order so  
LEFT JOIN customer c ON so.id_customer = c.id  
LEFT JOIN vehicle v ON so.id_vehicle = v.id  
LEFT JOIN brand b_veh ON v.id_brand = b_veh.id   
LEFT JOIN on_charge oc ON so.id = oc.id_service_order   
LEFT JOIN mechanic m ON oc.id_mechanic = m.id   
LEFT JOIN detail_service_order dso ON so.id = dso.id_service_order   
LEFT JOIN specific_service ss ON dso.id_specific_service = ss.id   
LEFT JOIN detail_service_order_sparepart dsp ON so.id = dsp.id_service_order   
LEFT JOIN sparepart sp ON dsp.id_spare_part = sp.id   
LEFT JOIN brand b_spar ON sp.id_brand = b_spar.id;   


SELECT 
    so.id AS id_service_order,
    so.date_arrive,
    so.order_status,
    TO_CHAR(so.summary_price) AS summary_price,
    c.fullname AS nama_pelanggan,
    b_veh.fullname AS merk_kendaraan,
    m.fullname AS nama_mekanik, 
    ss.fullname AS nama_jasa, 
    TO_CHAR(ss.price) AS harga_jasa, 
    sp.name AS nama_sparepart, 
    TO_CHAR(dsp.quantity) AS jumlah_sparepart, 
    TO_CHAR(sp.price) AS harga_satuan_sparepart   
FROM service_order so  
LEFT JOIN customer c ON so.id_customer = c.id  
LEFT JOIN vehicle v ON so.id_vehicle = v.id  
LEFT JOIN brand b_veh ON v.id_brand = b_veh.id   
LEFT JOIN on_charge oc ON so.id = oc.id_service_order   
LEFT JOIN mechanic m ON oc.id_mechanic = m.id   
LEFT JOIN detail_service_order dso ON so.id = dso.id_service_order   
LEFT JOIN specific_service ss ON dso.id_specific_service = ss.id   
LEFT JOIN detail_service_order_sparepart dsp ON so.id = dsp.id_service_order   
LEFT JOIN sparepart sp ON dsp.id_spare_part = sp.id   
LEFT JOIN brand b_spar ON sp.id_brand = b_spar.id;   


SELECT 
    so.id AS id_service_order,  
    so.date_arrive,  
    so.order_status,  
    TO_CHAR(so.summary_price) AS summary_price,  
    c.fullname AS nama_pelanggan, 
    b_veh.fullname AS merk_kendaraan, 
    m.fullname AS nama_mekanik,  
    ss.fullname AS nama_jasa,  
    TO_CHAR(ss.price) AS harga_jasa,  
    sp.name AS nama_sparepart,  
    TO_CHAR(dsp.quantity) AS jumlah_sparepart
FROM service_order so  
LEFT JOIN customer c ON so.id_customer = c.id   
LEFT JOIN vehicle v ON so.id_vehicle = v.id   
LEFT JOIN brand b_veh ON v.id_brand = b_veh.id   
LEFT JOIN on_charge oc ON so.id = oc.id_service_order   
LEFT JOIN mechanic m ON oc.id_mechanic = m.id   
LEFT JOIN detail_service_order dso ON so.id = dso.id_service_order   
LEFT JOIN specific_service ss ON dso.id_specific_service = ss.id   
LEFT JOIN detail_service_order_sparepart dsp ON so.id = dsp.id_service_order   
LEFT JOIN sparepart sp ON dsp.id_spare_part = sp.id   
LEFT JOIN brand b_spar ON sp.id_brand = b_spar.id;   
