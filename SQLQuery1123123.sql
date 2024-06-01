Create table Urunler(
id int identity(1,1),
ad nvarchar(50),
marka nvarchar(50),
kategori nvarchar(50),
stokadet int,
fiyat int
)

insert into Urunler
values('urun1','marka1','tekstil',250,50),
('urun2','marka1','tekstil',130,75),
('urun3','marka1','tekstil',100,75),
('urun4','marka1','elektronik',50,100),
('urun5','marka1','elektronik',70,350),
('urun6','marka1','gýda',80,225),
('urun7','marka1','gýda',35,20),
('urun8','marka1','elektronik',100,15),
('urun9','marka1','tekstil',25,70),
('urun10','marka1','elektronik',100,55),
('urun11','marka1','gýda',25,39)

select * from Urunler

--1-Kategorilere göre fiyat ortalamasýný listeleyin
Select kategori,avg(fiyat) from Urunler
group by kategori
--2-Tekstil kategorisindeki ürünlerinin markalara göre toplam stok adetlerini listeleyin
SELECT marka,SUM(stokadet) 
FROM Urunler 
WHERE kategori = 'tekstil' 
GROUP BY marka
--3-Hangi markadan kaç tane ürün olduðunu listeleyiniz
Select marka,Count(*)
from Urunler
group by marka
--4-Ürün adeti 3 den fazla olan markalarý ve ürün adetlerini listeleyiniz
Select marka,Count(*)
from Urunler
Group by marka
having Count(*)>3
--5-Kategorileri ve o kategorilere göre en yüksek ve en düþük fiyatlarý listeleyiniz.(10 puan)
Select kategori,MIN(fiyat) as endusuk,
max(fiyat) as enyüksek from Urunler
group by kategori
--6-Ortalama stok adetleri 45 den fazla olan kategorileri listeleyiniz.(10 puan)
Select kategori,avg(stokadet) from Urunler
group by kategori
having avg(stokadet)>45
--7-Fiyatý 100 den fazla olan ürünleri fiyatýna göre artan listeleyiniz.(5 puan)
Select * from Urunler
where fiyat>100
order by fiyat
--8-Stok adedi 10 dan az olan ürünleri siliniz.
Delete from Urunler
where stokadet<10
--9-Kategori adý içinde a harfi geçen kayýtlarý listeleyiniz
SELECT * 
FROM Urunler
WHERE kategori LIKE '%a%'
--10-Kategorisi tekstil, markasý marka2 ve fiyatý 100 den fazla ürünleri listeleyiniz.(5 puan)
Select * from Urunler
where kategori='tekstil' and marka='marka1' and fiyat>100
--11-Markalarý marka1 veya marka2 olan ürünleri listeleyiniz. (5 puan)
Select * from Urunler
where marka='marka1' or marka='marka2'
--12-Kategorisi gýda olan ürünlerin fiyatlarýna %40 indirim uygulayan SQL ifadeyi yazýnýz.
Update Urunler
Set fiyat=fiyat-(fiyat*40)/100
where kategori='gýda'

Select *from Urunler


























select ad from ogretmenler where bolum_no = (select bolum_no from bolumler where
bolum_ad = 'muhasebe')select count(*), ders_id from notlar group by ders_id
select ad from ogrenci where ogr_no IN (SELECT ogr_no from notlar where ders_id
= (select ders_id from ders where ders_ad = 'Veri Tabani'))