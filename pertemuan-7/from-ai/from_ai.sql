-- 1. Tabel Pelanggan
CREATE TABLE pelanggan (
    kode_pelanggan VARCHAR(10) PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    nomor_hp VARCHAR(15) UNIQUE NOT NULL,
    alamat TEXT NOT NULL
);

-- 2. Tabel Motor (Relasi One-to-Many dengan Pelanggan)
CREATE TABLE motor (
    nomor_polisi VARCHAR(15) PRIMARY KEY,
    kode_pelanggan VARCHAR(10) NOT NULL,
    merk VARCHAR(50) NOT NULL,
    tipe VARCHAR(50) NOT NULL,
    tahun_pembuatan INT NOT NULL CHECK (tahun_pembuatan >= 1990),
    FOREIGN KEY (kode_pelanggan) REFERENCES pelanggan(kode_pelanggan)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 3. Tabel Mekanik
CREATE TABLE mekanik (
    kode_mekanik VARCHAR(10) PRIMARY KEY,
    nama_mekanik VARCHAR(100) NOT NULL,
    keahlian_utama VARCHAR(100) NOT NULL,
    tanggal_mulai_bekerja DATE NOT NULL
);

-- 5a. Tabel Master Jasa
CREATE TABLE jasa (
    kode_jasa VARCHAR(10) PRIMARY KEY,
    nama_jasa VARCHAR(100) NOT NULL,
    biaya_standar DECIMAL(10, 2) NOT NULL CHECK (biaya_standar >= 0)
);

-- 6a. Tabel Master Suku Cadang
CREATE TABLE suku_cadang (
    kode_suku_cadang VARCHAR(10) PRIMARY KEY,
    nama_suku_cadang VARCHAR(100) NOT NULL,
    harga DECIMAL(10, 2) NOT NULL CHECK (harga >= 0),
    stok INT NOT NULL DEFAULT 0 CHECK (stok >= 0)
);

-- 4. Tabel Servis (Transaksi Utama)
CREATE TABLE servis (
    nomor_servis VARCHAR(20) PRIMARY KEY,
    nomor_polisi VARCHAR(15) NOT NULL,
    kode_mekanik VARCHAR(10) NOT NULL,
    tanggal TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    kilometer_datang INT NOT NULL CHECK (kilometer_datang >= 0),
    keluhan TEXT NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'ANTRI' CHECK (status IN ('ANTRI', 'PROSES', 'SELESAI')),
    FOREIGN KEY (nomor_polisi) REFERENCES motor(nomor_polisi)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (kode_mekanik) REFERENCES mekanik(kode_mekanik)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 5b. Tabel Detail Servis Jasa (Relasi Many-to-Many antara Servis dan Jasa)
CREATE TABLE detail_servis_jasa (
    nomor_servis VARCHAR(20),
    kode_jasa VARCHAR(10),
    biaya_saat_ini DECIMAL(10, 2) NOT NULL CHECK (biaya_saat_ini >= 0),
    PRIMARY KEY (nomor_servis, kode_jasa),
    FOREIGN KEY (nomor_servis) REFERENCES servis(nomor_servis)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (kode_jasa) REFERENCES jasa(kode_jasa)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 6b. Tabel Detail Servis Suku Cadang (Relasi Many-to-Many antara Servis dan Suku Cadang)
CREATE TABLE detail_servis_suku_cadang (
    nomor_servis VARCHAR(20),
    kode_suku_cadang VARCHAR(10),
    jumlah INT NOT NULL CHECK (jumlah > 0),
    harga_satuan_saat_itu DECIMAL(10, 2) NOT NULL CHECK (harga_satuan_saat_itu >= 0),
    PRIMARY KEY (nomor_servis, kode_suku_cadang),
    FOREIGN KEY (nomor_servis) REFERENCES servis(nomor_servis)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (kode_suku_cadang) REFERENCES suku_cadang(kode_suku_cadang)
        ON UPDATE CASCADE ON DELETE RESTRICT
);