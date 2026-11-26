-- Insert Pertama
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
