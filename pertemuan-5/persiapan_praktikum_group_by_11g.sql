-- =====================================================================
-- Skrip data Modul Praktikum "Pengelompokan, Pengurutan, dan Kriteria
-- Data: WHERE, ORDER BY, GROUP BY, HAVING" (versi Oracle 11g)
-- Membuat ulang tabel PRODI, MAHASISWA, MATA_KULIAH, dan KRS lalu
-- mengisinya dengan 5 prodi, 29 mahasiswa, 14 mata kuliah, dan 151 KRS.
-- Jalankan sebagai user PRAKTIKUM di database XE (Oracle Database 11g XE):
--   SQL> @persiapan_praktikum_group_by_11g.sql
-- PERHATIAN: seluruh isi keempat tabel akan dihapus lalu dibuat ulang.
-- Skrip boleh dijalankan berulang kali untuk mengembalikan data awal.
-- =====================================================================
SET DEFINE OFF
SET FEEDBACK OFF
PROMPT Menghapus tabel lama ...
BEGIN
  FOR t IN (SELECT 'KRS' AS nama FROM dual UNION ALL
            SELECT 'MAHASISWA' FROM dual UNION ALL
            SELECT 'MATA_KULIAH' FROM dual UNION ALL
            SELECT 'PRODI' FROM dual) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE ' || t.nama || ' CASCADE CONSTRAINTS PURGE';
    EXCEPTION
      WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
    END;
  END LOOP;
  BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_krs';
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE != -2289 THEN RAISE; END IF;
  END;
END;
/

PROMPT Membuat tabel ...

CREATE TABLE prodi (
  kode_prodi  CHAR(4)       CONSTRAINT pk_prodi PRIMARY KEY,
  nama_prodi  VARCHAR2(60)  NOT NULL,
  jenjang     VARCHAR2(5)   DEFAULT 'S1'
                            CONSTRAINT ck_prodi_jenjang
                            CHECK (jenjang IN ('D3','S1','S2','S3'))
);

CREATE TABLE mahasiswa (
  nim            VARCHAR2(10)   CONSTRAINT pk_mahasiswa PRIMARY KEY,
  nama           VARCHAR2(150)  NOT NULL,
  email          VARCHAR2(100),
  jenis_kelamin  CHAR(1)        CONSTRAINT ck_mhs_jk
                                CHECK (jenis_kelamin IN ('L','P')),
  tgl_lahir      DATE,
  kode_prodi     CHAR(4)        CONSTRAINT fk_mhs_prodi
                                REFERENCES prodi (kode_prodi),
  angkatan       NUMBER(4)      NOT NULL,
  tgl_daftar     DATE           DEFAULT SYSDATE,
  status         VARCHAR2(10)   DEFAULT 'AKTIF' NOT NULL,
  CONSTRAINT ck_mhs_angkatan CHECK (angkatan >= 2000),
  CONSTRAINT ck_mhs_status   CHECK (status IN ('AKTIF','CUTI','LULUS','DO')),
  CONSTRAINT uq_mhs_email    UNIQUE (email)
);

CREATE TABLE mata_kuliah (
  kode_mk   VARCHAR2(8)   CONSTRAINT pk_mata_kuliah PRIMARY KEY,
  nama_mk   VARCHAR2(80)  NOT NULL,
  sks       NUMBER(1)     NOT NULL
                          CONSTRAINT ck_mk_sks CHECK (sks BETWEEN 1 AND 6),
  semester  NUMBER(1)
);

CREATE TABLE krs (
  id_krs       NUMBER,
  nim          VARCHAR2(10)  NOT NULL,
  kode_mk      VARCHAR2(8)   NOT NULL,
  tahun_ajar   VARCHAR2(9)   NOT NULL,
  nilai_huruf  VARCHAR2(2),
  CONSTRAINT pk_krs     PRIMARY KEY (id_krs),
  CONSTRAINT fk_krs_mhs FOREIGN KEY (nim)
                        REFERENCES mahasiswa (nim) ON DELETE CASCADE,
  CONSTRAINT fk_krs_mk  FOREIGN KEY (kode_mk)
                        REFERENCES mata_kuliah (kode_mk),
  CONSTRAINT uq_krs     UNIQUE (nim, kode_mk, tahun_ajar)
);

PROMPT Mengisi data ...
-- PRODI (5 baris; BD01 sengaja belum memiliki mahasiswa)
INSERT INTO prodi VALUES ('TI01', 'Teknik Informatika', 'S1');
INSERT INTO prodi VALUES ('SI01', 'Sistem Informasi', 'S1');
INSERT INTO prodi VALUES ('MI01', 'Manajemen Informatika', 'D3');
INSERT INTO prodi VALUES ('KA01', 'Komputerisasi Akuntansi', 'D3');
INSERT INTO prodi VALUES ('BD01', 'Bisnis Digital', 'S1');

-- MAHASISWA (29 baris)
INSERT INTO mahasiswa VALUES
  ('2201001', 'Lukman Hakim', 'lukman@kampus.ac.id', 'L', DATE '2004-01-25',
   'TI01', 2022, DATE '2022-08-08', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2201002', 'Maya Putri', 'maya@kampus.ac.id', 'P', DATE '2004-06-11',
   'KA01', 2022, DATE '2022-07-20', 'LULUS');
INSERT INTO mahasiswa VALUES
  ('2201003', 'Nanda Kurniawan', 'nanda@kampus.ac.id', 'L', DATE '2003-11-30',
   'MI01', 2022, DATE '2022-08-16', 'LULUS');
INSERT INTO mahasiswa VALUES
  ('2201004', 'Oktaviani', NULL, 'P', DATE '2004-10-08',
   'SI01', 2022, DATE '2022-08-24', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2301001', 'Andi Pratama', 'andi@kampus.ac.id', 'L', DATE '2005-03-12',
   'TI01', 2023, DATE '2023-07-17', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2301002', 'Siti Rahma', 'siti@kampus.ac.id', 'P', DATE '2005-07-01',
   'SI01', 2023, DATE '2023-07-18', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2301003', 'Putra Wijaya', 'putra@kampus.ac.id', 'L', DATE '2005-02-17',
   'TI01', 2023, DATE '2023-08-02', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2301004', 'Rina Marlina', 'rina@kampus.ac.id', 'P', DATE '2005-09-23',
   'KA01', 2023, DATE '2023-08-09', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2301005', 'Rizky Ramadhan', 'rizky@kampus.ac.id', 'L', DATE '2004-12-05',
   'SI01', 2023, DATE '2023-08-21', 'DO');
INSERT INTO mahasiswa VALUES
  ('2301006', 'Sari Indah', 'sari@kampus.ac.id', 'P', DATE '2005-05-19',
   'MI01', 2023, DATE '2023-08-28', 'CUTI');
INSERT INTO mahasiswa VALUES
  ('2401001', 'Budi Santoso', 'budi@kampus.ac.id', 'L', DATE '2006-08-15',
   'TI01', 2024, DATE '2024-07-15', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2401002', 'Citra Lestari', 'citra.l@kampus.ac.id', 'P', DATE '2006-01-21',
   'SI01', 2024, DATE '2024-07-22', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2401003', 'Dewi Anggraini', 'dewi@kampus.ac.id', 'P', DATE '2006-04-09',
   'MI01', 2024, DATE '2024-07-29', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2401004', 'Eko Saputra', 'eko.s@kampus.ac.id', 'L', DATE '2005-12-30',
   'TI01', 2024, DATE '2024-08-05', 'CUTI');
INSERT INTO mahasiswa VALUES
  ('2401005', 'Taufik Hidayat', 'taufik@kampus.ac.id', 'L', DATE '2006-03-14',
   'SI01', 2024, DATE '2024-08-12', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2401006', 'Umi Kalsum', 'umi@kampus.ac.id', 'P', DATE '2006-07-27',
   'KA01', 2024, DATE '2024-08-19', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2401007', 'Vina Amelia', NULL, 'P', DATE '2006-02-02',
   'TI01', 2024, DATE '2024-08-26', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501001', 'Fajar Nugroho', 'fajar@kampus.ac.id', 'L', DATE '2007-02-14',
   'TI01', 2025, DATE '2025-07-14', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501002', 'Gita Permata', 'gita.pm@kampus.ac.id', 'P', DATE '2007-05-05',
   'SI01', 2025, DATE '2025-07-14', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501003', 'Hana Safitri', 'hana@kampus.ac.id', 'P', DATE '2007-09-17',
   'SI01', 2025, DATE '2025-07-21', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501004', 'Irfan Maulana', 'irfan@kampus.ac.id', 'L', DATE '2006-11-03',
   'MI01', 2025, DATE '2025-07-28', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501005', 'Joko Susilo', 'joko@kampus.ac.id', 'L', DATE '2006-10-10',
   'TI01', 2025, DATE '2025-08-04', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501006', 'Kartika Sari', 'kartika@kampus.ac.id', 'P', DATE '2007-03-03',
   'SI01', 2025, DATE '2025-08-04', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501007', 'Wahyu Setiawan', 'wahyu@kampus.ac.id', 'L', DATE '2007-01-09',
   'KA01', 2025, DATE '2025-08-11', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501008', 'Yuni Astuti', 'yuni@kampus.ac.id', 'P', DATE '2007-08-16',
   'MI01', 2025, DATE '2025-08-18', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2501009', 'Zainal Abidin', 'zainal@kampus.ac.id', 'L', DATE '2006-12-24',
   'TI01', 2025, DATE '2025-08-25', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2601001', 'Agus Salim', 'agus@kampus.ac.id', 'L', DATE '2008-04-04',
   'TI01', 2026, DATE '2026-07-13', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2601002', 'Bella Safira', 'bella@kampus.ac.id', 'P', DATE '2008-06-12',
   'SI01', 2026, DATE '2026-07-20', 'AKTIF');
INSERT INTO mahasiswa VALUES
  ('2601003', 'Candra Wibowo', NULL, 'L', DATE '2007-12-01',
   'KA01', 2026, DATE '2026-08-03', 'AKTIF');

-- MATA_KULIAH (14 baris; BIG01 mata kuliah umum tanpa semester)
INSERT INTO mata_kuliah VALUES ('PTI01', 'Pengantar Teknologi Informasi', 2, 1);
INSERT INTO mata_kuliah VALUES ('ALP01', 'Algoritma dan Pemrograman', 4, 1);
INSERT INTO mata_kuliah VALUES ('MTD01', 'Matematika Diskrit', 3, 1);
INSERT INTO mata_kuliah VALUES ('AKD01', 'Akuntansi Dasar', 3, 1);
INSERT INTO mata_kuliah VALUES ('STA01', 'Statistika', 2, 2);
INSERT INTO mata_kuliah VALUES ('SBD01', 'Sistem Basis Data', 3, 2);
INSERT INTO mata_kuliah VALUES ('PBO01', 'Pemrograman Objek', 3, 3);
INSERT INTO mata_kuliah VALUES ('PWB01', 'Pemrograman Web', 3, 3);
INSERT INTO mata_kuliah VALUES ('MDB01', 'Manajemen Database', 3, 3);
INSERT INTO mata_kuliah VALUES ('JKM01', 'Jaringan Komputer', 2, 4);
INSERT INTO mata_kuliah VALUES ('RPL01', 'Rekayasa Perangkat Lunak', 3, 4);
INSERT INTO mata_kuliah VALUES ('KWU01', 'Kewirausahaan', 2, 5);
INSERT INTO mata_kuliah VALUES ('MPN01', 'Metodologi Penelitian', 2, 6);
INSERT INTO mata_kuliah VALUES ('BIG01', 'Bahasa Inggris', 2, NULL);

-- KRS (151 baris). Tahun ajar 2024/2025 dan 2025/2026 sudah bernilai;
-- 2026/2027 sedang berjalan sehingga nilai_huruf masih NULL.
-- Tahun ajar 2024/2025: 41 baris
INSERT INTO krs VALUES (1, '2201001', 'JKM01', '2024/2025', 'BC');
INSERT INTO krs VALUES (2, '2201001', 'RPL01', '2024/2025', 'BC');
INSERT INTO krs VALUES (3, '2201002', 'JKM01', '2024/2025', 'A');
INSERT INTO krs VALUES (4, '2201002', 'RPL01', '2024/2025', 'B');
INSERT INTO krs VALUES (5, '2201003', 'JKM01', '2024/2025', 'B');
INSERT INTO krs VALUES (6, '2201003', 'RPL01', '2024/2025', 'BC');
INSERT INTO krs VALUES (7, '2201004', 'JKM01', '2024/2025', 'AB');
INSERT INTO krs VALUES (8, '2201004', 'RPL01', '2024/2025', 'AB');
INSERT INTO krs VALUES (9, '2301001', 'SBD01', '2024/2025', 'AB');
INSERT INTO krs VALUES (10, '2301001', 'PBO01', '2024/2025', 'A');
INSERT INTO krs VALUES (11, '2301002', 'SBD01', '2024/2025', 'B');
INSERT INTO krs VALUES (12, '2301002', 'PBO01', '2024/2025', 'B');
INSERT INTO krs VALUES (13, '2301003', 'SBD01', '2024/2025', 'BC');
INSERT INTO krs VALUES (14, '2301003', 'PBO01', '2024/2025', 'B');
INSERT INTO krs VALUES (15, '2301004', 'SBD01', '2024/2025', 'AB');
INSERT INTO krs VALUES (16, '2301004', 'PBO01', '2024/2025', 'AB');
INSERT INTO krs VALUES (17, '2301005', 'SBD01', '2024/2025', 'E');
INSERT INTO krs VALUES (18, '2301005', 'PBO01', '2024/2025', 'E');
INSERT INTO krs VALUES (19, '2301006', 'SBD01', '2024/2025', 'BC');
INSERT INTO krs VALUES (20, '2301006', 'PBO01', '2024/2025', 'B');
INSERT INTO krs VALUES (21, '2401001', 'PTI01', '2024/2025', 'AB');
INSERT INTO krs VALUES (22, '2401001', 'ALP01', '2024/2025', 'AB');
INSERT INTO krs VALUES (23, '2401001', 'MTD01', '2024/2025', 'BC');
INSERT INTO krs VALUES (24, '2401002', 'PTI01', '2024/2025', 'AB');
INSERT INTO krs VALUES (25, '2401002', 'ALP01', '2024/2025', 'BC');
INSERT INTO krs VALUES (26, '2401002', 'MTD01', '2024/2025', 'BC');
INSERT INTO krs VALUES (27, '2401003', 'PTI01', '2024/2025', 'AB');
INSERT INTO krs VALUES (28, '2401003', 'ALP01', '2024/2025', 'B');
INSERT INTO krs VALUES (29, '2401003', 'MTD01', '2024/2025', 'B');
INSERT INTO krs VALUES (30, '2401004', 'PTI01', '2024/2025', 'AB');
INSERT INTO krs VALUES (31, '2401004', 'ALP01', '2024/2025', 'BC');
INSERT INTO krs VALUES (32, '2401004', 'MTD01', '2024/2025', 'BC');
INSERT INTO krs VALUES (33, '2401005', 'PTI01', '2024/2025', 'AB');
INSERT INTO krs VALUES (34, '2401005', 'ALP01', '2024/2025', 'B');
INSERT INTO krs VALUES (35, '2401005', 'MTD01', '2024/2025', 'BC');
INSERT INTO krs VALUES (36, '2401006', 'PTI01', '2024/2025', 'A');
INSERT INTO krs VALUES (37, '2401006', 'MTD01', '2024/2025', 'B');
INSERT INTO krs VALUES (38, '2401006', 'AKD01', '2024/2025', 'AB');
INSERT INTO krs VALUES (39, '2401007', 'PTI01', '2024/2025', 'B');
INSERT INTO krs VALUES (40, '2401007', 'ALP01', '2024/2025', 'BC');
INSERT INTO krs VALUES (41, '2401007', 'MTD01', '2024/2025', 'D');
-- Tahun ajar 2025/2026: 59 baris
INSERT INTO krs VALUES (42, '2201001', 'KWU01', '2025/2026', 'B');
INSERT INTO krs VALUES (43, '2201001', 'MPN01', '2025/2026', 'BC');
INSERT INTO krs VALUES (44, '2201002', 'KWU01', '2025/2026', 'A');
INSERT INTO krs VALUES (45, '2201002', 'MPN01', '2025/2026', 'A');
INSERT INTO krs VALUES (46, '2201003', 'KWU01', '2025/2026', 'AB');
INSERT INTO krs VALUES (47, '2201003', 'MPN01', '2025/2026', 'B');
INSERT INTO krs VALUES (48, '2201004', 'KWU01', '2025/2026', 'A');
INSERT INTO krs VALUES (49, '2201004', 'MPN01', '2025/2026', 'AB');
INSERT INTO krs VALUES (50, '2301001', 'JKM01', '2025/2026', 'AB');
INSERT INTO krs VALUES (51, '2301001', 'RPL01', '2025/2026', 'A');
INSERT INTO krs VALUES (52, '2301002', 'JKM01', '2025/2026', 'AB');
INSERT INTO krs VALUES (53, '2301002', 'RPL01', '2025/2026', 'AB');
INSERT INTO krs VALUES (54, '2301003', 'JKM01', '2025/2026', 'B');
INSERT INTO krs VALUES (55, '2301003', 'RPL01', '2025/2026', 'BC');
INSERT INTO krs VALUES (56, '2301004', 'JKM01', '2025/2026', 'B');
INSERT INTO krs VALUES (57, '2301004', 'RPL01', '2025/2026', 'AB');
INSERT INTO krs VALUES (58, '2301006', 'JKM01', '2025/2026', 'B');
INSERT INTO krs VALUES (59, '2301006', 'RPL01', '2025/2026', 'AB');
INSERT INTO krs VALUES (60, '2401001', 'SBD01', '2025/2026', 'A');
INSERT INTO krs VALUES (61, '2401001', 'PBO01', '2025/2026', 'B');
INSERT INTO krs VALUES (62, '2401002', 'SBD01', '2025/2026', 'B');
INSERT INTO krs VALUES (63, '2401002', 'PBO01', '2025/2026', 'B');
INSERT INTO krs VALUES (64, '2401003', 'SBD01', '2025/2026', 'AB');
INSERT INTO krs VALUES (65, '2401003', 'PBO01', '2025/2026', 'AB');
INSERT INTO krs VALUES (66, '2401004', 'SBD01', '2025/2026', 'BC');
INSERT INTO krs VALUES (67, '2401004', 'PBO01', '2025/2026', 'B');
INSERT INTO krs VALUES (68, '2401005', 'SBD01', '2025/2026', 'B');
INSERT INTO krs VALUES (69, '2401005', 'PBO01', '2025/2026', 'AB');
INSERT INTO krs VALUES (70, '2401006', 'SBD01', '2025/2026', 'A');
INSERT INTO krs VALUES (71, '2401006', 'PBO01', '2025/2026', 'A');
INSERT INTO krs VALUES (72, '2401007', 'SBD01', '2025/2026', 'C');
INSERT INTO krs VALUES (73, '2401007', 'PBO01', '2025/2026', 'BC');
INSERT INTO krs VALUES (74, '2501001', 'PTI01', '2025/2026', 'B');
INSERT INTO krs VALUES (75, '2501001', 'ALP01', '2025/2026', 'C');
INSERT INTO krs VALUES (76, '2501001', 'MTD01', '2025/2026', 'D');
INSERT INTO krs VALUES (77, '2501002', 'PTI01', '2025/2026', 'BC');
INSERT INTO krs VALUES (78, '2501002', 'ALP01', '2025/2026', 'C');
INSERT INTO krs VALUES (79, '2501002', 'MTD01', '2025/2026', 'D');
INSERT INTO krs VALUES (80, '2501003', 'PTI01', '2025/2026', 'B');
INSERT INTO krs VALUES (81, '2501003', 'ALP01', '2025/2026', 'C');
INSERT INTO krs VALUES (82, '2501003', 'MTD01', '2025/2026', 'D');
INSERT INTO krs VALUES (83, '2501004', 'PTI01', '2025/2026', 'A');
INSERT INTO krs VALUES (84, '2501004', 'ALP01', '2025/2026', 'AB');
INSERT INTO krs VALUES (85, '2501004', 'MTD01', '2025/2026', 'BC');
INSERT INTO krs VALUES (86, '2501005', 'PTI01', '2025/2026', 'AB');
INSERT INTO krs VALUES (87, '2501005', 'ALP01', '2025/2026', 'B');
INSERT INTO krs VALUES (88, '2501005', 'MTD01', '2025/2026', 'C');
INSERT INTO krs VALUES (89, '2501006', 'PTI01', '2025/2026', 'A');
INSERT INTO krs VALUES (90, '2501006', 'ALP01', '2025/2026', 'A');
INSERT INTO krs VALUES (91, '2501006', 'MTD01', '2025/2026', 'AB');
INSERT INTO krs VALUES (92, '2501007', 'PTI01', '2025/2026', 'AB');
INSERT INTO krs VALUES (93, '2501007', 'MTD01', '2025/2026', 'C');
INSERT INTO krs VALUES (94, '2501007', 'AKD01', '2025/2026', 'B');
INSERT INTO krs VALUES (95, '2501008', 'PTI01', '2025/2026', 'AB');
INSERT INTO krs VALUES (96, '2501008', 'ALP01', '2025/2026', 'B');
INSERT INTO krs VALUES (97, '2501008', 'MTD01', '2025/2026', 'BC');
INSERT INTO krs VALUES (98, '2501009', 'PTI01', '2025/2026', 'C');
INSERT INTO krs VALUES (99, '2501009', 'ALP01', '2025/2026', 'D');
INSERT INTO krs VALUES (100, '2501009', 'MTD01', '2025/2026', 'D');
-- Tahun ajar 2026/2027: 51 baris
INSERT INTO krs VALUES (101, '2201001', 'MDB01', '2026/2027', NULL);
INSERT INTO krs VALUES (102, '2201001', 'BIG01', '2026/2027', NULL);
INSERT INTO krs VALUES (103, '2201004', 'MDB01', '2026/2027', NULL);
INSERT INTO krs VALUES (104, '2201004', 'BIG01', '2026/2027', NULL);
INSERT INTO krs VALUES (105, '2301001', 'MDB01', '2026/2027', NULL);
INSERT INTO krs VALUES (106, '2301001', 'KWU01', '2026/2027', NULL);
INSERT INTO krs VALUES (107, '2301002', 'MDB01', '2026/2027', NULL);
INSERT INTO krs VALUES (108, '2301002', 'KWU01', '2026/2027', NULL);
INSERT INTO krs VALUES (109, '2301003', 'MDB01', '2026/2027', NULL);
INSERT INTO krs VALUES (110, '2301003', 'KWU01', '2026/2027', NULL);
INSERT INTO krs VALUES (111, '2301004', 'MDB01', '2026/2027', NULL);
INSERT INTO krs VALUES (112, '2301004', 'KWU01', '2026/2027', NULL);
INSERT INTO krs VALUES (113, '2401001', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (114, '2401001', 'JKM01', '2026/2027', NULL);
INSERT INTO krs VALUES (115, '2401002', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (116, '2401002', 'JKM01', '2026/2027', NULL);
INSERT INTO krs VALUES (117, '2401003', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (118, '2401003', 'JKM01', '2026/2027', NULL);
INSERT INTO krs VALUES (119, '2401005', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (120, '2401005', 'JKM01', '2026/2027', NULL);
INSERT INTO krs VALUES (121, '2401006', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (122, '2401006', 'JKM01', '2026/2027', NULL);
INSERT INTO krs VALUES (123, '2401007', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (124, '2401007', 'JKM01', '2026/2027', NULL);
INSERT INTO krs VALUES (125, '2501001', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (126, '2501001', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (127, '2501002', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (128, '2501002', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (129, '2501003', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (130, '2501003', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (131, '2501004', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (132, '2501004', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (133, '2501005', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (134, '2501005', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (135, '2501006', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (136, '2501006', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (137, '2501007', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (138, '2501007', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (139, '2501008', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (140, '2501008', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (141, '2501009', 'SBD01', '2026/2027', NULL);
INSERT INTO krs VALUES (142, '2501009', 'PWB01', '2026/2027', NULL);
INSERT INTO krs VALUES (143, '2601001', 'PTI01', '2026/2027', NULL);
INSERT INTO krs VALUES (144, '2601001', 'ALP01', '2026/2027', NULL);
INSERT INTO krs VALUES (145, '2601001', 'MTD01', '2026/2027', NULL);
INSERT INTO krs VALUES (146, '2601002', 'PTI01', '2026/2027', NULL);
INSERT INTO krs VALUES (147, '2601002', 'ALP01', '2026/2027', NULL);
INSERT INTO krs VALUES (148, '2601002', 'MTD01', '2026/2027', NULL);
INSERT INTO krs VALUES (149, '2601003', 'PTI01', '2026/2027', NULL);
INSERT INTO krs VALUES (150, '2601003', 'MTD01', '2026/2027', NULL);
INSERT INTO krs VALUES (151, '2601003', 'AKD01', '2026/2027', NULL);

COMMIT;

PROMPT Membuat sequence seq_krs dan trigger trg_krs_bi untuk id_krs berikutnya ...
CREATE SEQUENCE seq_krs START WITH 152 INCREMENT BY 1 NOCACHE;

CREATE OR REPLACE TRIGGER trg_krs_bi
BEFORE INSERT ON krs
FOR EACH ROW
BEGIN
  IF :NEW.id_krs IS NULL THEN
    :NEW.id_krs := seq_krs.NEXTVAL;
  END IF;
END;
/

-- Jika sequence atau trigger gagal dibuat, trigger yang tidak valid dihapus
-- agar tidak menghalangi INSERT berikutnya, lalu ditampilkan petunjuk GRANT.
SET SERVEROUTPUT ON
DECLARE
  n NUMBER;
BEGIN
  SELECT COUNT(*) INTO n FROM user_objects
   WHERE object_name IN ('SEQ_KRS', 'TRG_KRS_BI') AND status = 'VALID';
  IF n < 2 THEN
    FOR t IN (SELECT trigger_name FROM user_triggers
               WHERE trigger_name = 'TRG_KRS_BI') LOOP
      EXECUTE IMMEDIATE 'DROP TRIGGER trg_krs_bi';
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('PERHATIAN: seq_krs/trg_krs_bi gagal dibuat.');
    DBMS_OUTPUT.PUT_LINE('Data tetap lengkap. Agar id_krs terisi otomatis,');
    DBMS_OUTPUT.PUT_LINE('login sebagai SYSTEM dan jalankan:');
    DBMS_OUTPUT.PUT_LINE('  GRANT CREATE SEQUENCE, CREATE TRIGGER TO praktikum;');
    DBMS_OUTPUT.PUT_LINE('lalu jalankan ulang skrip ini sebagai PRAKTIKUM.');
  END IF;
END;
/
SET SERVEROUTPUT OFF
SET FEEDBACK 6
SET DEFINE ON

PROMPT Data siap. Jumlah baris setiap tabel:
SELECT (SELECT COUNT(*) FROM prodi)       AS jml_prodi,
       (SELECT COUNT(*) FROM mahasiswa)   AS jml_mhs,
       (SELECT COUNT(*) FROM mata_kuliah) AS jml_mk,
       (SELECT COUNT(*) FROM krs)         AS jml_krs
  FROM dual;
