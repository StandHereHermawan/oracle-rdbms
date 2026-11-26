
-- Copyright (c) 1988, 2005, Oracle.  All Rights Reserved.
--
-- NAME
--   glogin.sql
--
-- DESCRIPTION
--   SQL*Plus global login "site profile" file
--
--   Add any SQL*Plus commands here that are to be executed when a
--   user starts SQL*Plus, or uses the SQL*Plus CONNECT command.
--
-- USAGE
--   This script is automatically run
--
-- placed in path: opt/oracle/product/26ai/sqlplus/admin/

-- Cek table
COLUMN OBJECT_NAME   FORMAT A20;
COLUMN OBJECT_TYPE   FORMAT A20;
COLUMN CREATED FORMAT A20;

COLUMN username FORMAT A20;
COLUMN account_status FORMAT A20;
COLUMN default_tablespace FORMAT A20;
COLUMN temporary_tablespace FORMAT A20;
COLUMN created FORMAT A20;


-- Tabel service_order
COLUMN id FORMAT A15;   
COLUMN id_vehicle FORMAT A15;   
COLUMN id_customer FORMAT A15;  
COLUMN date_arrive FORMAT A10;  
COLUMN date_finish FORMAT A10;  
COLUMN odometer FORMAT A20;  
COLUMN diagnosis FORMAT A20;  
COLUMN summary_price FORMAT A20;   
COLUMN order_status FORMAT A20;  

-- Tabel customer
COLUMN id  FORMAT A20;  
COLUMN fullname FORMAT A20;  
COLUMN phone_number FORMAT A20;  
COLUMN address FORMAT A20;  
COLUMN description FORMAT A20;  

-- Tabel Brand
COLUMN id FORMAT a20;
COLUMN fullname FORMAT a20;
COLUMN description FORMAT a20;

-- Tabel Mechanic
COLUMN id FORMAT A20;
COLUMN fullname FORMAT A20;
COLUMN start_working FORMAT A20;

-- Tabel specific_service
COLUMN id FORMAT A20;
COLUMN fullname FORMAT A20;
COLUMN description FORMAT A20;
COLUMN price FORMAT A20;

-- Tabel vehicle
COLUMN id FORMAT a20;
COLUMN id_customer FORMAT a20;
COLUMN id_brand FORMAT a20;
COLUMN police_number FORMAT a20;
COLUMN type FORMAT a20;
COLUMN production_year FORMAT a20;

-- Tabel On Charge
COLUMN id FORMAT A20;
COLUMN id_service_order FORMAT A20;
COLUMN id_mechanic FORMAT A20;

-- Tabel detail_service_order
COLUMN id FORMAT A20
COLUMN id_service_order FORMAT A20
COLUMN id_specific_service FORMAT A20

-- Tabel sparepart
COLUMN id  FORMAT A20;
COLUMN id_brand FORMAT A20;
COLUMN name FORMAT A20;
COLUMN stock_keeping_unit_code FORMAT A20;
COLUMN production_year FORMAT A20;
COLUMN price FORMAT A20;
COLUMN stock FORMAT A20;
COLUMN description FORMAT A20;

-- Tabel detail_service_order_sparepart 
COLUMN id FORMAT A20;
COLUMN id_spare_part FORMAT A20;
COLUMN id_service_order FORMAT A20;
COLUMN quantity FORMAT A20;


COLUMN nama_pelanggan FORMAT A20
COLUMN tipe_kendaraan FORMAT A20
COLUMN merk_kendaraan FORMAT A20
COLUMN nama_mekanik FORMAT A20
COLUMN nama_jasa FORMAT A20
COLUMN harga_jasa FORMAT A20
COLUMN nama_sparepart FORMAT A20
COLUMN jumlah_sparepart FORMAT A20
COLUMN harga_satuan_sparepart FORMAT A20
COLUMN merk_sparepart  FORMAT A20

SET LINESIZE 300;