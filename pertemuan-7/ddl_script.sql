-- Tabel Pelanggan (Tabel Master)
CREATE TABLE IF NOT EXISTS customer (
    id VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    address NCLOB,
    description NCLOB
);
DESCRIBE customer;

-- Tabel Brand.
CREATE TABLE IF NOT EXISTS brand (
    id VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    description NCLOB
);
DESCRIBE brand;

-- Tabel mechanic
CREATE TABLE IF NOT EXISTS mechanic (
    id VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    start_working DATE NOT NULL
);
DESCRIBE mechanic;

-- Tabel Master specific_service, misal servis rutin, ganti oli, servis CVT.
CREATE TABLE IF NOT EXISTS specific_service (
    id VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    description NCLOB,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0)
);
DESCRIBE specific_service;

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
DESCRIBE sparepart;

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
DESCRIBE vehicle;

-- Tabel service_order (Transaksi Utama)
CREATE TABLE IF NOT EXISTS service_order (
    id VARCHAR(255) PRIMARY KEY,
    id_vehicle VARCHAR(255) NOT NULL,
    id_customer VARCHAR(255) NOT NULL,
    date_arrive TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_finish TIMESTAMP,
    odometer INT NOT NULL CHECK (odometer >= 0),
    diagnosis NCLOB NOT NULL,
    summary_price DECIMAL(10, 2) NOT NULL CHECK (summary_price >= 0),
    order_status VARCHAR(10) DEFAULT 'ANTRI' CHECK (order_status IN ('ANTRI', 'PROSES', 'SELESAI')),
    FOREIGN KEY (id_vehicle) REFERENCES vehicle(id),
    FOREIGN KEY (id_customer) REFERENCES customer(id)
);
DESCRIBE service_order;

-- Tabel On charge. (Relasi Many-to-Many antara service_order dan specific_service)
-- bisa saja 1 service order dilakukan oleh lebih dari 1 mekanik.
CREATE TABLE IF NOT EXISTS on_charge (
    id VARCHAR(255) PRIMARY KEY,
    id_service_order VARCHAR(255),
    id_mechanic VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_service_order) REFERENCES service_order(id),
    FOREIGN KEY (id_mechanic) REFERENCES mechanic(id)
);
DESCRIBE on_charge;

-- Tabel Detail service_order (Relasi Many-to-Many antara service_order dan specific_service)
CREATE TABLE IF NOT EXISTS detail_service_order (
    id VARCHAR(255) PRIMARY KEY,
    id_service_order VARCHAR(255),
    id_specific_service VARCHAR(255),
    FOREIGN KEY (id_service_order) REFERENCES service_order(id),
    FOREIGN KEY (id_specific_service) REFERENCES specific_service(id)
);
DESCRIBE detail_service_order;

-- Tabel Detail service_order sparepart (Relasi Many-to-Many antara service_order dan sparepart)
CREATE TABLE IF NOT EXISTS detail_service_order_sparepart (
    id VARCHAR(255) PRIMARY KEY,
    id_spare_part VARCHAR(255),
    id_service_order VARCHAR(255),
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (id_service_order) REFERENCES service_order(id),
    FOREIGN KEY (id_spare_part) REFERENCES sparepart(id)
);
DESCRIBE detail_service_order_sparepart;