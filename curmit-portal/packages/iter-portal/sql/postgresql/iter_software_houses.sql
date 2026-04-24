/*==============================================================*/
/* table iter_software_house                                    */
/*==============================================================*/

create table iter_software_houses
( software_house_id integer      not null primary key
, name              varchar(200) not null
, first_name        varchar(200)
, address1          varchar(200)
, address2          varchar(40)
, city              varchar(40)
, province          varchar(4)
, zipcode           varchar(5)
, jtype             char(1)
, fiscal_code       varchar(16)
, iva_code          varchar(11)
, phone             varchar(50)
, mobile            varchar(50)
, email             varchar(256)
, fax               varchar(50)
, is_active_p       boolean
, creation_user     integer 
, creation_date     date
, editing_user      integer 
, editing_date      date
, notes             text
);
