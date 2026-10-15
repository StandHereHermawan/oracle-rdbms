GRANT { hak_sistem | role } [, ...] TO { user | role | PUBLIC } [WITH ADMIN OPTION];
GRANT { hak_objek [(kolom, ...)] | ALL [PRIVILEGES] } [, ...]
      ON [schema.]objek TO { user | role | PUBLIC } [WITH GRANT OPTION];
GRANT hak_sistem ON SCHEMA nama_schema TO { user | role };        -- [23ai+]
 
REVOKE { hak_sistem | role } FROM { user | role | PUBLIC };
REVOKE { hak_objek | ALL } ON [schema.]objek FROM { user | role | PUBLIC };


-- User baru belum bisa apa-apa: GRANT dulu 
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO akademik;
GRANT DB_DEVELOPER_ROLE TO akademik;                    -- [23ai+] satu role pengembang
GRANT CREATE SESSION TO mhs01;
GRANT SELECT ANY TABLE ON SCHEMA akademik TO mhs01;     -- [23ai+] termasuk tabel baru
GRANT SELECT, INSERT ON akademik.mahasiswa TO mhs01;    -- 19c: per objek
REVOKE INSERT ON akademik.mahasiswa FROM mhs01;
