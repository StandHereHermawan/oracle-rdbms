-- Format sintaks lengkap CREATE USER
CREATE USER [IF NOT EXISTS] nama_user          -- [23ai+]
    { IDENTIFIED BY password
    | IDENTIFIED EXTERNALLY [AS 'nama_os']
    | IDENTIFIED GLOBALLY [AS 'DN_direktori']
    | NO AUTHENTICATION }                   -- schema-only
    [DEFAULT TABLESPACE nama_ts]
    [LOCAL TEMPORARY TABLESPACE nama_ts]
    [TEMPORARY TABLESPACE { nama_ts | nama_grup_ts }]
    [QUOTA { n{K|M|G} | UNLIMITED } ON nama_ts] ...
    [PROFILE nama_profile]
    [PASSWORD EXPIRE]
    [ACCOUNT { LOCK | UNLOCK }]
    [ENABLE EDITIONS]
    [CONTAINER = { CURRENT | ALL }];


-- Schema aplikasi lengkap
CREATE USER akademik
    IDENTIFIED BY Akademik123
    DEFAULT TABLESPACE ts_akademik
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON ts_akademik
    ACCOUNT UNLOCK;

-- Mahasiswa: ganti password saat login pertama
CREATE USER mhs01 IDENTIFIED BY Awal123
    DEFAULT TABLESPACE users QUOTA 50M ON users
    PASSWORD EXPIRE;

-- Schema-only: pemilik objek, tidak bisa login
CREATE USER app_owner NO AUTHENTICATION;

-- tidak membuat schema baru. Ia membuat beberapa tabel / view / grant sekaligus dalam satu transaksi di schema user yang sedang login.
CREATE SCHEMA AUTHORIZATION 

SELECT username, account_status, default_tablespace FROM dba_users WHERE username LIKE 'AKAD%';
SELECT tablespace_name, max_bytes FROM dba_ts_quotas WHERE username = 'AKADEMIK';
SELECT privilege FROM dba_sys_privs WHERE grantee = 'AKADEMIK';
SELECT * FROM session_privs;                          -- dari sesi user itu sendiri

