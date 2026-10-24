-- Buka SQL Developer (buat koneksi baru dengan user SYSTEM) atau SQL*Plus, lalu login sebagai administrator:
--
-- sqlplus system/password_admin@localhost:1521/XEPDB1

-- Periksa user dan container yang sedang aktif:
SHOW USER;
SHOW CON_NAME;

select username, account_status, default_tablespace from dba_users;

-- 3. Pastikan schema PRAKTIKUM belum ada:
select username, account_status, default_tablespace from dba_users where username = 'PRAKTIKUM';
-- Hasil yang diharapkan: SHOW USER menampilkan "SYSTEM", CON_NAME berisi nama PDB (bukan CDB$ROOT), dan query terakhir menghasilkan "no rows selected".


-- 1. Buat user sekaligus schema PRAKTIKUM:
create user if not exists praktikum IDENTIFIED BY Praktikum123 DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA 50M ON users;

-- 2. Verifikasi bahwa schema sudah terbentuk:
select username, account_status, default_tablespace, temporary_tablespace, created from dba_users where username = 'PRAKTIKUM';

SELECT tablespace_name, max_bytes FROM dba_ts_quotas WHERE username = 'PRAKTIKUM';

-- 3. Periksa isi schema yang baru dibuat:
SELECT COUNT(*) FROM dba_objects WHERE owner = 'PRAKTIKUM';

-- Menguji Login Sebelum Diberi Hak Akses
-- 1. Coba login dengan user yang baru dibuat:
CONNECT praktikum/Praktikum123@localhost:1521/XEPDB1;
-- Jika XEPDB1 tidak bisa ERROR: ORA-12514: Cannot connect to database. Service XEPDB1 is not registered with the listener at host 127.0.0.1 port 1521.
-- Gunakan:
CONNECT praktikum/Praktikum123@localhost:1521/FREEPDB1;
-- Pengamatan: Catat kode error yang muncul (ORA-01045) dan jelaskan mengapa user yang sudah ada belum bisa login.

-- 2. Kembali login sebagai administrator:
CONNECT system/password_admin@localhost:1521/XEPDB1;
-- ERROR: ORA-12514: Cannot connect to database. Service XEPDB1 is not registered with the listener at host 127.0.0.1 port 1521.
-- Gunakan:
CONNECT system/Kuliah123@localhost:1521/FREEPDB1 as sysdba;

-- Alternatif
CONNECT / as sysdba;



-- 1. Berikan privilege dasar agar user dapat login dan membuat objek:
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO praktikum;

-- 2. Verifikasi privilege yang diterima:
SELECT grantee, privilege FROM dba_sys_privs WHERE grantee = 'PRAKTIKUM' ORDER BY privilege;


-- Langkah 5: Masuk ke Schema Baru
-- 1. Login menggunakan user PRAKTIKUM (di SQL Developer, buat koneksi baru dengan username praktikum):
CONNECT praktikum/Praktikum123@localhost:1521/FREEPDB1

-- 2. Pastikan Anda berada di schema yang benar:
SELECT USER FROM DUAL;
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS schema_aktif FROM DUAL;
SELECT COUNT(*) FROM user_objects;

SQL> desc user_objects;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 OBJECT_NAME                                        VARCHAR2(128)
 SUBOBJECT_NAME                                     VARCHAR2(128)
 OBJECT_ID                                          NUMBER
 DATA_OBJECT_ID                                     NUMBER
 OBJECT_TYPE                                        VARCHAR2(23)
 CREATED                                            DATE
 LAST_DDL_TIME                                      DATE
 TIMESTAMP                                          VARCHAR2(19)
 STATUS                                             VARCHAR2(7)
 TEMPORARY                                          VARCHAR2(1)
 GENERATED                                          VARCHAR2(1)
 SECONDARY                                          VARCHAR2(1)
 NAMESPACE                                          NUMBER
 EDITION_NAME                                       VARCHAR2(128)
 SHARING                                            VARCHAR2(18)
 EDITIONABLE                                        VARCHAR2(1)
 ORACLE_MAINTAINED                                  VARCHAR2(1)
 APPLICATION                                        VARCHAR2(1)
 DEFAULT_COLLATION                                  VARCHAR2(100)
 DUPLICATED                                         VARCHAR2(1)
 SHARDED                                            VARCHAR2(1)
 IMPORTED_OBJECT                                    VARCHAR2(1)
 SYNCHRONOUS_DUPLICATED                             VARCHAR2(1)
 CREATED_APPID                                      NUMBER
 CREATED_VSNID                                      NUMBER
 MODIFIED_APPID                                     NUMBER
 MODIFIED_VSNID                                     NUMBER

