-- ==========================================
-- 1. DATA MASTER (Pelanggan, Brand, Mekanik, Jasa, Sparepart, Kendaraan)
-- ==========================================

-- Pelanggan Baru
INSERT INTO customer (id, fullname, phone_number) 
    VALUES ('PLGN-0007', 'Rizky Ramadhan', '+62-813-9988-77');

-- Brand Tambahan (jika belum ada)
INSERT INTO brand (id, fullname, description) 
    VALUES ('BRND-0008', 'Kawasaki', 'Produsen sepeda motor Kawasaki');

-- Jasa Tambahan (jika diperlukan untuk variasi servis)
INSERT INTO specific_service (id, fullname, price) 
    VALUES ('SRVC-0006', 'Ganti Kampas Kopling', 60000);

-- Kendaraan Milik Pelanggan Baru
INSERT INTO vehicle (id, id_customer, id_brand, police_number, type, production_year) 
    VALUES (
        'VHCL-0005', 
        'PLGN-0007', 
        'BRND-0008', 
        'D 4321 RZ', 
        'Sport', 
        2020
    );

-- Mekanik Baru Tambahan
INSERT INTO mechanic (id, fullname, start_working) 
    VALUES ('MKNK-0005', 'Asep Saepudin', TO_DATE('2023-01-10', 'YYYY-MM-DD'));


-- ==========================================
-- 2. TRANSAKSI SERVICE ORDER (5 Tanggal Berbeda)
-- ==========================================

-- --- SERVIS KE-1 (Tanggal 10 Juni 2026) ---
INSERT INTO service_order (id, id_vehicle, id_customer, date_arrive, odometer, diagnosis, summary_price) 
    VALUES (
        'SRVC-ORDR-0005', 
        'VHCL-0005', 
        'PLGN-0007', 
        TO_TIMESTAMP('2026-06-10 08:30:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 
        10000,
        'Servis rutin pertama, ganti oli mesin.',
        60000
    );

INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0006', 'MKNK-0001', 'SRVC-ORDR-0005');

INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0007', 'SRVC-ORDR-0005', 'SRVC-0001'); -- Ganti Oli

INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES ('DTL-SRVC-ORDR-SPRPT-0006', 'SPRPT-0001', 'SRVC-ORDR-0005', 1);


-- --- SERVIS KE-2 (Tanggal 15 Juni 2026) ---
INSERT INTO service_order (id, id_vehicle, id_customer, date_arrive, odometer, diagnosis, summary_price) 
    VALUES (
        'SRVC-ORDR-0006', 
        'VHCL-0005', 
        'PLGN-0007', 
        TO_TIMESTAMP('2026-06-15 09:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 
        13500,
        'Pembersihan CVT karena tarikan awal agak bergetar.',
        45000
    );

INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0007', 'MKNK-0002', 'SRVC-ORDR-0006');

INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0008', 'SRVC-ORDR-0006', 'SRVC-0002'); -- Servis CVT


-- --- SERVIS KE-3 (Tanggal 20 Juni 2026) ---
INSERT INTO service_order (id, id_vehicle, id_customer, date_arrive, odometer, diagnosis, summary_price) 
    VALUES (
        'SRVC-ORDR-0007', 
        'VHCL-0005', 
        'PLGN-0007', 
        TO_TIMESTAMP('2026-06-20 10:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 
        17000,
        'Tune up ringan dan pembersihan throttle body.',
        55000
    );

INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0008', 'MKNK-0003', 'SRVC-ORDR-0007');

INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0009', 'SRVC-ORDR-0007', 'SRVC-0003'); -- Servis Throttle Body


-- --- SERVIS KE-4 (Tanggal 25 Juni 2026) ---
INSERT INTO service_order (id, id_vehicle, id_customer, date_arrive, odometer, diagnosis, summary_price) 
    VALUES (
        'SRVC-ORDR-0008', 
        'VHCL-0005', 
        'PLGN-0007', 
        TO_TIMESTAMP('2026-06-25 13:45:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 
        20500,
        'Penggantian kampas rem depan yang sudah aus.',
        55000
    );

INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0009', 'MKNK-0004', 'SRVC-ORDR-0008');

INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0010', 'SRVC-ORDR-0008', 'SRVC-0004'); -- Ganti Kampas Rem

INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES ('DTL-SRVC-ORDR-SPRPT-0007', 'SPRPT-0003', 'SRVC-ORDR-0008', 1);


-- --- SERVIS KE-5 (Tanggal 30 Juni 2026) ---
INSERT INTO service_order (id, id_vehicle, id_customer, date_arrive, odometer, diagnosis, summary_price) 
    VALUES (
        'SRVC-ORDR-0009', 
        'VHCL-0005', 
        'PLGN-0007', 
        TO_TIMESTAMP('2026-06-30 14:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 
        24000,
        'Servis berkala bulanan dan pengecekan total.',
        95000
    );

INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0010', 'MKNK-0005', 'SRVC-ORDR-0009');

INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0011', 'SRVC-ORDR-0009', 'SRVC-0006'); -- Ganti Kampas Kopling

INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES ('DTL-SRVC-ORDR-SPRPT-0008', 'SPRPT-0005', 'SRVC-ORDR-0009', 1);