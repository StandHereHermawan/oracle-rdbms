
INSERT INTO customer (id, fullname, phone_number) 
    VALUES ('PLGN-0003', 'Agnes','+62-820-5730-30');
INSERT INTO brand (id, fullname, description) 
    VALUES ('BRND-0001', 'Astra Honda Motor', 'Bukan Honda Federal');
INSERT INTO specific_service (id, fullname, price) 
    VALUES ('SRVC-0001', 'Ganti Oli', 10000);
INSERT INTO vehicle (id, id_customer, id_brand,police_number, type, production_year) 
    VALUES (
        'VHCL-0001', 
        'PLGN-0003', 
        'BRND-0001', 
        'D 1234 VCC', 
        'Matic', 
        2013
    );
INSERT INTO service_order (id, id_vehicle,id_customer, date_arrive, date_finish, odometer, diagnosis, summary_price) 
    VALUES (
            'SRVC-ORDR-0001', 
            'VHCL-0001', 
            'PLGN-0003', 
            TO_TIMESTAMP('2026-06-07 14:30:45.123456', 'YYYY-MM-DD HH24:MI:SS.FF'), 
            TO_TIMESTAMP('2026-06-07 15:00:45.123456', 'YYYY-MM-DD HH24:MI:SS.FF'), 
            23000,
            'Tidak ada, ganti oli biasa.',
            60000
        );
INSERT INTO service_order (id, id_vehicle,id_customer, date_arrive, date_finish, odometer, diagnosis, summary_price) 
    VALUES (
            'SRVC-ORDR-0010', 
            'VHCL-0001', 
            'PLGN-0003', 
            TO_TIMESTAMP('2026-09-07 14:30:45.123456', 'YYYY-MM-DD HH24:MI:SS.FF'), 
            TO_TIMESTAMP('2026-09-07 15:00:45.123456', 'YYYY-MM-DD HH24:MI:SS.FF'), 
            23000,
            'Tidak ada, ganti oli biasa.',
            60000
        );
INSERT INTO mechanic (id, fullname, start_working) 
    VALUES ('MKNK-0001', 'Apip Supriatna', TO_DATE('2019-03-12', 'YYYY-MM-DD'));
INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0001', 'MKNK-0001', 'SRVC-ORDR-0001');
INSERT INTO detail_service_order (id, id_service_order,id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0001','SRVC-ORDR-0001','SRVC-0001');
INSERT INTO brand (id, fullname, description) 
    VALUES ('BRND-0002', 'Repsol', 'Brand Oli');
INSERT INTO sparepart (id,  id_brand,  name,  stock_keeping_unit_code,  production_year,  price,  stock) 
    VALUES (
        'SPRPT-0001',
        'BRND-0002',
        'Oli Mesin 10w-40',
        '123-123',
        2026,
        50000,
        10
    );
INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES (
        'DTL-SRVC-ORDR-SPRPT-0001',
        'SPRPT-0001',
        'SRVC-ORDR-0001',
        1
    );
INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES (
        'DTL-SRVC-ORDR-SPRPT-0012',
        'SPRPT-0001',
        'SRVC-ORDR-0010',
        1
    );





INSERT INTO customer (id, fullname, phone_number) 
    VALUES ('PLGN-0004', 'Anton Ladesh', '+62-812-5730-12');

INSERT INTO specific_service (id, fullname, price) 
    VALUES ('SRVC-0002', 'Servis CVT', 45000);

INSERT INTO vehicle (id, id_customer, id_brand, police_number, type, production_year) 
    VALUES (
        'VHCL-0002', 
        'PLGN-0004', 
        'BRND-0001', 
        'D 2331 VBL', 
        'Matic', 
        2015
    );

INSERT INTO service_order (id, id_vehicle, id_customer, date_arrive, odometer, diagnosis, summary_price) 
    VALUES (
            'SRVC-ORDR-0002', 
            'VHCL-0002', 
            'PLGN-0004', 
            TO_TIMESTAMP('2026-06-07 14:30:45.123456', 'YYYY-MM-DD HH24:MI:SS.FF'), 
            23000,
            'Tidak ada diagnosis, Ganti oli rutin dan pembersihan CVT.',
            195000
        );


INSERT INTO mechanic (id, fullname, start_working) 
    VALUES ('MKNK-0002', 'Dedi Mulyadi', TO_DATE('2020-06-12', 'YYYY-MM-DD'));

INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0002', 'MKNK-0001', 'SRVC-ORDR-0002');
INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0003', 'MKNK-0002', 'SRVC-ORDR-0002');

INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0002', 'SRVC-ORDR-0002', 'SRVC-0002');
INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0003', 'SRVC-ORDR-0002', 'SRVC-0001');

INSERT INTO sparepart (id, id_brand, name, stock_keeping_unit_code, production_year, price, stock, description) 
    VALUES (
        'SPRPT-0002',
        'BRND-0002',
        'Oli Mesin 10w-40 Full Sintetik',
        '123-123',
        '2026',
        150000,
        10,
        'Oli mesin matic Repsol Full Sintetik'
    );

INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES (
        'DTL-SRVC-ORDR-SPRPT-0002',
        'SPRPT-0002',
        'SRVC-ORDR-0002',
        1
    );






INSERT INTO customer (id, fullname, phone_number) 
    VALUES ('PLGN-0005', 'Budi Santoso', '+62-812-3456-78');

INSERT INTO brand (id, fullname, description) 
    VALUES ('BRND-0003', 'Yamaha', 'Produsen sepeda motor Yamaha');

INSERT INTO specific_service (id, fullname, price) 
    VALUES ('SRVC-0003', 'Servis Throttle Body', 20000);

INSERT INTO specific_service (id, fullname, price) 
    VALUES ('SRVC-0004', 'Ganti Kampas Rem', 10000);

INSERT INTO vehicle (id, id_customer, id_brand, police_number, type, production_year) 
    VALUES (
        'VHCL-0003', 
        'PLGN-0005', 
        'BRND-0003', 
        'D 5678 XYZ', 
        'Bebek', 
        2018
    );

INSERT INTO mechanic (id, fullname, start_working) 
    VALUES ('MKNK-0003', 'Jajang Nurjaman', TO_DATE('2021-05-20', 'YYYY-MM-DD'));

INSERT INTO service_order (id, id_vehicle, id_customer, date_arrive, odometer, diagnosis, summary_price) 
    VALUES (
            'SRVC-ORDR-0003', 
            'VHCL-0003', 
            'PLGN-0005', 
            TO_TIMESTAMP('2026-06-08 09:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 
            45000,
            'Rem depan agak longgar dan tarikan berat.',
            20000 + 10000 + 45000 + 25000
        );

INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0004', 'MKNK-0003', 'SRVC-ORDR-0003');

INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0004', 'SRVC-ORDR-0003', 'SRVC-0003');
INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0005', 'SRVC-ORDR-0003', 'SRVC-0004');

INSERT INTO brand (id, fullname, description) 
    VALUES ('BRND-0004', 'Nissin Brake Systems', 'Produsen sistem pengereman');

INSERT INTO sparepart (id, id_brand, name, stock_keeping_unit_code, production_year, price, stock) 
    VALUES (
        'SPRPT-0003',
        'BRND-0004',
        'Kampas Rem Depan',
        'KRM-9988',
        2025,
        45000,
        15
    );

INSERT INTO brand (id, fullname, description) 
    VALUES ('BRND-0005', 'Astra Otoparts', 'Produsen komponen motor');

INSERT INTO sparepart (id, id_brand, name, stock_keeping_unit_code, production_year, price, stock) 
    VALUES (
        'SPRPT-0004',
        'BRND-0005',
        'Carb Cleaner 200ML',
        'ASTR-0001-0001',
        2025,
        25000,
        10
    );

INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES (
        'DTL-SRVC-ORDR-SPRPT-0003',
        'SPRPT-0003',
        'SRVC-ORDR-0003',
        1
    );
INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES (
        'DTL-SRVC-ORDR-SPRPT-0004',
        'SPRPT-0004',
        'SRVC-ORDR-0003',
        1
    );






INSERT INTO customer (id, fullname, phone_number) 
    VALUES ('PLGN-0006', 'Siti Rahmawati', '+62-856-1122-33');

INSERT INTO brand (id, fullname, description) 
    VALUES ('BRND-0006', 'Suzuki', 'Produsen sepeda motor Suzuki');

INSERT INTO specific_service (id, fullname, price) 
    VALUES ('SRVC-0005', 'Tune Up Ringan', 35000);

INSERT INTO vehicle (id, id_customer, id_brand, police_number, type, production_year) 
    VALUES (
        'VHCL-0004', 
        'PLGN-0006', 
        'BRND-0006', 
        'D 9988 ABC', 
        'Matic', 
        2019
    );

INSERT INTO service_order (id, id_vehicle, id_customer, date_arrive, odometer, diagnosis, summary_price) 
    VALUES (
            'SRVC-ORDR-0004', 
            'VHCL-0004', 
            'PLGN-0006', 
            TO_TIMESTAMP('2026-06-09 10:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 
            15000,
            'Tune up rutin, tarikan mesin terasa agak berat.',
            110000
        );

INSERT INTO mechanic (id, fullname, start_working) 
    VALUES ('MKNK-0004', 'Rian Hidayat', TO_DATE('2022-01-15', 'YYYY-MM-DD'));

INSERT INTO on_charge (id, id_mechanic, id_service_order) 
    VALUES ('CHRG-0005', 'MKNK-0004', 'SRVC-ORDR-0004');

INSERT INTO detail_service_order (id, id_service_order, id_specific_service) 
    VALUES ('DTL-SRVC-ORDR-0006', 'SRVC-ORDR-0004', 'SRVC-0005');

INSERT INTO brand (id, fullname, description) 
    VALUES ('BRND-0007', 'NGK Spark Plugs', 'Produsen busi kendaraan');

INSERT INTO sparepart (id, id_brand, name, stock_keeping_unit_code, production_year, price, stock) 
    VALUES (
        'SPRPT-0005',
        'BRND-0007',
        'Busi Platinum NGK',
        'NGK-7788',
        2026,
        75000,
        20
    );

INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES (
        'DTL-SRVC-ORDR-SPRPT-0005',
        'SPRPT-0005',
        'SRVC-ORDR-0004',
        1
    );





   
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
    VALUES ('DTL-SRVC-ORDR-0007', 'SRVC-ORDR-0005', 'SRVC-0001');

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
    VALUES ('DTL-SRVC-ORDR-0008', 'SRVC-ORDR-0006', 'SRVC-0002');


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
    VALUES ('DTL-SRVC-ORDR-0009', 'SRVC-ORDR-0007', 'SRVC-0003');



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
    VALUES ('DTL-SRVC-ORDR-0010', 'SRVC-ORDR-0008', 'SRVC-0004');

INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES ('DTL-SRVC-ORDR-SPRPT-0007', 'SPRPT-0003', 'SRVC-ORDR-0008', 1);



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
    VALUES ('DTL-SRVC-ORDR-0011', 'SRVC-ORDR-0009', 'SRVC-0006');

INSERT INTO detail_service_order_sparepart (id, id_spare_part, id_service_order, quantity)
    VALUES ('DTL-SRVC-ORDR-SPRPT-0008', 'SPRPT-0005', 'SRVC-ORDR-0009', 1);