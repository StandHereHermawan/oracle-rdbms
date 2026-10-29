docker exec -it oracle-db-a1016-container sqlplus praktikum/Praktikum123@localhost:1521/FREEPDB1

CONNECT praktikum/Praktikum123@localhost:1521/FREEPDB1;

desc user_objects;
-- keluaran
 -- Name                                      Null?    Type
 -- ----------------------------------------- -------- ----------------------------
 -- OBJECT_NAME                                        VARCHAR2(128)
 -- SUBOBJECT_NAME                                     VARCHAR2(128)
 -- OBJECT_ID                                          NUMBER
 -- DATA_OBJECT_ID                                     NUMBER
 -- OBJECT_TYPE                                        VARCHAR2(23)
 -- CREATED                                            DATE
 -- LAST_DDL_TIME                                      DATE
 -- TIMESTAMP                                          VARCHAR2(19)
 -- STATUS                                             VARCHAR2(7)
 -- TEMPORARY                                          VARCHAR2(1)
 -- GENERATED                                          VARCHAR2(1)
 -- SECONDARY                                          VARCHAR2(1)
 -- NAMESPACE                                          NUMBER
 -- EDITION_NAME                                       VARCHAR2(128)
 -- SHARING                                            VARCHAR2(18)
 -- EDITIONABLE                                        VARCHAR2(1)
 -- ORACLE_MAINTAINED                                  VARCHAR2(1)
 -- APPLICATION                                        VARCHAR2(1)
 -- DEFAULT_COLLATION                                  VARCHAR2(100)
 -- DUPLICATED                                         VARCHAR2(1)
 -- SHARDED                                            VARCHAR2(1)
 -- IMPORTED_OBJECT                                    VARCHAR2(1)
 -- SYNCHRONOUS_DUPLICATED                             VARCHAR2(1)
 -- CREATED_APPID                                      NUMBER
 -- CREATED_VSNID                                      NUMBER
 -- MODIFIED_APPID                                     NUMBER
 -- MODIFIED_VSNID                                     NUMBER

SELECT OBJECT_NAME, OBJECT_ID, OBJECT_TYPE, CREATED, LAST_DDL_TIME, TIMESTAMP FROM user_objects;
SELECT OBJECT_NAME FROM user_objects;
SELECT OBJECT_NAME, OBJECT_TYPE, CREATED FROM user_objects where  OBJECT_TYPE = 'TABLE';




-- Langkah 3.2 Membuat tabel PRODI (constraint di level kolom)
-- Perintah
-- 3. Membuat tabel prodi
CREATE TABLE prodi (
    kode_prodi  char(4)                     CONSTRAINT      pk_prodi        PRIMARY KEY,
    nama_prodi  VARCHAR2(60)                NOT     NULL,
    jenjang     VARCHAR2(5) DEFAULT 'S1'    CONSTRAINT      ck_prodi_jenjang CHECK (jenjang in ('D3','S1','S2','S3')));

DESC prodi; 
DESCRIBE prodi;


-- Langkah 3.3 Membuat tabel MAHASISWA (dengan FOREIGN KEY)
-- Perintah
CREATE TABLE mahasiswa (
    nim VARCHAR2(10) CONSTRAINT pk_mahasiswa PRIMARY KEY,
    nama VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) CONSTRAINT uq_mhs_email UNIQUE,
    jenis_kelamin CHAR(1) CONSTRAINT ck_mhs_jk CHECK (jenis_kelamin IN ('L','P')),
    tgl_lahir DATE,
    kode_prodi CHAR(4) CONSTRAINT fk_mhs_prodi REFERENCES prodi (kode_prodi),
    angkatan NUMBER(4),
    tgl_daftar DATE DEFAULT SYSDATE
);
-- Contoh keluaran
-- Table created.
 
 -- 2. Tampilkan strukturnya:
DESC mahasiswa;


-- Langkah 3.4 Membuat tabel MATA_KULIAH
-- Perintah
CREATE TABLE mata_kuliah (
    kode_mk VARCHAR2(8) CONSTRAINT pk_mata_kuliah PRIMARY KEY,
    nama_mk VARCHAR2(80) NOT NULL,
    sks NUMBER(1) NOT NULL
    CONSTRAINT ck_mk_sks CHECK (sks BETWEEN 1 AND 6),
    semester NUMBER(1)
);
-- Contoh keluaran
-- Table created.
--
-- Tampilkan strukturnya:
DESC mata_kuliah;


-- Langkah 3.5 Membuat tabel KRS (constraint di level tabel dan kolom identitas)
-- Perintah
CREATE TABLE krs (
    id_krs NUMBER GENERATED ALWAYS AS IDENTITY,
    nim VARCHAR2(10) NOT NULL,
    kode_mk VARCHAR2(8) NOT NULL,
    tahun_ajar VARCHAR2(9) NOT NULL,
    nilai_huruf VARCHAR2(2),
    CONSTRAINT pk_krs PRIMARY KEY (id_krs),
    CONSTRAINT fk_krs_mhs FOREIGN KEY (nim) REFERENCES mahasiswa (nim) ON DELETE CASCADE,
    CONSTRAINT fk_krs_mk FOREIGN KEY (kode_mk) REFERENCES mata_kuliah (kode_mk),
    CONSTRAINT uq_krs UNIQUE (nim, kode_mk, tahun_ajar)
);
-- Contoh keluaran
-- Table created.
--
-- Tampilkan strukturnya:
DESC krs;

-- •    GENERATED ALWAYS AS IDENTITY membuat nomor urut otomatis 1, 2, 3, dan seterusnya.
-- •    ON DELETE CASCADE berarti jika seorang mahasiswa dihapus, semua baris KRS miliknya ikut
--      terhapus.
-- •    uq_krs mencegah mahasiswa mengambil mata kuliah yang sama dua kali pada tahun ajaran
--      yang sama.



-- Langkah 3.6 Memverifikasi tabel dan constraint
-- Perintah
SELECT table_name, tablespace_name FROM user_tables ORDER BY table_name;

DESCRIBE user_tables;
-- SQL> DESCRIBE user_tables;
--  Name                                      Null?    Type
--  ----------------------------------------- -------- ----------------------------
--  TABLE_NAME                                NOT NULL VARCHAR2(128)
--  TABLESPACE_NAME                                    VARCHAR2(30)
--  CLUSTER_NAME                                       VARCHAR2(128)
--  IOT_NAME                                           VARCHAR2(128)
--  STATUS                                             VARCHAR2(8)
--  PCT_FREE                                           NUMBER
--  PCT_USED                                           NUMBER
--  INI_TRANS                                          NUMBER
--  MAX_TRANS                                          NUMBER
--  INITIAL_EXTENT                                     NUMBER
--  NEXT_EXTENT                                        NUMBER
--  MIN_EXTENTS                                        NUMBER
--  MAX_EXTENTS                                        NUMBER
--  PCT_INCREASE                                       NUMBER
--  FREELISTS                                          NUMBER
--  FREELIST_GROUPS                                    NUMBER
--  LOGGING                                            VARCHAR2(3)
--  BACKED_UP                                          VARCHAR2(1)
--  NUM_ROWS                                           NUMBER
--  BLOCKS                                             NUMBER
--  EMPTY_BLOCKS                                       NUMBER
--  AVG_SPACE                                          NUMBER
--  CHAIN_CNT                                          NUMBER
--  AVG_ROW_LEN                                        NUMBER
--  AVG_SPACE_FREELIST_BLOCKS                          NUMBER
--  NUM_FREELIST_BLOCKS                                NUMBER
--  DEGREE                                             VARCHAR2(10)
--  INSTANCES                                          VARCHAR2(10)
--  CACHE                                              VARCHAR2(5)
--  TABLE_LOCK                                         VARCHAR2(8)
--  SAMPLE_SIZE                                        NUMBER
--  LAST_ANALYZED                                      DATE
--  PARTITIONED                                        VARCHAR2(3)
--  IOT_TYPE                                           VARCHAR2(12)
--  TEMPORARY                                          VARCHAR2(1)
--  SECONDARY                                          VARCHAR2(1)
--  NESTED                                             VARCHAR2(3)
--  BUFFER_POOL                                        VARCHAR2(7)
--  FLASH_CACHE                                        VARCHAR2(7)
--  CELL_FLASH_CACHE                                   VARCHAR2(7)
--  ROW_MOVEMENT                                       VARCHAR2(8)
--  GLOBAL_STATS                                       VARCHAR2(3)
--  USER_STATS                                         VARCHAR2(3)
--  DURATION                                           VARCHAR2(15)
--  SKIP_CORRUPT                                       VARCHAR2(8)
--  MONITORING                                         VARCHAR2(3)
--  CLUSTER_OWNER                                      VARCHAR2(128)
--  DEPENDENCIES                                       VARCHAR2(8)
--  COMPRESSION                                        VARCHAR2(8)
--  COMPRESS_FOR                                       VARCHAR2(30)
--  DROPPED                                            VARCHAR2(3)
--  READ_ONLY                                          VARCHAR2(3)
--  SEGMENT_CREATED                                    VARCHAR2(3)
--  RESULT_CACHE                                       VARCHAR2(7)
--  CLUSTERING                                         VARCHAR2(3)
--  ACTIVITY_TRACKING                                  VARCHAR2(23)
--  DML_TIMESTAMP                                      VARCHAR2(25)
--  HAS_IDENTITY                                       VARCHAR2(3)
--  CONTAINER_DATA                                     VARCHAR2(3)
--  INMEMORY                                           VARCHAR2(8)
--  INMEMORY_PRIORITY                                  VARCHAR2(8)
--  INMEMORY_DISTRIBUTE                                VARCHAR2(15)
--  INMEMORY_COMPRESSION                               VARCHAR2(17)
--  INMEMORY_DUPLICATE                                 VARCHAR2(13)
--  DEFAULT_COLLATION                                  VARCHAR2(100)
--  DUPLICATED                                         VARCHAR2(1)
--  SYNCHRONOUS_DUPLICATED                             VARCHAR2(1)
--  SHARDED                                            VARCHAR2(1)
--  EXTERNALLY_SHARDED                                 VARCHAR2(1)
--  EXTERNALLY_DUPLICATED                              VARCHAR2(1)
--  EXTERNAL                                           VARCHAR2(3)
--  HYBRID                                             VARCHAR2(3)
--  CELLMEMORY                                         VARCHAR2(24)
--  CONTAINERS_DEFAULT                                 VARCHAR2(3)
--  CONTAINER_MAP                                      VARCHAR2(3)
--  EXTENDED_DATA_LINK                                 VARCHAR2(3)
--  EXTENDED_DATA_LINK_MAP                             VARCHAR2(3)
--  INMEMORY_SERVICE                                   VARCHAR2(12)
--  INMEMORY_SERVICE_NAME                              VARCHAR2(1000)
--  CONTAINER_MAP_OBJECT                               VARCHAR2(3)
--  MEMOPTIMIZE_READ                                   VARCHAR2(8)
--  MEMOPTIMIZE_WRITE                                  VARCHAR2(8)
--  HAS_SENSITIVE_COLUMN                               VARCHAR2(3)
--  ADMIT_NULL                                         VARCHAR2(3)
--  DATA_LINK_DML_ENABLED                              VARCHAR2(3)
--  LOGICAL_REPLICATION                                VARCHAR2(8)
--  STAGING                                            VARCHAR2(3)
--  ROW_CHANGE_TRACKING                                VARCHAR2(3)
--  HAS_RESERVABLE_COLUMN                              VARCHAR2(3)
--  VECTOR_INDEX_TYPE                                  VARCHAR2(28)

COLUMN table_name FORMAT A12;
COLUMN constraint_name FORMAT A20;

SELECT table_name, constraint_name, constraint_type, status FROM user_constraints ORDER BY table_name, constraint_type;

-- Langkah 3.7 Menguji constraint dengan data contoh
-- Masukkan data yang valid terlebih dahulu:
-- Perintah
INSERT INTO prodi VALUES ('TI01', 'Teknik Informatika', 'S1');
INSERT INTO prodi (kode_prodi, nama_prodi) VALUES ('SI01', 'Sistem Informasi');
INSERT INTO mahasiswa (nim, nama, email, jenis_kelamin, tgl_lahir, kode_prodi, angkatan) VALUES ('2301001', 'Andi Pratama', 'andi@kampus.ac.id', 'L', DATE '2005-03-12', 'TI01', 2023);
INSERT INTO mahasiswa (nim, nama, email, jenis_kelamin, tgl_lahir, kode_prodi, angkatan) VALUES ('2301002', 'Siti Rahma', 'siti@kampus.ac.id', 'P', DATE '2005-07-01', 'SI01', 2023);
INSERT INTO mata_kuliah VALUES ('MDB01', 'Manajemen Database', 3, 3);
INSERT INTO krs (nim, kode_mk, tahun_ajar) VALUES ('2301001', 'MDB01', '2026/2027');

COMMIT;

SELECT * FROM prodi;
SELECT id_krs, nim, kode_mk, tahun_ajar FROM krs;

COLUMN nama FORMAT A12;
COLUMN email FORMAT A12;
SELECT * FROM mahasiswa;

-- Prodi SI01 otomatis berjenjang S1 karena nilai DEFAULT, dan id_krs terisi 1 secara otomatis.
-- Sekarang coba data yang melanggar constraint satu per satu dan amati pesan errornya:
-- Perintah
INSERT INTO mahasiswa (nim, nama, jenis_kelamin) VALUES ('2301003', 'Budi', 'X');
INSERT INTO mahasiswa (nim, nama, kode_prodi) VALUES ('2301004', 'Citra', 'XX99');
INSERT INTO mahasiswa (nim, nama) VALUES ('2301001', 'Duplikat');
INSERT INTO mahasiswa (nim) VALUES ('2301005');
INSERT INTO krs (id_krs, nim, kode_mk, tahun_ajar) VALUES (99, '2301002', 'MDB01', '2026/2027');
-- Contoh keluaran
-- ORA-02290: check constraint (PRAKTIKUM.CK_MHS_JK) violated
-- ORA-02291: integrity constraint (PRAKTIKUM.FK_MHS_PRODI) violated - parent key not found
-- ORA-00001: unique constraint (PRAKTIKUM.PK_MAHASISWA) violated on table PRAKTIKUM.MAHASISWA columns (NIM)
-- ORA-01400: cannot insert NULL into ("PRAKTIKUM"."MAHASISWA"."NAMA")
-- ORA-32795: cannot insert into a generated always identity column



-- Bagian 4: Mengedit Struktur Tabel
-- Langkah 4.1 Menambah kolom
-- Perintah
ALTER TABLE mahasiswa ADD (no_hp VARCHAR2(15));
ALTER TABLE mahasiswa ADD (
    alamat VARCHAR2(200),
    status VARCHAR2(10) DEFAULT 'AKTIF' NOT NULL
);
COLUMN alamat FORMAT A20; \n
COLUMN nama FORMAT A12; \n
COLUMN email FORMAT A12; \n

SELECT nim, nama, status FROM mahasiswa;
SELECT * FROM mahasiswa;