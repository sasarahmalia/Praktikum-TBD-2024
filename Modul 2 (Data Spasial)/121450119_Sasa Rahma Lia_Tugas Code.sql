-- Trigger postgis
create extension if not exists postgis;
create extension if not exists postgis_topology;

-- Mengecek versi dari postgis 
select postgis_version() 



-- Membuat tabel spasial 
create table contoh_spasial_table (
	id serial primary key,
	name varchar(255),
	geom geometry(point, 4326)
);


-- Masukan data kedalam tabel
insert into contoh_spasial_table (name, geom)
values
	('Titik A', ST_GeomFromText('point(105.238264 -5.382384)', 4326)),
	('Titik B', ST_GeomFromText('point(105.25966331153762 -5.371246988067161)', 4326)),
	('Titik C', ST_GeomFromText('point(105.29395063132908 -5.389162474187335)', 4326)),
	('Titik D', ST_GeomFromText('point(105.27474000534663 -5.414340101593805)', 4326)),
	('Titik E', ST_GeomFromText('point(105.249936412306 -5.442421602575001)', 4326));
	
-- Memilih data yang sudah dibuat 
select  * from contoh_spasial_table;


-- Membuat tabel batas daerah 
create table batas_daerah (
	id serial PRIMARY KEY,
	name varchar(100),
	boundary_geom GEOMETRY(POLYGON, 4326)
);

-- Masukan insert data batas daerah 
insert into batas_daerah (name, boundary_geom) 
values 
	('Batas Daerah 1', ST_GeomFromText('polygon((104.59583172039652 -5.007943698225315, 105.02489364382569 -5.006084566734241, 105.03659019500154 -5.35615555856873, 104.60351141850697 -5.385116931967321, 104.59583172039652 -5.007943698225315))',4326));

select * from batas_daerah;


-- Membuat sebuah polygon
select st_makepolygon(st_geomfromtext('LINESTRING(0 0, 0 10, 10 10, 10 0, 0 0)')) as polygon_geom; 


-- Menambahkan titik ke dalam polygon
select st_addpoint(st_geomfromtext('LINESTRING(0 0, 0 10, 10 10, 10 0, 0 0)'), st_makepoint(5, 5)) as modified_polygon_geom; 


select st_multi(st_collect(geom)) as multipoint_geom
from (
	values 
	(st_makepoint(1, 2)),
	(st_makepoint(3, 4))	
) as points(geom)


-- Linestring dengan urutan kooridinat titik a ke titik b
select st_geomfromtext('LINESTRING(1 1, 2 2, 3 3)') as linestring_geom;

-- Flip urutan koordinat dalam linestring
select ST_FlipCoordinates(ST_GeomFromText('LINESTRING(1 1, 2 2, 3 3)')) as flipped_linestring_geom;


create table travel_points(
	id SERIAL primary key,
	nama_perjalanan VARCHAR(100), -- nama perjalanan
	waktu TIMESTAMP, -- WAktu titik diperoleh
	koordinat_titik GEOMETRY(Point, 4326) --koor titik (SERIALRID WGS 84)
);

INSERT INTO travel_points (nama_perjalanan, waktu, koordinat_titik) VALUES
	('Jalan jalan', '2024-03-14 08:00:00', ST_GeomFromText('POINT(105.2191782692193 -5.393767044641828)', 4326)),
	('Jalan jalan', '2024-03-14 08:05:00', ST_GeomFromText('POINT(105.2351697933072 -5.3952314124109035)', 4326)),
	('Jalan jalan', '2024-03-14 08:15:00', ST_GeomFromText('POINT(105.24838513191222 -5.40213429672211)', 4326)),
	('Jalan jalan', '2024-03-14 08:20:00', ST_GeomFromText('POINT(105.25616150254724 -5.437277842840278)', 4326)),
	('Jalan jalan', '2024-03-14 08:25:00', ST_GeomFromText('POINT(105.26246640534714 -5.445436215124216)', 4326)),
	('Jalan jalan', '2024-03-14 08:30:00', ST_GeomFromText('POINT(105.25174789793725 -5.42305305746494)', 4326)),
	('Jalan jalan', '2024-03-14 08:35:00', ST_GeomFromText('POINT(105.27171299814107 -5.445226677693517)', 4326)),
	('Pergi bekerja', '2024-03-14 09:00:00', ST_GeomFromText('POINT(105.29213727524879 -5.39475814185437)', 4326)),
	('Pergi bekerja', '2024-03-14 09:05:00', ST_GeomFromText('POINT(105.28289114992188 -5.401663498427209)', 4326)),
	('Pergi bekerja', '2024-03-14 09:10:00', ST_GeomFromText('POINT(105.28120838449183 -5.38262618887499)', 4326)),
	('Pergi bekerja', '2024-03-14 09:15:00', ST_GeomFromText('POINT(105.27049115639362 -5.380953562521354)', 4326)),
	('Pergi bekerja', '2024-03-14 09:20:00', ST_GeomFromText('POINT(105.27049111292433 -5.38011675713395)', 4326)),
	('Pergi bekerja', '2024-03-14 09:25:00', ST_GeomFromText('POINT(105.25851366419465 -5.381582009006611)', 4326)),
	('Pergi bekerja', '2024-03-14 09:30:00', ST_GeomFromText('POINT(105.24863757974478 -5.375934137771177)', 4326)),
	('Pergi bekerja', '2024-03-14 09:35:00', ST_GeomFromText('POINT(105.24800722808618 -5.37677095896807)', 4326)),
	('Pergi bekerja', '2024-03-14 09:40:00', ST_GeomFromText('POINT(105.24044277805818 -5.373005624308156)', 4326));



--16.2 select data 
select nama_perjalanan, st_makeline(koordinat_titik order by waktu) as travel_path
from travel_points 
group by nama_perjalanan;