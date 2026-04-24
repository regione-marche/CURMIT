-- Claudio 03/11/2008

begin;

-- Studi associati degli amministratori di condominio
CREATE TABLE iter_offices (

	office_id	 integer PRIMARY KEY -- references users(user_id) 

      -- dati anagrafici e contatto
      , name             varchar(200) NOT NULL
      , address1         varchar(200)
      , address2         varchar(40)
      , city             varchar(40)
      , province         varchar(4)
      , zipcode          varchar(5)
      , fiscal_code      varchar(16)
      , iva_code         varchar(11)
      , phone            varchar(50)
      , mobile           varchar(50)
      , email            varchar(256) NOT NULL
      , fax              varchar(50)
      , notes            text
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
      , iban_code          varchar(27)
      , cc_name            varchar(100)
);

alter table iter_trustees add wallet_id          varchar(18);
alter table iter_trustees add iban_code          varchar(27);
alter table iter_trustees add cc_name            varchar(100);
alter table iter_trustees add office_id          integer references iter_offices(office_id);

-- Manutentori da bonificare
create table iter_maintainers_to_adjust (
          iter_code             varchar(8) primary key 
	, password              varchar(8)
	, instance_name  	varchar(40) not null
);

commit;
