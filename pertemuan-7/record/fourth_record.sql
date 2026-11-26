-- Insert Keempat
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