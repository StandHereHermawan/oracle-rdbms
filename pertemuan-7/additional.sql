-- statement menghapus schema atau user
DROP USER IF EXISTS KEL05_BENGKEL CASCADE;

CONNECT KEL05_BENGKEL/rahasia@localhost:1521

docker exec -it oracle-db-a1016-container sqlplus KEL05_BENGKEL/rahasia@localhost:1521

COLUMN OBJECT_NAME FORMAT A25;

SELECT OBJECT_NAME, OBJECT_TYPE, CREATED FROM user_objects where  OBJECT_TYPE = 'TABLE';



docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-5/persiapan_praktikum_group_by_11g.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle
@/opt/oracle/manajemen-administrasi-rdbms-oracle/persiapan_praktikum_group_by_11g.sql





docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/ddl_script.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle
@/opt/oracle/manajemen-administrasi-rdbms-oracle/ddl_script.sql

docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/drop_table.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle
@/opt/oracle/manajemen-administrasi-rdbms-oracle/drop_table.sql

docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/record/first_record.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle
docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/record/second_record.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle
docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/record/third_record.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle
docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/record/fourth_record.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle
docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/record/fifth_record.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle
docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/record/all_record.sql oracle-db-a1016-container:/opt/oracle/manajemen-administrasi-rdbms-oracle



@/opt/oracle/manajemen-administrasi-rdbms-oracle/first_record.sql
@/opt/oracle/manajemen-administrasi-rdbms-oracle/second_record.sql
@/opt/oracle/manajemen-administrasi-rdbms-oracle/third_record.sql
@/opt/oracle/manajemen-administrasi-rdbms-oracle/fourth_record.sql
@/opt/oracle/manajemen-administrasi-rdbms-oracle/fifth_record.sql
@/opt/oracle/manajemen-administrasi-rdbms-oracle/all_record.sql

select * from service_order;
select * from detail_service_order;
select * from detail_service_order_sparepart;

-- script auto execute setiap session baru
docker cp /home/arief-karditya/Project-Belajar-In-Linux/Project/kuliah/semester-7/manajemen-administrasi-rdbms/pertemuan-7/script-execute-every-database-new-session/glogin.sql oracle-db-a1016-container:/opt/oracle/product/26ai/dbhomeFree/sqlplus/admin/


