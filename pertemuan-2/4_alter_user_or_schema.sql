-- Mengubah schema: password, kuota, status
ALTER USER [IF EXISTS] nama_user           -- [23ai+]
    [IDENTIFIED BY pwd_baru [REPLACE pwd_lama]]
    [NO AUTHENTICATION]
    [DEFAULT TABLESPACE nama_ts]
    [TEMPORARY TABLESPACE nama_ts]
    [QUOTA { n{K|M|G} | UNLIMITED } ON nama_ts] ...
    [PROFILE nama_profile]
    [DEFAULT ROLE { role, ... | ALL [EXCEPT role, ...] | NONE }]
    [PASSWORD EXPIRE]
    [ACCOUNT { LOCK | UNLOCK }];
 
ALTER USER nama_user GRANT CONNECT THROUGH user_proxy;
