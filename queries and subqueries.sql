use HospitalBalakovo
go
Select * --1
From Departments 
ORDER by Office DESC

go
Select HeadOfDepartment as 'Заведующий', Office as 'Кабинет' --2
From Departments
ORDER by Office ASC

go
Select Surname as 'Фамилия', Name as 'Имя',Office as 'Кабинет', Specialization as 'Специализация', CostService as 'Стоимость услуг', DepartmentsId as 'Корпус' --3
From Doctors
Where  Specialization = 'терапевт';

go
Select COUNT(*) as 'Количество пациентов' --4
From Patcient
Where sem_pol ='женат' or sem_pol ='замужем' and marital_status ='работает' 

go
Select Name as 'Имя', Office as 'Кабинет', Specialization as 'Специализция' --5
From Doctors
Where Name like 'А%' 

go
Select Surname as'Фамилии', CostService as'Стоимость услуг' --6
From Doctors
Where CostService between  '2200' and '3000'

go
Select Doctors.Name AS 'Имя Доктора', --7
       Doctors.Surname AS 'Фамилия Доктора', 
       Patcient.adress AS 'Адрес Пациента', 
       Reception.DayOfWeek AS 'День недели приема'
From Doctors
INNER JOIN Patcient ON Doctors.Id = Patcient.Id
INNER JOIN Reception ON Doctors.Id = Reception.Id;

go
Select Diagnosis as 'Симптомы' --8
From CardPatcient
Where Symptoms Like 'Головная боль%';

go
Select PatcientId as 'Id пациента', AVG(period) as 'Кол-вод дней лечения' --9
From Treatrment
GROUP BY PatcientId
HAVING AVG(period) > 20;

go
Select PatcientId as 'Id пациента', COUNT(*) AS "Количество лечений" --10
From Treatrment
GROUP BY PatcientId
HAVING COUNT(*) > 0;

go
Select SectionsTerritory.Districts as "Район", Doctors.Name as "Имя", Doctors.Surname as "Фамилия" --11
From SectionsTerritory 
INNER JOIN Doctors ON SectionsTerritory.DoctorsId = Doctors.Id;

go
Select CP.Symptoms as "Симптомы", CP.Diagnosis as "Диагноз", CP.Medicament as "Лекарства", D.Name as "Болезнь" -- 12
From CardPatcient CP
INNER JOIN Diseases D ON CP.PatcientId = D.CardPatcientId;

go
Select Treatrment_name as 'Назначение',start_date as 'Начало лечения',end_date as 'Конец лечения',period as 'Период' -- 13
from Treatrment 
INNER JOIN CardPatcient  ON Treatrment.PatcientId = CardPatcient.Id
INNER JOIN Diseases  ON CardPatcient.Id = Diseases.CardPatcientId
INNER JOIN SectionsTerritory  ON Diseases.Id = SectionsTerritory.Id
Where SectionsTerritory.Id = '1';

