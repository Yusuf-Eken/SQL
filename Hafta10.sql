create database Hafta10

use Hafta10
--encryption yaz�lm�� prosed�r�n i�eri�i �ifrelenerek saklan�r
--recompile her �al��mt�r�lmada tekrar compile edilecek �ekilde olu�turur
--set nocount on prosed�r�n �al��mas�nda etkilenen sat�r say�s�n� kontrol eder
-----------------------------------------------------------------------------------
create table Ogrenci(
ogrId int not null,
ogrAd varchar(20) null,
soyad varchar(20) null,
boy tinyint null
)
-----------------------------------------------------------------------------------

alter table Ogrenci
add bolum varchar(20) null
-----------------------------------------------------------------------------------

insert into Ogrenci
values(1,'Yusuf',null,170,'Bilgisayar')
-----------------------------------------------------------------------------------

--Par�al� kay�t
insert Ogrenci (ogrId,ogrAd,boy,bolum)
			values(3,'Can',175,'Grafik'),
				(4,'Canan',160,'Bilgisayar'),
				(5,'Ay�e',180,'Elektrik'),
				(6,'Mehmet',170,'Bilgisayar')
-----------------------------------------------------------------------------------

--Prosed�r olu�turmak
create procedure spOgrenciGoster 
as
Select * from Ogrenci
go
--Prosed�r� �a��rmak
execute spOgrenciGoster
exec spOgrenciGoster
-----------------------------------------------------------------------------------
--Ad� a ile baslayanlar� getiren prosed�r
Create proc spAdiA_ileBaslayan
as
Select * from Ogrenci
where ogrAd like 'a%'
go

exec spAdiA_ileBaslayan
-----------------------------------------------------------------------------------
--Prosed�r�n i�erisindeki kodu hat�rlam�yorsak g�rmek i�in kullan�yoruz
sp_helptext spAdiA_ileBaslayan
-----------------------------------------------------------------------------------
--@@ROWCOUNT sorgudan ka� kay�t�n etkilendi�ini g�nderir
exec spOgrenciGoster
select @@ROWCOUNT spAdiA_ileBaslayan
-----------------------------------------------------------------------------------
--Prosed�r� silmek i�in
Drop proc spOgrenciGoster
-----------------------------------------------------------------------------------
--Parametreli �rnek 
create proc spParametreli_Ornek(@isim varchar(20))
as
Select * from Ogrenci
where ogrAd=@isim
go

exec spParametreli_Ornek 'Yusuf'
-----------------------------------------------------------------------------------
--B�l�m� bilgisayar olanlar� getir prosed�rle
create proc spBolum(@bolum varchar(20))
as
Select * from Ogrenci
where bolum like @bolum
go

exec spBolum @bolum='Bilgisayar'
-----------------------------------------------------------------------------------
--Girdi ve ��kt�l� Prosed�rler
Create proc spToplam(@a int,@b int,@islem int output)
as
Select @islem=@a+@b
go
--Tan�mlamak=Declare
declare @toplam int
exec spToplam 10,20,@toplam output

Select @toplam
-----------------------------------------------------------------------------------
--Kare alma Prosed�r�
create proc spKareAl(@a int,@islem int output)
as
Select @islem=@a*@a
go

declare @sonuc int
exec spKareAl 5,@sonuc output

select @sonuc
-----------------------------------------------------------------------------------
--Dikd�rtgenin Alan�
create proc spDikdrtgenAlan(@a int,@b int,@islem int output)
as
Select @islem=@a*@b
go

declare @alan int
exec spDikdrtgenAlan 5,3,@alan output

Select @alan
-----------------------------------------------------------------------------------
--Ogrenci sayisi alma
create proc spOgrenciSayi(@bolum varchar(50),@sayi int out)
as
	Select @sayi=COUNT(*) from Ogrenci
	Where bolum=@bolum
go
declare @adet int
exec spOgrenciSayi 'Bilgisayar',@adet out
Select @adet
-----------------------------------------------------------------------------------
--Girdi�imiz harf sayisina g�re o say�ya uygun olan ��renci adlar�n�n ka� tane oldugunu g�ster
create proc spHarfOgrSayisi(@sayi int)
as
	Declare @x int
	Select @x=COUNT(*) from Ogrenci
	where len(ogrAd)=@sayi	
	--where ogrAd like '____'
	return @x
go

declare @hrfsyi int
exec @hrfsyi= spHarfOgrSayisi 3
Select @hrfsyi
-----------------------------------------------------------------------------------
--Kay�t eklemeye yarayan prosed�r
create proc spEkleKayit(@ogNo int,@isim varchar(20))

as
insert Ogrenci(ogrId,ogrAd) values (@ogNo,@isim)
go

exec spEkleKayit 19,Kerim
-----------------------------------------------------------------------------------
--Kay�t silmeye yarayan prosed�r
create proc spKayitsil(@bolum varchar(20))
as
delete from Ogrenci
where @bolum like @bolum
go

exec spKayitsil 'Elektrik'
-----------------------------------------------------------------------------------
--Ogrencinin Boyunu de�i�tir
create proc spBoyDegistir(@ograd varchar(20))
as
update Ogrenci
set boy=190
where ogrAd like @ograd
go

exec spBoyDegistir 'Kerim'
-----------------------------------------------------------------------------------
--Girdi�imiz harf sayisina g�re harf sayisina uygun olan adlar� getir
create proc spHarfSayi(@harf int)
as
Select ogrAd from Ogrenci
where LEN(ogrAd)=@harf
go

exec spHarfSayi 5	
-----------------------------------------------------------------------------------
--Girdi�imiz isime g�re b�l�m� g�ster 
create proc spBolumugetir(@isim varchar(20))
as
Select bolum from Ogrenci
where ogrAd like @isim
go

exec spBolumugetir 'Yusuf'
-----------------------------------------------------------------------------------
--�DEV  SP PARAMETRE OLARAK ALDI�I �K� TAM SAYIYI TOPLASIN VE �ARPSIN SONU�LARI D�NS�N
create procedure spHesaplama(@a int,@b int,@top int out,@carp int out)
as
Select @top=@a+@b,@carp=@a*@b
go
declare @t int,@c int
exec spHesaplama 3,4,@t out,@c out
Select @t,@c

exec spOgrenciGoster


