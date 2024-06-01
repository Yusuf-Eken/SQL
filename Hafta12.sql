create database Hafta12

--Triggerlar
--De�i�iklikleri takip etmek
--birincil anahtar �retmek
--karma��k i� kurallar�n� ger�ekle�tirmek
--e posta atmak gibi olaylar� otomatik yapma

--After/For Triggerlar 
--After triggerlar kendiyle ili�kili i�lem ger�ekle�tikten hemen sonra ate�lenir Sadece tablolar i�in tan�mlanabilir

--Instead of Triggerlar
--View leri tetiklerken yap�yoruz

--Trigger olu�turmak i�in 
--Create Trigger TriggerIsm� with options
--on tabload�
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
	print @ad+'isimli ��renci eklenmi�tir'
 
 insert ogrenci
 values ('yunus')

 --Alter ile triggerlar� d�zenleyebiliyoruz

 --inserted tablolar�n� listeleyen trigger yaz�n�z

 --SANAL TABLOLARI G�RMEK ���N YAZILAN KODLAR
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
