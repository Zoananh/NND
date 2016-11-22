/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     22.11.2016 20:32:45                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"Order"') and o.name = 'FK_ORDER_RELATIONS_CLIENT')
alter table "Order"
   drop constraint FK_ORDER_RELATIONS_CLIENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"Order"') and o.name = 'FK_ORDER_RELATIONS_MASTER')
alter table "Order"
   drop constraint FK_ORDER_RELATIONS_MASTER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Order_register') and o.name = 'FK_ORDER_RE_RELATIONS_ORDER')
alter table Order_register
   drop constraint FK_ORDER_RE_RELATIONS_ORDER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Order_register') and o.name = 'FK_ORDER_RE_RELATIONS_REPAIR')
alter table Order_register
   drop constraint FK_ORDER_RE_RELATIONS_REPAIR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Repair') and o.name = 'FK_REPAIR_RELATIONS_DEVICE')
alter table Repair
   drop constraint FK_REPAIR_RELATIONS_DEVICE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Repair') and o.name = 'FK_REPAIR_RELATIONS_MASTER')
alter table Repair
   drop constraint FK_REPAIR_RELATIONS_MASTER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Client')
            and   type = 'U')
   drop table Client
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Device')
            and   type = 'U')
   drop table Device
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Master')
            and   type = 'U')
   drop table Master
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"Order"')
            and   name  = 'Relationship_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index "Order".Relationship_2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"Order"')
            and   name  = 'Relationship_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index "Order".Relationship_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"Order"')
            and   type = 'U')
   drop table "Order"
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Order_register')
            and   name  = 'Relationship_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index Order_register.Relationship_3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Order_register')
            and   name  = 'Relationship_6_FK'
            and   indid > 0
            and   indid < 255)
   drop index Order_register.Relationship_6_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Order_register')
            and   type = 'U')
   drop table Order_register
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Repair')
            and   name  = 'Relationship_5_FK'
            and   indid > 0
            and   indid < 255)
   drop index Repair.Relationship_5_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Repair')
            and   name  = 'Relationship_4_FK'
            and   indid > 0
            and   indid < 255)
   drop index Repair.Relationship_4_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Repair')
            and   type = 'U')
   drop table Repair
go

/*==============================================================*/
/* Table: Client                                                */
/*==============================================================*/
create table Client (
   Client_ID            numeric              not null,
   Master_Name          varchar(50)          not null,
   Master_Phone         numeric(20)          not null,
   Master_Email         varchar(50)          null,
   constraint PK_CLIENT primary key nonclustered (Client_ID)
)
go

/*==============================================================*/
/* Table: Device                                                */
/*==============================================================*/
create table Device (
   Device_ID            numeric              not null,
   Device_Type          varchar(30)          not null,
   Device_Description   varchar(1000)        null,
   constraint PK_DEVICE primary key nonclustered (Device_ID)
)
go

/*==============================================================*/
/* Table: Master                                                */
/*==============================================================*/
create table Master (
   Master_ID            numeric              not null,
   Master_Name          varchar(50)          not null,
   Master_Phone         numeric(20)          not null,
   Master_Email         varchar(50)          null,
   constraint PK_MASTER primary key nonclustered (Master_ID)
)
go

/*==============================================================*/
/* Table: "Order"                                               */
/*==============================================================*/
create table "Order" (
   Order_ID             numeric              not null,
   Client_ID            numeric              not null,
   Master_ID            numeric              null,
   Order_Status         varchar(20)          not null,
   Order_Details        varchar(140)         not null,
   Opened_Date          datetime             not null,
   Closed_Date          datetime             null,
   Order_Price          decimal(19,4)        null,
   constraint PK_ORDER primary key nonclustered (Order_ID)
)
go

/*==============================================================*/
/* Index: Relationship_1_FK                                     */
/*==============================================================*/
create index Relationship_1_FK on "Order" (
Client_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on "Order" (
Master_ID ASC
)
go

/*==============================================================*/
/* Table: Order_register                                        */
/*==============================================================*/
create table Order_register (
   Order_ID             numeric              not null,
   Repair_ID            numeric              not null,
   constraint PK_ORDER_REGISTER primary key nonclustered (Order_ID, Repair_ID)
)
go

/*==============================================================*/
/* Index: Relationship_6_FK                                     */
/*==============================================================*/
create index Relationship_6_FK on Order_register (
Repair_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_3_FK                                     */
/*==============================================================*/
create index Relationship_3_FK on Order_register (
Order_ID ASC
)
go

/*==============================================================*/
/* Table: Repair                                                */
/*==============================================================*/
create table Repair (
   Repair_ID            numeric              not null,
   Device_ID            numeric              not null,
   Master_ID            numeric              not null,
   Repair_Cost          decimal(19,4)        not null,
   Repair_Type          varchar(50)          not null,
   constraint PK_REPAIR primary key nonclustered (Repair_ID)
)
go

/*==============================================================*/
/* Index: Relationship_4_FK                                     */
/*==============================================================*/
create index Relationship_4_FK on Repair (
Device_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_5_FK                                     */
/*==============================================================*/
create index Relationship_5_FK on Repair (
Master_ID ASC
)
go

alter table "Order"
   add constraint FK_ORDER_RELATIONS_CLIENT foreign key (Client_ID)
      references Client (Client_ID)
go

alter table "Order"
   add constraint FK_ORDER_RELATIONS_MASTER foreign key (Master_ID)
      references Master (Master_ID)
go

alter table Order_register
   add constraint FK_ORDER_RE_RELATIONS_ORDER foreign key (Order_ID)
      references "Order" (Order_ID)
go

alter table Order_register
   add constraint FK_ORDER_RE_RELATIONS_REPAIR foreign key (Repair_ID)
      references Repair (Repair_ID)
go

alter table Repair
   add constraint FK_REPAIR_RELATIONS_DEVICE foreign key (Device_ID)
      references Device (Device_ID)
go

alter table Repair
   add constraint FK_REPAIR_RELATIONS_MASTER foreign key (Master_ID)
      references Master (Master_ID)
go

