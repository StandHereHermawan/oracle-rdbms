
DROP USER [IF EXISTS] nama_user [CASCADE];

DROP USER mhs01; -- → ORA-01922 bila masih punya objek

DROP USER akademik CASCADE; -- → user + SEMUA objeknya
