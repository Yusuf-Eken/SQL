Create Database Hafta11

Use Hafta11

create table ogrenci(
ogrNo int identity(1,1) primary key,
ogrAdSoyad nvarchar(50),
ogrSnf int,
ogrBolum nvarchar(50)
)

insert into ogrenci
values ('Seyit El�uk','2','Bilgisayar'),
		('Furkan Kara','1','Halkla �li�kiler'),
		('Kerim Duru�','5','Bilgisayar'),
		('Kadir Hazar','8','Bilgisayar'),
		('Eren Bu�ra Yozgatl�','1','Grafik'),
		('Furkan Aygul','5','Alternatif Enerji Kaynaklar�')

--Ogrencileri Listelemek i�in bir view olu�turun
create view vwOgrenciListele
as
Select * from ogrenci

--1.s�n�f ��rencilerini listeleyen bir view yaz�n�z
create view vwS�n�f1
as
Select * from ogrenci
where ogrSnf=1

--vwS�n�f1'i 2.s�n�f ��rencilerini getirecek �ekilde de�i�tirin.
Alter view vwS�n�f1
as
Select * from ogrenci
where ogrSnf=2

--vwSil 'i olu�tur ve sil
create view vwSil
as
Select * from ogrenci
where ogrSnf=1

Drop view vwSil

--Alanlar�n isimlerini de�i�tirme
create view cwAlanAdlar�Yenile(
ogrenciNumara,ogrenciADSOYAD)
as
Select ogrNo,ogrAdSoyad from ogrenci

--View'in kodunu g�rmek i�in
sp_helptext  vwAlanAdlar�Yenile

--View'in ad�n� de�i�tirelim
sp_rename cwAlanAdlar�Yenile,vwAlanAdlar�Yenile

create view vwBilgisayarListele
as
Select * from ogrenci
where ogrBolum='Bilgisayar'

Select * from vwBilgisayarListele
insert into vwBilgisayarListele
values('Furkan Beyaz',2,'Bilgisayar')

--Ki�inin g�r�eyemece�i kay�tlra eklemememsi i�in kullan�l�r
Alter view vwBilgisayarListele
as
Select * from ogrenci
where ogrBolum='Bilgisayar'
with check option

--Tablo ad� de�i�tirme
create table Personel(
perNo int identity(1,1) primary key,
perAdSoyad nvarchar(50),
perAlan nvarchar(50)
)

sp_rename Personel,Calisan

Select * from Calisan

--Tablonun ad�n� personeli �al��an olarak de�i�tirin
declare @ad varchar(20),@alan varchar(20)

Select @ad=ogrAdSoyad,@alan=ogrBolum from ogrenci
where ogrNo=5

print 'ad�n�z:'+@ad
print @alan&

--��renci say�s�n� bulup bir de�i�kene atay�n�z ve ekrana yazd�r�n�z.
declare @sayi int
select @sayi=COUNT(*) from ogrenci
print cast (@sayi as nvarchar(20))+' tane ��renci vard�r.'

--4 i�lem
declare @sayac int=0
set @sayac+=5
select @sayac
set @sayac-=2
select @sayac
set @sayac=@sayac*5
select @sayac
set @sayac%=2
select @sayac

--AKI� KONTROLLER�
--BEG�N PARANTEZ A�
--END PARANTEZ KAPA

declare @z int=1
	while @z<5
	begin
		print @z
		set @z= @z+1
	end
