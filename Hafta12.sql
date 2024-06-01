create database Hafta12

--Triggerlar
--Deðiþiklikleri takip etmek
--birincil anahtar üretmek
--karmaþýk iþ kurallarýný gerçekleþtirmek
--e posta atmak gibi olaylarý otomatik yapma

--After/For Triggerlar 
--After triggerlar kendiyle iliþkili iþlem gerçekleþtikten hemen sonra ateþlenir Sadece tablolar için tanýmlanabilir

--Instead of Triggerlar
--View leri tetiklerken yapýyoruz

--Trigger oluþturmak için 
--Create Trigger TriggerIsmý with options
--on tabloadý
--for insert/update/delete
--as
--sql ifadeler

create table ogrenci
(
ogrNo int primary key identity(1,1),
ogrAd nvarchar(20)
)	

insert into ogrenci
values ('Ali'),('Can')

Select * from ogrenci
go
create trigger tr_ogrenciEkle
on Ogrenci
for Insert
As	
declare @ad nvarchar(25)
	Select @ad=(Select ogrAd from inserted)
	print @ad+'isimli öðrenci eklenmiþtir'
 
 insert ogrenci
 values ('yunus')

 --Alter ile triggerlarý düzenleyebiliyoruz

 --inserted tablolarýný listeleyen trigger yazýnýz

 --SANAL TABLOLARI GÖRMEK ÝÇÝN YAZILAN KODLAR
 go
 create trigger tr_InsertedListe
 on Ogrenci
 for INSERT
 AS
 Select * from inserted

 insert into ogrenci
 values('furkan')

 go
 create trigger tr_DeletedListe
 on Ogrenci
 for Delete
 as
	Select * from deleted
 go

 delete from ogrenci
 where ogrNo=10
 Select * from ogrenci

 go
 create trigger tr_InsertDeletedListeGoster
 on Ogrenci
 for Update
 as
  Select * from deleted
  Select * from inserted
go

update ogrenci
set ogrAd='Yunus Emre'
where ogrAd='yunus'

Select * from ogrenci
