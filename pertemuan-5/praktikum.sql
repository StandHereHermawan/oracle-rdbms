docker exec -it oracle-db-a1016-container sqlplus praktikum/Praktikum123@localhost:1521/FREEPDB1

CONNECT praktikum/Praktikum123@localhost:1521/FREEPDB1;

COLUMN OBJECT_NAME FORMAT A12;

SELECT OBJECT_NAME, OBJECT_ID, OBJECT_TYPE, CREATED, LAST_DDL_TIME, TIMESTAMP FROM user_objects;
SELECT OBJECT_NAME FROM user_objects;
SELECT OBJECT_NAME, OBJECT_TYPE, CREATED FROM user_objects where  OBJECT_TYPE = 'TABLE';

-- Bagian 4: Mengedit Struktur Tabel
-- Langkah 4.1 Menambah kolom
-- Perintah
ALTER TABLE IF EXISTS mahasiswa ADD (no_hp VARCHAR2(15));
ALTER TABLE IF EXISTS mahasiswa ADD (
    alamat VARCHAR2(200),
    status VARCHAR2(10) DEFAULT 'AKTIF' NOT NULL
);
COLUMN alamat FORMAT A20; \n
COLUMN nama FORMAT A12; \n
COLUMN email FORMAT A12; \n

SELECT nim, nama, status FROM mahasiswa;
SELECT * FROM mahasiswa;

-- Langkah 4.2 Mengubah tipe data, ukuran, default, dan NOT NULL
-- Perintah
ALTER TABLE mahasiswa MODIFY (nama VARCHAR2(150)); -- memperbesar
ALTER TABLE mahasiswa MODIFY (nama VARCHAR2(5)); -- memperkecil

-- Contoh keluaran
-- Table altered.
-- ALTER TABLE mahasiswa MODIFY (nama VARCHAR2(5))
--  *
-- ERROR at line 1:
-- ORA-01441: cannot decrease column length because some value is too big

-- Ukuran kolom tidak dapat diperkecil di bawah panjang data yang sudah ada ("Andi Pratama" berisi
-- 12 karakter). Lanjutkan dengan mengubah default dan menambah NOT NULL:

-- Langkah 4.3 Mengganti nama kolom
-- Perintah
ALTER TABLE mahasiswa RENAME COLUMN no_hp TO telepon;

-- Contoh keluaran
-- Table altered.

-- Seremoni Khusus Praktik di docker dan linux
docker exec -it oracle-db-a1016-container sh

mkdir manajemen-administrasi-rdbms-oracle

docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-5/persiapan_praktikum_group_by_11g.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle

@/opt/oracle/manajemen-administrasi-rdbms-oracle/persiapan_praktikum_group_by_11g.sql

-- Bagian 1: Persiapan
-- Langkah 1.1 Masuk sebagai PRAKTIKUM dan mengatur tampilan
-- Nyalakan database (Windows: layanan OracleServiceXE; container: docker start <nama-container>), buka SQL*Plus, lalu jalankan:
SHOW USER
SET LINESIZE 120
SET PAGESIZE 100
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
COLUMN nama FORMAT A16
COLUMN email FORMAT A22
COLUMN nama_prodi FORMAT A24
COLUMN nama_mk FORMAT A30
COLUMN tahun_ajar FORMAT A10
COLUMN nilai_huruf FORMAT A11
SPOOL praktikum_groupby_<NIM>.txt


-- Langkah 1.2 Menjalankan skrip data
-- Simpan berkas persiapan_praktikum_group_by_11g.sql (dibagikan oleh dosen/asisten; isi lengkapnya ada di Lampiran A) di folder tempat Anda menjalankan SQL*Plus, lalu jalankan:
-- Perintah khusus praktek di linux
@/opt/oracle/manajemen-administrasi-rdbms-oracle/persiapan_praktikum_group_by_11g.sql

-- Contoh keluaran
-- Menghapus tabel lama ...
-- Membuat tabel ...
-- Mengisi data ...
-- Data siap. Jumlah baris setiap tabel:
 
--  JML_PRODI    JML_MHS     JML_MK    JML_KRS
-- ---------- ---------- ---------- ----------
--          5         29         14        151

-- Perhatian
-- Skrip menghapus lalu membuat ulang tabel PRODI, MAHASISWA, MATA_KULIAH, dan KRS. 
-- Data yang pernah Anda masukkan ke tabel tersebut pada modul sebelumnya akan diganti dengan data contoh modul ini.
-- Jika muncul ORA-01031: insufficient privileges, user PRAKTIKUM belum memiliki privilege CREATE SEQUENCE atau CREATE TRIGGER. 
-- Masuk sebagai SYSTEM lalu jalankan GRANT CREATE SEQUENCE, CREATE TRIGGER TO praktikum;.

-- Langkah 1.3 Melihat data referensi
-- Perintah
SELECT * FROM prodi ORDER BY kode_prodi;
SELECT * FROM mata_kuliah ORDER BY kode_mk;

-- Bagian 2: Kriteria Data dengan WHERE
-- Langkah 2.1 Operator perbandingan
-- Tampilkan mahasiswa angkatan 2025 ke atas, kemudian mahasiswa yang statusnya bukan AKTIF:
-- Perintah
SHOW USER
SET LINESIZE 120
SET PAGESIZE 100
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

COLUMN nama FORMAT A16

SELECT nim, nama, kode_prodi, angkatan
       FROM mahasiswa
      WHERE angkatan >= 2025;
SELECT nim, nama, angkatan, status
       FROM mahasiswa
      WHERE status <> 'AKTIF';


-- Bagian 5: Pengelompokan Data dengan GROUP BY
-- Langkah 5.1 Dari satu angka menjadi angka per kelompok
-- Langkah 4.1 menghasilkan satu angka untuk seluruh tabel. Bagaimana jika yang dibutuhkan adalah jumlah mahasiswa per prodi? Coba dulu tanpa GROUP BY:
-- Perintah
SELECT kode_prodi, COUNT(*) AS jml_mhs FROM mahasiswa;

-- Contoh keluaran
-- SELECT kode_prodi, COUNT(*) AS jml_mhs FROM mahasiswa
--        *
-- ERROR at line 1:
-- ORA-00937: not a single-group group function
-- Error ORA-00937 muncul karena Oracle diminta menampilkan banyak nilai kode_prodi sekaligus satu hasil COUNT untuk seluruh tabel. 
-- Tambahkan GROUP BY agar COUNT dihitung per prodi:
-- Perintah
SELECT kode_prodi, COUNT(*) AS jml_mhs
       FROM mahasiswa
      GROUP BY kode_prodi
      ORDER BY kode_prodi;
      Contoh keluaran
-- KODE    JML_MHS
-- ---- ----------
-- KA01          5
-- MI01          5
-- SI01          9
-- TI01         10

-- Langkah 5.2 Mengelompokkan dengan beberapa kolom
-- Perintah
COLUMN jk FORMAT A2
SELECT kode_prodi, jenis_kelamin AS jk, COUNT(*) AS jml_mhs
       FROM mahasiswa
      GROUP BY kode_prodi, jenis_kelamin
      ORDER BY kode_prodi, jk;
-- Contoh keluaran
-- KODE JK    JML_MHS
-- ---- -- ----------
-- KA01 L           2
-- KA01 P           3
-- MI01 L           2
-- MI01 P           3
-- SI01 L           2
-- SI01 P           7
-- TI01 L           9
-- TI01 P           1
--  
-- 8 rows selected.


-- Langkah 6.1 Menyaring kelompok
-- Tampilkan prodi yang memiliki minimal 5 mahasiswa aktif:
-- Perintah
SELECT kode_prodi, COUNT(*) AS jml_aktif
       FROM mahasiswa
      WHERE status = 'AKTIF'
      GROUP BY kode_prodi
     HAVING COUNT(*) >= 5
      ORDER BY jml_aktif DESC;



