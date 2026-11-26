-- insert kedua
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