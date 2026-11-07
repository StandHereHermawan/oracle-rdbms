docker exec -it oracle-db-a1016-container sqlplus praktikum/Praktikum123@localhost:1521/FREEPDB1

CONNECT praktikum/Praktikum123@localhost:1521/FREEPDB1;

COLUMN OBJECT_NAME FORMAT A12;

SELECT OBJECT_NAME, OBJECT_ID, OBJECT_TYPE, CREATED, LAST_DDL_TIME, TIMESTAMP FROM user_objects;
SELECT OBJECT_NAME FROM user_objects;
SELECT OBJECT_NAME, OBJECT_TYPE, CREATED FROM user_objects where  OBJECT_TYPE = 'TABLE';


-- Lupa Syarat Join: Produk Kartesius
-- Tanpa syarat join
SELECT COUNT(*) AS jml
 FROM mahasiswa, prodi;
--  JML
-- ----------
--  145
-- Dengan syarat join
SELECT COUNT(*) AS jml FROM mahasiswa, prodi WHERE mahasiswa.kode_prodi = prodi.kode_prodi;
--  JML
-- ----------
--  29




--  Dua Cara Menulis Join, Hasil Sama
-- Gaya Oracle: syarat di WHERE
SELECT mahasiswa.nim, mahasiswa.nama, prodi.nama_prodi FROM mahasiswa, prodi WHERE mahasiswa.kode_prodi = prodi.kode_prodi AND mahasiswa.angkatan = 2026;

SELECT m.nim, m.nama, p.nama_prodi
 FROM mahasiswa m, prodi p
WHERE m.kode_prodi = p.kode_prodi
 
-- NIM NAMA NAMA_PRODI
-- ---------- --------------- -----------------------
-- 2601001 Agus Salim Teknik Informatika
-- 2601002 Bella Safira Sistem Informasi
-- 2601003 Candra Wibowo Komputerisasi Akuntansi



-- Gaya ANSI: JOIN ... ON

COLUMN alamat FORMAT A20;
COLUMN nama FORMAT A20;
COLUMN nama_prodi FORMAT A20;
COLUMN email FORMAT A12;

SELECT mahasiswa.nim, mahasiswa.nama, prodi.nama_prodi FROM mahasiswa JOIN prodi ON prodi.kode_prodi = mahasiswa.kode_prodi WHERE mahasiswa.angkatan = 2026;


SELECT m.nim, m.nama, p.nama_prodi FROM mahasiswa m JOIN prodi p ON p.kode_prodi = m.kode_prodi WHERE m.angkatan = 2026;
SELECT nim, m.nama, p.nama_prodi FROM mahasiswa m JOIN prodi p ON p.kode_prodi = m.kode_prodi WHERE m.angkatan = 2026;
-- NIM NAMA NAMA_PRODI
-- ---------- --------------- -----------------------
-- 2601001 Agus Salim Teknik Informatika
-- 2601002 Bella Safira Sistem Informasi
-- 2601003 Candra Wibowo Komputerisasi Akuntansi





-- Alias Tabel dan Kolom yang Ambigu
-- Tanpa alias: kode_prodi ada di dua tabel
SELECT nim, nama, kode_prodi, nama_prodi  FROM mahasiswa, prodi WHERE mahasiswa.kode_prodi =  prodi.kode_prodi  AND angkatan = 2026;
-- ORA-00918: KODE_PRODI: column ambiguously specified - appears in PRODI and MAHASISWA

COLUMN nama FORMAT A20;
-- Perbaikan dengan USING
SELECT nim, nama, kode_prodi, nama_prodi  FROM mahasiswa  JOIN prodi USING (kode_prodi) WHERE angkatan = 2026;





COLUMN nama_mk FORMAT A20;
-- Kartu Hasil Studi Budi Santoso
SELECT k.tahun_ajar, mk.nama_mk,  mk.sks, k.nilai_huruf  FROM krs k  JOIN mata_kuliah mk  ON mk.kode_mk = k.kode_mk  JOIN mahasiswa m  ON m.nim = k.nim WHERE m.nama = 'Budi Santoso'  AND k.nilai_huruf IS NOT NULL ORDER BY k.tahun_ajar, mk.nama_mk;





-- IPK Berbobot SKS Mahasiswa TI01
SELECT m.nim, m.nama, SUM(mk.sks) AS sks,  ROUND(SUM(mk.sks * DECODE(k.nilai_huruf,  'A', 4, 'AB', 3.5, 'B', 3, 'BC', 2.5,  'C', 2, 'D', 1, 'E', 0)) / SUM(mk.sks),  2) AS ipk  FROM krs k  JOIN mahasiswa m ON m.nim = k.nim  JOIN mata_kuliah mk ON mk.kode_mk = k.kode_mk WHERE m.kode_prodi = 'TI01'  AND k.nilai_huruf IS NOT NULL GROUP BY m.nim, m.nama ORDER BY ipk DESC;
-- NIM NAMA SKS IPK
-- ---------- --------------- --- ----------
-- 2301001 Andi Pratama 11 3.77
-- 2401001 Budi Santoso 15 3.3
-- 2501005 Joko Susilo 9 2.78
-- 2401004 Eko Saputra 15 2.73
-- 2301003 Putra Wijaya 11 2.73
-- 2201001 Lukman Hakim 9 2.61
-- 2401007 Vina Amelia 15 2.17
-- 2501001 Fajar Nugroho 9 1.89
-- 2501009 Zainal Abidin 9 1.22
-- 
-- 9 rows selected.



-- Inner join
SELECT p.kode_prodi, p.nama_prodi,  COUNT(m.nim) AS jml  FROM prodi p  JOIN mahasiswa m  ON m.kode_prodi = p.kode_prodi GROUP BY p.kode_prodi, p.nama_prodi ORDER BY p.kode_prodi;
-- KODE NAMA_PRODI JML
-- ---- ----------------------- ----------
-- KA01 Komputerisasi Akuntansi 5
-- MI01 Manajemen Informatika 5
-- SI01 Sistem Informasi 9
-- TI01 Teknik Informatika 10






-- Mata Kuliah dengan SKS di Atas Rata-Rata
SELECT kode_mk, nama_mk, sks  FROM mata_kuliah WHERE sks > (SELECT AVG(sks)  FROM mata_kuliah) ORDER BY sks DESC, kode_mk;




-- Kolom ekspresi wajib punya alias
CREATE OR REPLACE VIEW v_coba AS  SELECT nim, DECODE(nilai_huruf, 'A', 4, 0)  FROM krs;
-- ORA-00998: must name this expression with a column alias




-- Satu View untuk Seluruh Data KRS
CREATE OR REPLACE VIEW v_krs_lengkap AS SELECT k.nim, m.nama, m.kode_prodi, k.kode_mk, mk.nama_mk, mk.sks, k.tahun_ajar, k.nilai_huruf, DECODE(k.nilai_huruf, 'A', 4, 'AB', 3.5, 'B', 3, 'BC', 2.5, 'C', 2, 'D', 1, 'E', 0) AS bobot FROM krs k JOIN mahasiswa m ON m.nim = k.nim JOIN mata_kuliah mk ON mk.kode_mk = k.kode_mk WITH READ ONLY;
-- View created.

-- KHS Budi sekarang cukup satu FROM
SELECT nama_mk, sks, nilai_huruf,  bobot  FROM v_krs_lengkap WHERE nim = '2401001'  AND nilai_huruf IS NOT NULL ORDER BY tahun_ajar, nama_mk;

-- NAMA_MK SKS NILAI_HURUF BOBOT
-- ----------------------------- --- ----------- -----
-- Algoritma dan Pemrograman 4 AB 3.5
-- Matematika Diskrit 3 BC 2.5
-- Pengantar Teknologi Informasi 2 AB 3.5
-- Pemrograman Objek 3 B 3.0
-- Sistem Basis Data 3 A 4.0