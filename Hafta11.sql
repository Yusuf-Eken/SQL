Create Database Hafta11

Use Hafta11

create table ogrenci(
ogrNo int identity(1,1) primary key,
ogrAdSoyad nvarchar(50),
ogrSnf int,
ogrBolum nvarchar(50)
)

insert into ogrenci
values ('Seyit Elçuk','2','Bilgisayar'),
		('Furkan Kara','1','Halkla Ýliþkiler'),
		('Kerim Duruþ','5','Bilgisayar'),
		('Kadir Hazar','8','Bilgisayar'),
		('Eren Buðra Yozgatlý','1','Grafik'),
		('Furkan Aygul','5','Alternatif Enerji Kaynaklarý')

--Ogrencileri Listelemek için bir view oluþturun
create view vwOgrenciListele
as
Select * from ogrenci

--1.sýnýf öðrencilerini listeleyen bir view yazýnýz
create view vwSýnýf1
as
Select * from ogrenci
where ogrSnf=1

--vwSýnýf1'i 2.sýnýf öðrencilerini getirecek þekilde deðiþtirin.
Alter view vwSýnýf1
as
Select * from ogrenci
where ogrSnf=2

--vwSil 'i oluþtur ve sil
create view vwSil
as
Select * from ogrenci
where ogrSnf=1

Drop view vwSil

--Alanlarýn isimlerini deðiþtirme
create view cwAlanAdlarýYenile(
ogrenciNumara,ogrenciADSOYAD)
as
Select ogrNo,ogrAdSoyad from ogrenci

--View'in kodunu görmek için
sp_helptext  vwAlanAdlarýYenile

--View'in adýný deðiþtirelim
sp_rename cwAlanAdlarýYenile,vwAlanAdlarýYenile

create view vwBilgisayarListele
as
Select * from ogrenci
where ogrBolum='Bilgisayar'

Select * from vwBilgisayarListele
insert into vwBilgisayarListele
values('Furkan Beyaz',2,'Bilgisayar')

--Kiþinin görüeyemeceði kayýtlra eklemememsi için kullanýlýr
Alter view vwBilgisayarListele
as
Select * from ogrenci
where ogrBolum='Bilgisayar'
with check option

--Tablo adý deðiþtirme
create table Personel(
perNo int identity(1,1) primary key,
perAdSoyad nvarchar(50),
perAlan nvarchar(50)
)

sp_rename Personel,Calisan

Select * from Calisan

--Tablonun adýný personeli çalýþan olarak deðiþtirin
declare @ad varchar(20),@alan varchar(20)

Select @ad=ogrAdSoyad,@alan=ogrBolum from ogrenci
where ogrNo=5

print 'adýnýz:'+@ad
print @alan&

--Öðrenci sayýsýný bulup bir deðiþkene atayýnýz ve ekrana yazdýrýnýz.
declare @sayi int
select @sayi=COUNT(*) from ogrenci
print cast (@sayi as nvarchar(20))+' tane öðrenci vardýr.'

--4 iþlem
declare @sayac int=0
set @sayac+=5
select @sayac
set @sayac-=2
select @sayac
set @sayac=@sayac*5
select @sayac
set @sayac%=2
select @sayac

--AKIÞ KONTROLLERÝ
--BEGÝN PARANTEZ AÇ
--END PARANTEZ KAPA

declare @z int=1
	while @z<5
	begin
		print @z
		set @z= @z+1
	end
