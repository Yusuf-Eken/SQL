create database Hafta10

use Hafta10
--encryption yazýlmýþ prosedürün içeriði þifrelenerek saklanýr
--recompile her çalýþmtýrýlmada tekrar compile edilecek þekilde oluþturur
--set nocount on prosedürün çalýþmasýnda etkilenen satýr sayýsýný kontrol eder
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

--Parçalý kayýt
insert Ogrenci (ogrId,ogrAd,boy,bolum)
			values(3,'Can',175,'Grafik'),
				(4,'Canan',160,'Bilgisayar'),
				(5,'Ayþe',180,'Elektrik'),
				(6,'Mehmet',170,'Bilgisayar')
-----------------------------------------------------------------------------------

--Prosedür oluþturmak
create procedure spOgrenciGoster 
as
Select * from Ogrenci
go
--Prosedürü Çaðýrmak
execute spOgrenciGoster
exec spOgrenciGoster
-----------------------------------------------------------------------------------
--Adý a ile baslayanlarý getiren prosedür
Create proc spAdiA_ileBaslayan
as
Select * from Ogrenci
where ogrAd like 'a%'
go

exec spAdiA_ileBaslayan
-----------------------------------------------------------------------------------
--Prosedürün içerisindeki kodu hatýrlamýyorsak görmek için kullanýyoruz
sp_helptext spAdiA_ileBaslayan
-----------------------------------------------------------------------------------
--@@ROWCOUNT sorgudan kaç kayýtýn etkilendiðini gönderir
exec spOgrenciGoster
select @@ROWCOUNT spAdiA_ileBaslayan
-----------------------------------------------------------------------------------
--Prosedürü silmek için
Drop proc spOgrenciGoster
-----------------------------------------------------------------------------------
--Parametreli örnek 
create proc spParametreli_Ornek(@isim varchar(20))
as
Select * from Ogrenci
where ogrAd=@isim
go

exec spParametreli_Ornek 'Yusuf'
-----------------------------------------------------------------------------------
--Bölümü bilgisayar olanlarý getir prosedürle
create proc spBolum(@bolum varchar(20))
as
Select * from Ogrenci
where bolum like @bolum
go

exec spBolum @bolum='Bilgisayar'
-----------------------------------------------------------------------------------
--Girdi ve çýktýlý Prosedürler
Create proc spToplam(@a int,@b int,@islem int output)
as
Select @islem=@a+@b
go
--Tanýmlamak=Declare
declare @toplam int
exec spToplam 10,20,@toplam output

Select @toplam
-----------------------------------------------------------------------------------
--Kare alma Prosedürü
create proc spKareAl(@a int,@islem int output)
as
Select @islem=@a*@a
go

declare @sonuc int
exec spKareAl 5,@sonuc output

select @sonuc
-----------------------------------------------------------------------------------
--Dikdörtgenin Alaný
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
--Girdiðimiz harf sayisina göre o sayýya uygun olan öðrenci adlarýnýn kaç tane oldugunu göster
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
--Kayýt eklemeye yarayan prosedür
create proc spEkleKayit(@ogNo int,@isim varchar(20))

as
insert Ogrenci(ogrId,ogrAd) values (@ogNo,@isim)
go

exec spEkleKayit 19,Kerim
-----------------------------------------------------------------------------------
--Kayýt silmeye yarayan prosedür
create proc spKayitsil(@bolum varchar(20))
as
delete from Ogrenci
where @bolum like @bolum
go

exec spKayitsil 'Elektrik'
-----------------------------------------------------------------------------------
--Ogrencinin Boyunu deðiþtir
create proc spBoyDegistir(@ograd varchar(20))
as
update Ogrenci
set boy=190
where ogrAd like @ograd
go

exec spBoyDegistir 'Kerim'
-----------------------------------------------------------------------------------
--Girdiðimiz harf sayisina göre harf sayisina uygun olan adlarý getir
create proc spHarfSayi(@harf int)
as
Select ogrAd from Ogrenci
where LEN(ogrAd)=@harf
go

exec spHarfSayi 5	
-----------------------------------------------------------------------------------
--Girdiðimiz isime göre bölümü göster 
create proc spBolumugetir(@isim varchar(20))
as
Select bolum from Ogrenci
where ogrAd like @isim
go

exec spBolumugetir 'Yusuf'
-----------------------------------------------------------------------------------
--ÖDEV  SP PARAMETRE OLARAK ALDIÐI ÝKÝ TAM SAYIYI TOPLASIN VE ÇARPSIN SONUÇLARI DÖNSÜN
create procedure spHesaplama(@a int,@b int,@top int out,@carp int out)
as
Select @top=@a+@b,@carp=@a*@b
go
declare @t int,@c int
exec spHesaplama 3,4,@t out,@c out
Select @t,@c

exec spOgrenciGoster


