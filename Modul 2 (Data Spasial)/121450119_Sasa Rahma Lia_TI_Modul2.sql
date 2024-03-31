-- Trigger postgis
create extension if not exists postgis;
create extension if not exists postgis_topology;

-- Mengecek versi dari postgis 
select postgis_version() 


-- Soal 1 : Titik Sudut 
-- Membuat tabel spasial 
create table sasa_lampungselatan(
	id serial primary key,
	tujuan_wisata varchar(100),
	lokasi geometry(point, 4326)
)

-- Masukan data kedalam tabel
insert into sasa_lampungselatan(tujuan_wisata, lokasi)
values
	('Pantai Kedu Warna', ST_GeomFromText('point(105.5765013810953 -5.715838625752194)', 4326)),
	('Pantai Ketang', ST_GeomFromText('point(105.56750383548393 -5.709598754087278)', 4326)),
	('Sanggar Beach', ST_GeomFromText('point(105.58436816355551 -5.725487835040756)', 4326)),
	('Pantai Semukuk Indah', ST_GeomFromText('point(105.58968139948124 -5.742633728158342)', 4326)),
	('Pantai Setigi Heni', ST_GeomFromText('point(105.58268940357658 -5.760620858798001)', 4326)),
	('Pantai Wartawan', ST_GeomFromText('point(105.58158362512974 -5.787391618967019)', 4326)),
	('Air Terjun Way Tayas', ST_GeomFromText('point(105.59370622880424 -5.809010727063845)', 4326)),
	('Pantai Kahai', ST_GeomFromText('point(105.62825158383991 -5.833817127159872)', 4326)),
	('Pulau Mengkudu', ST_GeomFromText('point(105.68515162257273 -5.845062831851453)', 4326)),
	('Pantai Minang Rua', ST_GeomFromText('point(105.71374521461232 -5.8553135893496915)', 4326));
	
-- Memilih data yang sudah dibuat 
select  * from sasa_lampungselatan;


-- Soal 2 : Polygon
-- Membuat tabel batas daerah 
create table sasa_lampungselatan_batas (
	id serial PRIMARY KEY,
	nama_kota varchar(100),
	batas_kota GEOMETRY(POLYGON, 4326)
);

-- Masukan insert data batas daerah 
INSERT INTO sasa_lampungselatan_batas (nama_kota, batas_kota)
VALUES
	('Lampung Selatan', ST_GeomFromText('POLYGON((105.10888756105756 -5.31090564654737, 105.23863191954548 -5.181704836638132, 105.4181116154538 -5.214007542019136, 105.7446349176484 -5.599355391246636, 105.82680634469075 -5.585366651542472, 105.77437697955772 -5.835930223909504, 105.72004614296429 -5.907599625984927, 105.67634525266087 -5.838280186283572, 105.5771324206207 -5.791279071513299, 105.35626575881695 -5.515069570712555, 105.29445237977497 -5.348899004244866, 105.11027374188966 -5.308705548732138, 105.10888756105756 -5.31090564654737))', 4326));

select * from sasa_lampungselatan_batas;


-- Soal 3 : Titik Perjalanan
create table sasa_perjalanan(
	id SERIAL primary key,
	nama_tujuan VARCHAR(100), -- nama perjalanan
	waktu TIMESTAMP, -- Waktu titik diperoleh
	lokasi GEOMETRY(Point, 4326) -- koor titik (SERIALRID WGS 84)
);

INSERT INTO sasa_perjalanan (nama_tujuan, waktu, lokasi) VALUES
	('Pantai Tiska', '2024-03-16 09:00:00', ST_GeomFromText('POINT(105.32467381781801 -5.4886974956954795)', 4326)),
	('Pantai Tiska', '2024-03-16 09:01:00', ST_GeomFromText('POINT(105.32917715300887 -5.496628352145685)', 4326)),
	('Pantai Tiska', '2024-03-16 09:02:00', ST_GeomFromText('POINT(105.33264125700182 -5.500421333114439)', 4326)),
	('Pantai Tiska', '2024-03-16 09:03:00', ST_GeomFromText('POINT(105.33697138699306 -5.5043866964557555)', 4326)),
	('Pantai Tiska', '2024-03-16 09:04:00', ST_GeomFromText('POINT(105.33956946498778 -5.5083520333507225)', 4326)),
	('Pantai Tiska', '2024-03-16 09:05:00', ST_GeomFromText('POINT(105.34857613536948 -5.519041070493419)', 4326)),
	('Pantai Pasir Putih Lampung', '2024-03-16 10:01:00', ST_GeomFromText('POINT(105.3525598549614 -5.523695913562277)', 4326)),
	('Pantai Pasir Putih Lampung', '2024-03-16 10:02:00', ST_GeomFromText('POINT(105.34805651977055 -5.5159378214785395)', 4326)),
	('Pantai Pasir Putih Lampung', '2024-03-16 10:03:00', ST_GeomFromText('POINT(105.33870343898954 -5.50731760018969)', 4326)),
	('Pantai Pasir Putih Lampung', '2024-03-16 10:04:00', ST_GeomFromText('POINT(105.3347197193976 -5.502662628686229)', 4326)),
	('Pantai Pasir Putih Lampung', '2024-03-16 10:05:00', ST_GeomFromText('POINT(105.32986997380748 -5.496973169596111)', 4326)),
	('Pantai Pasir Putih Lampung', '2024-03-16 10:06:00', ST_GeomFromText('POINT(105.32623266461485 -5.493180166660333)', 4326));


select * from sasa_perjalanan;

-- Pembuatan Data Spasial
select nama_tujuan, st_makeline(lokasi order by waktu) as travel_path
from sasa_perjalanan
group by nama_tujuan;