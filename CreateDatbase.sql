 create database [HospitalBalakovo]
on primary
(name='HospitalBalakovo', filename='D:\SQLDB\MSSQL13.SQLEXPRESS\MSSQL\DATA\HospitalBalakovo.mdf',size=10mb, maxsize=400mb, filegrowth=10%)
log on
(name='HospitalBalakovoLog', filename='D:\SQLDB\MSSQL13.SQLEXPRESS\MSSQL\DATA\HospitalBalakovo_log.ldf',size =5mb, maxsize=200mb, filegrowth=10%);
go


Use [HospitalBalakovo]
go
create table Departments										 -- Отеделения				
(Id int identity(1,1) not null,								 -- ID отделения
Building int check(Building >= 1 and Building <= 5) not null,    -- Корпус отделения
Floor int check(Floor >= 1) not null,							 -- этаж
HeadOfDepartment nvarchar(100) check(HeadOfDepartment !='') not null unique, -- Заведующий отделением ФИО
Office nvarchar(10) not null,										 -- кабинет №
primary key(Id)													 -- уникальный ключ
);
go
create table Doctors											-- Таблица докторов
(Id int identity(1,1) not null,								-- ID докторов
Surname nvarchar(max) check(Surname !='') not null,				-- Фамилия докторов
Name nvarchar(max) check(Name !='') not null,					-- Имя докторов
Office nvarchar(10) not null,										-- Кабинет №
Specialization nvarchar(max) check(Specialization !='') not null,-- Специализация
CostService money check(CostService > 0) not null,				-- Стоимость услуг
DepartmentsId int not null,										-- Id Отделения для внеш ключа
primary key(Id),												-- уникальный ключ
Constraint FK_01 foreign key (DepartmentsId) references Departments(Id) --внешний ключ
);
go 
create table Reception											-- Создание таблицы регистратуры, где храниться информация о записях 
(Id int identity(1,1) not null,								--ID записи
DayOfWeek int check(DayOfWeek >= 1 and DayOfWeek <= 7),			--день приема
FIO_Patcient nvarchar(100) check(FIO_Patcient !='') not null unique, --ФИО пациента
StartTime time  not null check(StartTime >= '08:00' and StartTime <= '18:00'), check (StartTime < EndTime), -- начало приема
EndTime time not null,											-- конец приема
DoctorId int not null,											-- Id докторов для внеш ключа
primary key(Id),												-- уникальный ключ
Constraint FK_02 foreign key (DoctorId) references Doctors(Id)  --внешний ключ
);
go
create table Patcient											-- Создание таблицы Пациенты
(Id int identity(1,1) not null ,								 -- ID пациента 
patcient_name nvarchar(50)check(patcient_name !='') not null,   -- имя пациента 
adress nvarchar(50)check(adress !='') not null,					-- адрес пациента 
marital_status nvarchar(50) not null,							-- социальный статус пациента 
sem_pol nvarchar(50) not null,								    -- семейное положение
year_of_birth  int not null,									-- год рождения пациента
DoctorId int not null,											-- Id пациента для внеш ключа
ReceptionId int not null,										-- Id пациента для внеш ключа
primary key(Id),												-- уникальный ключ
Constraint FK_03 foreign key (DoctorId) references Doctors(Id),  --внешний ключ
Constraint FK_04 foreign key (ReceptionId) references Reception(Id)  --внешний ключ
);
go

create table CardPatcient										--карта больного
(Id int identity(1,1) not null,					--ID больного
Symptoms nvarchar(150) check(Symptoms !='') not null,			--симптомы больного
Diagnosis nvarchar(50) check(Diagnosis !='') not null,			--диагноз больного
Medicament nvarchar(50) check(Medicament !='') not null,		-- лекарства назначенные
PatcientId int null,												-- Id карточки пациента для внеш ключа
primary key(Id),												--уникальный ключ
Constraint FK_7 foreign key (PatcientId) references Patcient(Id)  --внешний ключ
);
go 
create table Diseases											-- Создание таблицы Болезни
(Id int identity(1,1) not null,									-- ID болезней
Name nvarchar(100) check(Name !='') not null unique,			-- Наименование болезней
Severity int check(Severity >= 1) not null default 1,			-- Степень болезни
CardPatcientId int null,										-- Id карточки пациента для внеш ключа
primary key(Id),												-- уникальный ключ
Constraint FK_05 foreign key (CardPatcientId) references CardPatcient(ID)
);
go 
create table Treatrment											-- Создание таблицы , где храниться информация о лечении, назначении пациента  
(Id int identity(1,1) not null,								-- ID болезни
Treatrment_name nvarchar(50) not null,                          -- название лечения
start_date date NOT NULL check (start_date <= getdate()),       -- дата начала лечения 
end_date date not null,				       						 -- дата окончания лечения
period int not null,											-- длительность лечения
PatcientId int not null,											-- Id лечения для внеш ключа
primary key(Id),												-- уникальный ключ
Constraint FK_06 foreign key (PatcientId) references Patcient(Id),  --внешний ключ
); 

go
create table SectionsTerritory									-- участки, районы
(Id int identity(1,1) not null,				-- ID участка, района
Districts nvarchar(50) check(Districts !='') not null,			--наименование участка
DoctorsId int null,												--Id участка района
primary key(Id),												--уникальный ключ
Constraint FK_08 foreign key (DoctorsId) references Doctors(Id)  --внешний ключ
);
g
