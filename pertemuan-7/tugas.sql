-- masuk ke admin
sqlplus / as sysdba

-- cek nama container
SHOW CON_NAME;

ALTER SESSION SET CONTAINER = FREEPDB1;

SHOW CON_NAME;

-- Melihat Table Spaces
SET LINESIZE 200;
SET PAGESIZE 50;
SELECT tablespace_name, status FROM dba_tablespaces;
-- TABLESPACE_NAME                STATUS
-- ------------------------------ ---------
-- SYSTEM                         ONLINE
-- SYSAUX                         ONLINE
-- UNDOTBS1                       ONLINE
-- TEMP                           ONLINE
-- USERS                          ONLINE



-- Format tampilan terminal
COLUMN username FORMAT A25;
COLUMN account_status FORMAT A15;



-- CEK DAFTAR SCHEMA atau USER (User atau Schema sama saja di konteks oracle RDBMS)
SELECT username, account_status, default_tablespace, temporary_tablespace, created FROM dba_users;
SELECT username, account_status, default_tablespace, temporary_tablespace, created FROM dba_users where default_tablespace = 'USERS';
SELECT username, account_status, default_tablespace, temporary_tablespace, created FROM dba_users where default_tablespace = 'USERS' and account_status = 'OPEN';



-- Membuat schema spesifik mitra bengkel
CREATE USER KEL05_BENGKEL IDENTIFIED BY "rahasia" DEFAULT TABLESPACE users  TEMPORARY TABLESPACE temp;

-- cek schema yang sudah dibuat
SELECT username, account_status, default_tablespace, temporary_tablespace, created FROM dba_users where default_tablespace = 'USERS' and account_status = 'OPEN';
-- cek isi schema
SELECT COUNT(*) FROM dba_objects WHERE owner = 'KEL05_BENGKEL';

-- perintah memberi hak akses ke schema.
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO KEL05_BENGKEL;

-- Cek apakah privillege sudah ada pada schema.
SELECT grantee, privilege FROM dba_sys_privs WHERE grantee = 'KEL05_BENGKEL' ORDER BY privilege;




-- masuk ke schema
CONNECT KEL05_BENGKEL/rahasia@localhost:1521

-- cek schema
SELECT USER FROM DUAL;
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS schema_aktif FROM DUAL;
-- cek jumlah isi schema
SELECT COUNT(*) FROM user_objects;




