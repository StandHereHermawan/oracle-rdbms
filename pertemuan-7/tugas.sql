-- masuk ke admin
sqlplus / as sysdba

-- cek nama container
SHOW CON_NAME;

ALTER SESSION SET CONTAINER = FREEPDB1;

SHOW CON_NAME;

-- Melihat Table Spaces
SET LINESIZE 200;
SET PAGESIZE 50;
SELECT tablespace_name, status FROM dba_tablespaces;
-- TABLESPACE_NAME                STATUS
-- ------------------------------ ---------
-- SYSTEM                         ONLINE
-- SYSAUX                         ONLINE
-- UNDOTBS1                       ONLINE
-- TEMP                           ONLINE
-- USERS                          ONLINE



-- Format tampilan terminal
COLUMN username FORMAT A25;
COLUMN account_status FORMAT A15;



-- CEK DAFTAR SCHEMA atau USER (User atau Schema sama saja di konteks oracle RDBMS)
SELECT username, account_status, default_tablespace, temporary_tablespace, created FROM dba_users;
SELECT username, account_status, default_tablespace, temporary_tablespace, created FROM dba_users where default_tablespace = 'USERS';
SELECT username, account_status, default_tablespace, temporary_tablespace, created FROM dba_users where default_tablespace = 'USERS' and account_status = 'OPEN';



-- Membuat schema spesifik mitra bengkel
CREATE USER KEL05_BENGKEL IDENTIFIED BY "rahasia" DEFAULT TABLESPACE users  TEMPORARY TABLESPACE temp;

-- cek schema yang sudah dibuat
SELECT username, account_status, default_tablespace, temporary_tablespace, created FROM dba_users where default_tablespace = 'USERS' and account_status = 'OPEN';
-- cek isi schema
SELECT COUNT(*) FROM dba_objects WHERE owner = 'KEL05_BENGKEL';

-- perintah memberi hak akses ke schema.
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO KEL05_BENGKEL;

-- Cek apakah privillege sudah ada pada schema.
SELECT grantee, privilege FROM dba_sys_privs WHERE grantee = 'KEL05_BENGKEL' ORDER BY privilege;




-- masuk ke schema
CONNECT KEL05_BENGKEL/rahasia@localhost:1521

-- cek schema
SELECT USER FROM DUAL;
COLUMN schema_aktif FORMAT A25;
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS schema_aktif FROM DUAL;
-- cek jumlah isi schema
SELECT COUNT(*) FROM user_objects;



SELECT OBJECT_NAME, OBJECT_TYPE, CREATED FROM user_objects where  OBJECT_TYPE = 'TABLE';




-- Tabel Pelanggan
CREATE TABLE IF NOT EXISTS customer (
    id VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    address NCLOB NOT NULL
);
DROP IF EXISTS customer;
DESCRIBE customer;

-- Tabel Brand.
CREATE TABLE IF NOT EXISTS brand (
    id VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    description NCLOB
);
DROP IF EXISTS brand;
DESCRIBE brand;

-- Tabel mechanic
CREATE TABLE IF NOT EXISTS mechanic (
    id VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    start_working DATE NOT NULL
);
DROP IF EXISTS mechanic;
DESCRIBE mechanic;

-- Tabel Master specific_service, misal servis rutin, ganti oli, servis CVT.
CREATE TABLE IF NOT EXISTS specific_service (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description NCLOB,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0)
);
DROP IF EXISTS specific_service;
DESCRIBE specific_service;

-- Tabel vehicle (Relasi One-to-Many dengan customer), (Relasi One-to-Many dengan Brand)
 -- default ON DELETE RESTRICT
CREATE TABLE IF NOT EXISTS vehicle (
    id VARCHAR(255) PRIMARY KEY,
    id_customer VARCHAR(255) NOT NULL,
    id_brand VARCHAR(255),
    police_number VARCHAR(15) UNIQUE NOT NULL,
    type VARCHAR(50) NOT NULL,
    production_year INT NOT NULL CHECK (production_year >= 1990),
    CONSTRAINT fk_cstmr_id FOREIGN KEY (id_customer) REFERENCES customer(id),
    CONSTRAINT fk_brnd_id FOREIGN KEY (id_brand) REFERENCES brand(id) 
);
DROP IF EXISTS vehicle;
DESCRIBE vehicle;

-- Tabel On charge. (Relasi Many-to-Many antara service_order dan specific_service)
-- bisa saja 1 service order dilakukan oleh lebih dari 1 mekanik.
CREATE TABLE IF NOT EXISTS on_charge (
    id VARCHAR(255) PRIMARY KEY,
    id_mechanic VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_mechanic) REFERENCES mechanic(id)
);
DROP IF EXISTS on_charge;
DESCRIBE on_charge;


-- Tabel service_order (Transaksi Utama)
CREATE TABLE IF NOT EXISTS service_order (
    id VARCHAR(255) PRIMARY KEY,
    id_vehicle VARCHAR(255) NOT NULL,
    id_on_charge VARCHAR(255) NOT NULL,
    date_arrive TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    odometer INT NOT NULL CHECK (odometer >= 0),
    diagnosis NCLOB NOT NULL,
    order_status VARCHAR(10) DEFAULT 'ANTRI' CHECK (order_status IN ('ANTRI', 'PROSES', 'SELESAI')),
    FOREIGN KEY (id_vehicle) REFERENCES vehicle(id),
    FOREIGN KEY (id_on_charge) REFERENCES on_charge(id)
);
DROP IF EXISTS service_order;
DESCRIBE service_order;


-- Tabel Detail service_order (Relasi Many-to-Many antara service_order dan specific_service)
CREATE TABLE IF NOT EXISTS detail_service_order (
    id VARCHAR(255) PRIMARY KEY,
    id_service_order VARCHAR(255),
    id_specific_service VARCHAR(255),
    summary_price DECIMAL(10, 2) NOT NULL CHECK (summary_price >= 0),
    FOREIGN KEY (id_service_order) REFERENCES service_order(id),
    FOREIGN KEY (id_specific_service) REFERENCES specific_service(id)
);
DROP IF EXISTS detail_service_order;
DESCRIBE detail_service_order;


-- Tabel Master sparepart
CREATE TABLE IF NOT EXISTS sparepart (
    id VARCHAR(255) PRIMARY KEY,
    id_brand VARCHAR(255),
    name VARCHAR(100) NOT NULL,
    stock_keeping_unit_code VARCHAR(255),
    production_year VARCHAR(10),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    description NCLOB,
    FOREIGN KEY (id_brand) REFERENCES brand(id)
);
DROP IF EXISTS sparepart;
DESCRIBE sparepart;

-- Tabel Detail service_order sparepart (Relasi Many-to-Many antara service_order dan sparepart)
CREATE TABLE IF NOT EXISTS detail_service_order_sparepart (
    id VARCHAR(255) PRIMARY KEY,
    id_spare_part VARCHAR(255),
    id_service_order VARCHAR(255),
    quantity INT NOT NULL CHECK (quantity > 0),
    summary_price DECIMAL(10, 2) CHECK (summary_price >= 0),
    FOREIGN KEY (id_service_order) REFERENCES service_order(id),
    FOREIGN KEY (id_spare_part) REFERENCES sparepart(id)
);
DROP IF EXISTS detail_service_order_sparepart;
DESCRIBE detail_service_order_sparepart;
