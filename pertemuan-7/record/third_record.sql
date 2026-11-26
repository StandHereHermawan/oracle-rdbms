-- insert ketiga
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