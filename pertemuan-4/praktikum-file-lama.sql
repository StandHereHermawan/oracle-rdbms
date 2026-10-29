docker exec -it oracle-db-a1016-container sqlplus praktikum/Praktikum123@localhost:1521/FREEPDB1

CONNECT praktikum/Praktikum123@localhost:1521/FREEPDB1;

SELECT COUNT(*) FROM user_objects;

-- Langkah 6: Membuat Tabel JURUSAN (CREATE TABLE)
-- 1. Buat tabel JURUSAN dengan PRIMARY KEY dan NOT NULL:
CREATE TABLE jurusan (
    kode_jurusan VARCHAR2(5) PRIMARY KEY,
    nama_jurusan VARCHAR2(50) NOT NULL
);

-- 2. Lihat struktur tabel yang baru dibuat:
DESC jurusan;
-- Hasil yang diharapkan: Muncul pesan "Table created." dan DESC menampilkan 2 kolom beserta
-- tipe datanya.


-- Langkah 7: Membuat Tabel MAHASISWA dengan Constraint
-- 1. Buat tabel MAHASISWA lengkap dengan constraint bernama (named constraint):
CREATE TABLE mahasiswa (
    nim VARCHAR2(10),
    nama VARCHAR2(50) NOT NULL,
    tgl_lahir DATE,
    ipk NUMBER(3,2) DEFAULT 0,
    kode_jurusan VARCHAR2(5),
    CONSTRAINT pk_mahasiswa PRIMARY KEY (nim),
    CONSTRAINT fk_mhs_jurusan FOREIGN KEY (kode_jurusan)
    REFERENCES jurusan (kode_jurusan),
    CONSTRAINT ck_ipk CHECK (ipk BETWEEN 0 AND 4)
);
-- 2. Tampilkan strukturnya:
DESC mahasiswa;
