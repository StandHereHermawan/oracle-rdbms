-- 1. Hapus tabel detail dan relasi transaksi terbawah terlebih dahulu
DROP TABLE IF EXISTS detail_service_order;
DROP TABLE IF EXISTS detail_service_order_sparepart;

-- 2. Hapus tabel transaksi utama dan sub-master
DROP TABLE IF EXISTS on_charge;
DROP TABLE IF EXISTS sparepart;
DROP TABLE IF EXISTS service_order;

-- 3. Hapus tabel kendaraan
DROP TABLE IF EXISTS vehicle;

-- 4. Terakhir, hapus tabel master utama
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS brand;
DROP TABLE IF EXISTS mechanic;
DROP TABLE IF EXISTS specific_service;