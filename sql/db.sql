prompt PL/SQL Developer Export User Objects for user SHOP@LOCALHOST:1521/XE
prompt Created by Alexey on 16 РСЋР»СЊ 2019 Рі.
set define off
spool db.log

prompt
prompt Creating table CRM_ORDERSTATE
prompt =============================
prompt
create table CRM_ORDERSTATE
(
  id_orderstate NUMBER not null,
  s_name        VARCHAR2(50) not null,
  s_caption     VARCHAR2(50) not null
)
;
comment on table CRM_ORDERSTATE
  is 'состояния заказа';
comment on column CRM_ORDERSTATE.id_orderstate
  is 'ид состояния заказа';
comment on column CRM_ORDERSTATE.s_name
  is 'системное название';
comment on column CRM_ORDERSTATE.s_caption
  is 'название';
alter table CRM_ORDERSTATE
  add constraint ID_ORDERSTATE primary key (ID_ORDERSTATE);

prompt
prompt Creating table CRM_ORDER
prompt ========================
prompt
create table CRM_ORDER
(
  id_order        NUMBER not null,
  s_customername  VARCHAR2(100) not null,
  s_customerphone VARCHAR2(11) not null,
  d_created       DATE default SYSDATE not null,
  id_orderstate   NUMBER default 1 not null,
  d_expires       DATE default SYSDATE + 15 not null
)
;
comment on table CRM_ORDER
  is 'Заказы';
comment on column CRM_ORDER.id_order
  is 'ид заказа';
comment on column CRM_ORDER.s_customername
  is 'ФИО заказчика';
comment on column CRM_ORDER.s_customerphone
  is 'телефон заказчика';
comment on column CRM_ORDER.d_created
  is 'дата создания заказа';
comment on column CRM_ORDER.id_orderstate
  is 'ид состояния заказа';
comment on column CRM_ORDER.d_expires
  is 'дата отмены заказа, если он не будет закрыт к тому моменту';
alter table CRM_ORDER
  add constraint ID_ORDER primary key (ID_ORDER);
alter table CRM_ORDER
  add constraint ID_ORDERSTATE_ORDERSTATE foreign key (ID_ORDERSTATE)
  references CRM_ORDERSTATE (ID_ORDERSTATE);

prompt
prompt Creating table CRM_PRODUCTTYPE
prompt ==============================
prompt
create table CRM_PRODUCTTYPE
(
  id_producttype NUMBER not null,
  s_name         VARCHAR2(50) not null,
  s_caption      VARCHAR2(50) not null
)
;
comment on table CRM_PRODUCTTYPE
  is 'тип товара';
comment on column CRM_PRODUCTTYPE.id_producttype
  is 'ид типа товара';
comment on column CRM_PRODUCTTYPE.s_name
  is 'системное наименование товара';
comment on column CRM_PRODUCTTYPE.s_caption
  is 'наименование товара';
alter table CRM_PRODUCTTYPE
  add constraint ID_PRODUCTTYPE primary key (ID_PRODUCTTYPE);

prompt
prompt Creating table CRM_USER
prompt =======================
prompt
create table CRM_USER
(
  id_user    NUMBER not null,
  s_login    VARCHAR2(30) not null,
  s_password VARCHAR2(65) not null,
  s_apikey   VARCHAR2(65)
)
;
comment on table CRM_USER
  is 'Пользователи';
comment on column CRM_USER.id_user
  is 'ид пользователя';
comment on column CRM_USER.s_login
  is 'логин';
comment on column CRM_USER.s_password
  is 'пароль';
comment on column CRM_USER.s_apikey
  is 'ключ API';
alter table CRM_USER
  add constraint ID_USER primary key (ID_USER);

prompt
prompt Creating table CRM_PRODUCT
prompt ==========================
prompt
create table CRM_PRODUCT
(
  id_product     NUMBER not null,
  s_name         VARCHAR2(50) not null,
  s_caption      VARCHAR2(100) not null,
  s_description  VARCHAR2(1000),
  n_qty          NUMBER not null,
  f_price        FLOAT not null,
  d_created      DATE default SYSDATE not null,
  id_createdby   NUMBER not null,
  d_edited       DATE default SYSDATE,
  id_editedby    NUMBER,
  id_producttype NUMBER
)
;
comment on table CRM_PRODUCT
  is 'Товар';
comment on column CRM_PRODUCT.id_product
  is 'ид товара';
comment on column CRM_PRODUCT.s_name
  is 'артикул';
comment on column CRM_PRODUCT.s_caption
  is 'наименование';
comment on column CRM_PRODUCT.s_description
  is 'описание товара';
comment on column CRM_PRODUCT.n_qty
  is 'остаток товара';
comment on column CRM_PRODUCT.f_price
  is 'цена товара';
comment on column CRM_PRODUCT.d_created
  is 'дата создания товара';
comment on column CRM_PRODUCT.id_createdby
  is 'ид создавшего пользователя';
comment on column CRM_PRODUCT.d_edited
  is 'дата редактирования товара';
comment on column CRM_PRODUCT.id_editedby
  is 'ид редактировавшего пользователя';
comment on column CRM_PRODUCT.id_producttype
  is 'ид типа товара';
alter table CRM_PRODUCT
  add constraint ID_PRODUCT primary key (ID_PRODUCT);
alter table CRM_PRODUCT
  add constraint ID_CREATEDBY_USER foreign key (ID_CREATEDBY)
  references CRM_USER (ID_USER);
alter table CRM_PRODUCT
  add constraint ID_EDITEDBY_USER foreign key (ID_EDITEDBY)
  references CRM_USER (ID_USER);
alter table CRM_PRODUCT
  add constraint ID_PRODUCTYPE_PRODUCTTYPE foreign key (ID_PRODUCTTYPE)
  references CRM_PRODUCTTYPE (ID_PRODUCTTYPE);

prompt
prompt Creating table CRM_ORDERPRODUCT
prompt ===============================
prompt
create table CRM_ORDERPRODUCT
(
  id_orderproduct NUMBER not null,
  id_order        NUMBER not null,
  id_product      NUMBER not null,
  n_qty           NUMBER not null
)
;
comment on table CRM_ORDERPRODUCT
  is 'Товар в заказе';
comment on column CRM_ORDERPRODUCT.id_orderproduct
  is 'ид товара в заказе';
comment on column CRM_ORDERPRODUCT.id_order
  is 'ид заказа';
comment on column CRM_ORDERPRODUCT.id_product
  is 'ид товара';
comment on column CRM_ORDERPRODUCT.n_qty
  is 'количество товара в заказе';
alter table CRM_ORDERPRODUCT
  add constraint ID_ORDERPRODUCT primary key (ID_ORDERPRODUCT);
alter table CRM_ORDERPRODUCT
  add constraint ID_ORDER_ORDER foreign key (ID_ORDER)
  references CRM_ORDER (ID_ORDER);
alter table CRM_ORDERPRODUCT
  add constraint ID_PRODUCT_PRODUCT foreign key (ID_PRODUCT)
  references CRM_PRODUCT (ID_PRODUCT);

prompt
prompt Creating table CRM_PHOTO
prompt ========================
prompt
create table CRM_PHOTO
(
  id_photo   NUMBER not null,
  id_product NUMBER not null,
  s_server   VARCHAR2(200) not null,
  s_filename VARCHAR2(200) not null
)
;
comment on table CRM_PHOTO
  is 'Фотографии товара';
comment on column CRM_PHOTO.id_photo
  is 'ид фотографии';
comment on column CRM_PHOTO.id_product
  is 'ид товара';
comment on column CRM_PHOTO.s_server
  is 'сервер на котором хранится фотография';
comment on column CRM_PHOTO.s_filename
  is 'файл фотографии';
alter table CRM_PHOTO
  add constraint ID_PHOTO primary key (ID_PHOTO);
alter table CRM_PHOTO
  add constraint ID_PRODUCT_PHOTO_PRODUCT foreign key (ID_PRODUCT)
  references CRM_PRODUCT (ID_PRODUCT);

prompt
prompt Creating table CRM_SESSION
prompt ==========================
prompt
create table CRM_SESSION
(
  id_session   NUMBER not null,
  s_sessionkey VARCHAR2(100) not null,
  id_user      NUMBER not null,
  d_created    DATE default SYSDATE not null
)
;
comment on table CRM_SESSION
  is 'Сессии';
comment on column CRM_SESSION.id_session
  is 'ид сессии';
comment on column CRM_SESSION.s_sessionkey
  is 'ключ сессии';
comment on column CRM_SESSION.id_user
  is 'ид пользователя';
comment on column CRM_SESSION.d_created
  is 'датасоздания заказа';
alter table CRM_SESSION
  add constraint ID_SESSION primary key (ID_SESSION);
alter table CRM_SESSION
  add constraint ID_USER_USER foreign key (ID_USER)
  references CRM_USER (ID_USER);

prompt
prompt Creating sequence SEQ_ORDER
prompt ===========================
prompt
create sequence SEQ_ORDER
minvalue 1
maxvalue 9999999999999999999999999999
start with 45
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ORDERPRODUCT
prompt ==================================
prompt
create sequence SEQ_ORDERPRODUCT
minvalue 1
maxvalue 9999999999999999999999999999
start with 46
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ORDERSTATE
prompt ================================
prompt
create sequence SEQ_ORDERSTATE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PHOTO
prompt ===========================
prompt
create sequence SEQ_PHOTO
minvalue 1
maxvalue 9999999999999999999999999999
start with 31
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRODUCT
prompt =============================
prompt
create sequence SEQ_PRODUCT
minvalue 1
maxvalue 9999999999999999999999999999
start with 47
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRODUCTTYPE
prompt =================================
prompt
create sequence SEQ_PRODUCTTYPE
minvalue 1
maxvalue 9999999999999999999999999999
start with 43
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SESSION
prompt =============================
prompt
create sequence SEQ_SESSION
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_USER
prompt ==========================
prompt
create sequence SEQ_USER
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating function CRM_PHOTO_SINGLE
prompt ==================================
prompt
create or replace function CRM_PHOTO_SINGLE(idp_product in number) return varchar2 is
  photo varchar2(1000);
begin
  select S_SERVER||S_FILENAME into photo from CRM_PHOTO where id_product = idp_product and rownum = 1;
  return(photo);
end CRM_PHOTO_SINGLE;
/

prompt
prompt Creating view V_ORDERPRODUCTS
prompt =============================
prompt
create or replace force view v_orderproducts as
select

    ID_ORDERPRODUCT as "id",
    ID_ORDER as "idOrder",
    ID_PRODUCT as "idProduct",
    CRM_ORDERPRODUCT.N_QTY as "orderQuantity",

    CRM_PRODUCT.S_NAME as "name",
    CRM_PRODUCT.S_CAPTION as "caption",
    CRM_PRODUCT.F_PRICE as "price",
    CRM_PHOTO_SINGLE(ID_PRODUCT) as "photo"

    from CRM_ORDERPRODUCT
         join CRM_ORDER using (ID_ORDER)
         join CRM_PRODUCT using (id_product);

prompt
prompt Creating view V_ORDERS
prompt ======================
prompt
create or replace force view v_orders as
select
  ID_ORDER as "id",
  S_CUSTOMERNAME as "customerName",
  S_CUSTOMERPHONE as "customerPhone",
  D_CREATED as "created",
  ID_ORDERSTATE as "idOrderState",
  CRM_ORDERSTATE.S_CAPTION as "orderStateCaption",
  D_EXPIRES as "expires"
  from CRM_ORDER join CRM_ORDERSTATE using (id_orderstate)
  ORDER BY D_CREATED desc;

prompt
prompt Creating view V_PHOTOS
prompt ======================
prompt
create or replace force view v_photos as
select
       id_photo as "id",
       id_product,
       s_server as "server",
       s_filename as "filename"
    from CRM_PHOTO;

prompt
prompt Creating view V_PRODUCTS
prompt ========================
prompt
create or replace force view v_products as
select
       ID_PRODUCT as "id",
       CRM_PRODUCT.S_NAME as "name",
       CRM_PRODUCT.S_CAPTION as "caption",
       CRM_PRODUCT.S_DESCRIPTION as "description",
       CRM_PRODUCT.n_qty as "quantity",
       F_PRICE as "price",
       CRM_PRODUCTTYPE.S_NAME as "producttype_name",
       CRM_PRODUCTTYPE.S_CAPTION as "producttype_caption",
       Id_Producttype as "producttype_id"

  from CRM_PRODUCT
  join CRM_PRODUCTTYPE using (id_producttype)
where CRM_PRODUCT.N_QTY > 0
ORDER BY ID_PRODUCT;

prompt
prompt Creating view V_PRODUCTTYPES
prompt ============================
prompt
create or replace force view v_producttypes as
select
       ID_PRODUCTTYPE as "id",
       S_NAME as "name",
       S_CAPTION as "caption"
  from CRM_PRODUCTTYPE
  order by S_CAPTION;

prompt
prompt Creating view V_USEREXIST
prompt =========================
prompt
create or replace force view v_userexist as
select "ID_USER","S_LOGIN","S_PASSWORD","S_APIKEY"
    from CRM_USER;

prompt
prompt Creating function CRM_ORDER_INSERT
prompt ==================================
prompt
create or replace function crm_order_insert(
       sp_customerName in varchar2, 
       sp_customerPhone in varchar2) 
       return number is idv_newOrder number;
begin
  idv_newOrder := SEQ_ORDER.nextval;
  insert into CRM_ORDER (ID_ORDER, S_CUSTOMERNAME, S_CUSTOMERPHONE)
    values (idv_newOrder, sp_customerName, sp_customerPhone);
  commit;
  return idv_newOrder;
end crm_order_insert;
/

prompt
prompt Creating function CRM_ORDERPRODUCT_INSERT
prompt =========================================
prompt
create or replace function crm_orderproduct_insert(idp_order in number, idp_product in number, np_qty in number) return number is
  idv_orderproduct number;
begin
  idv_orderproduct := SEQ_ORDERPRODUCT.nextval;                   
  insert into CRM_ORDERPRODUCT (ID_ORDERPRODUCT,
                                ID_ORDER,
                                ID_PRODUCT,
                                N_QTY)
  values (idv_orderproduct,
  idp_order,
  idp_product,
  np_qty);
  update CRM_PRODUCT set CRM_PRODUCT.N_QTY = (CRM_PRODUCT.N_QTY - np_qty) WHERE CRM_PRODUCT.ID_PRODUCT = idp_product;
  commit;
  return(idv_orderproduct);
end crm_orderproduct_insert;
/

prompt
prompt Creating function CRM_USER_APIKEY_ISVALID
prompt =========================================
prompt
create or replace function CRM_USER_APIKEY_ISVALID(sp_apikey in varchar2) return number is
  idv_user number;
begin
    SELECT id_user into idv_user from CRM_USER where s_apikey = sp_apikey;
    return(idv_user);
  EXCEPTION WHEN NO_DATA_FOUND THEN
    idv_user := 0;
  return(idv_user);
end CRM_USER_APIKEY_ISVALID;
/

prompt
prompt Creating function CRM_PRODUCT_INSERT
prompt ====================================
prompt
create or replace function crm_product_insert(
       sp_apikey in varchar2,
       sp_name in varchar2,
       sp_caption in varchar2,
       sp_description in varchar2,
       np_qty in number,
       fp_price in float,
       idp_producttype in number
       )
       return number is idv_newProduct number;
begin
  idv_newProduct := SEQ_PRODUCT.nextval;
  insert into CRM_PRODUCT (ID_PRODUCT,
                           S_NAME,
                           S_CAPTION,
                           S_DESCRIPTION,
                           N_QTY,
                           F_PRICE,
                           D_CREATED,
                           ID_CREATEDBY,
                           ID_PRODUCTTYPE)
  VALUES (idv_newProduct, sp_name, sp_caption, sp_description,
         np_qty, fp_price, SYSDATE, crm_user_apikey_isvalid(sp_apikey), idp_producttype);
  commit;
  return idv_newProduct;
end crm_product_insert;
/

prompt
prompt Creating function CRM_PRODUCTTYPE_INSERT
prompt ========================================
prompt
create or replace function crm_producttype_insert(
       sp_name in varchar2,
       sp_caption in varchar2
       )
       return number is idv_newProductType number;
begin
  idv_newProductType := SEQ_PRODUCTTYPE.nextval;
  insert into CRM_PRODUCTTYPE (ID_PRODUCTTYPE,
                           S_NAME,
                           S_CAPTION)
  VALUES (idv_newProductType, sp_name, sp_caption);
  commit;
  return idv_newProductType;
end crm_producttype_insert;
/

prompt
prompt Creating function CRM_USER_SIGNIN
prompt =================================
prompt
create or replace function CRM_USER_SIGNIN(
       sp_login in varchar2, 
       sp_password in varchar2) 
return number is idv_user number;
begin
  SELECT id_user into idv_user from CRM_USER where s_login = sp_login and s_password = sp_password ;
    return(idv_user);
  EXCEPTION WHEN NO_DATA_FOUND THEN
    idv_user := 0;
  return(idv_user);
end CRM_USER_SIGNIN;
/

prompt
prompt Creating procedure CRM_ORDER_CANCEL
prompt ===================================
prompt
create or replace procedure CRM_ORDER_CANCEL(idp_order in number) is
begin
FOR vproduct IN (
  SELECT ID_ORDER, ID_PRODUCT, CRM_ORDERPRODUCT.N_QTY 
  FROM CRM_ORDERPRODUCT 
  join CRM_PRODUCT using (id_product) 
  where id_order = idp_order)
LOOP
  UPDATE CRM_PRODUCT 
  SET CRM_PRODUCT.N_QTY = CRM_PRODUCT.N_QTY + vproduct.N_QTY
  WHERE CRM_PRODUCT.ID_PRODUCT = vproduct.id_product;
END LOOP;
UPDATE CRM_ORDER SET ID_ORDERSTATE = 3 WHERE ID_ORDER = idp_order;
commit;
end CRM_ORDER_CANCEL;
/

prompt
prompt Creating procedure CRM_ORDER_PAID
prompt =================================
prompt
create or replace procedure CRM_ORDER_PAID(idp_order in number) is
begin
  UPDATE CRM_ORDER SET ID_ORDERSTATE = 2 WHERE ID_ORDER = idp_order;
  commit;
end CRM_ORDER_PAID;
/

prompt
prompt Creating procedure CRM_ORDER_PROLONG
prompt ====================================
prompt
create or replace procedure CRM_ORDER_PROLONG(idp_order in number) is
begin
  UPDATE CRM_ORDER SET D_EXPIRES = D_EXPIRES + 10 WHERE ID_ORDER = idp_order;
  commit;
end CRM_ORDER_PROLONG;
/

prompt
prompt Creating procedure CRM_PRODUCTTYPE_UPDATE
prompt =========================================
prompt
create or replace procedure CRM_PRODUCTTYPE_UPDATE(
       idp_productType in number,
       sp_name in varchar2,
       sp_caption in varchar2
       )
       is

begin

  UPDATE CRM_PRODUCTTYPE SET
    S_NAME = sp_name,
    S_CAPTION = sp_caption
  WHERE ID_PRODUCTTYPE = idp_productType;

  commit;

end CRM_PRODUCTTYPE_UPDATE;
/

prompt
prompt Creating procedure CRM_PRODUCT_UPDATE
prompt =====================================
prompt
create or replace procedure CRM_PRODUCT_UPDATE(
       sp_apikey in varchar2,
       idp_product in number,
       sp_name in varchar2, 
       sp_caption in varchar2,
       sp_description in varchar2,
       np_qty in number,
       fp_price in float,
       idp_producttype in number
       ) 
       is

begin

  UPDATE CRM_PRODUCT SET 
    S_NAME = sp_name,
    S_CAPTION = sp_caption,
    S_DESCRIPTION = sp_description,
    N_QTY = np_qty,
    F_PRICE = fp_price,
    D_EDITED = SYSDATE,
    ID_EDITEDBY = crm_user_apikey_isvalid(sp_apikey),
    ID_PRODUCTTYPE = idp_producttype
  WHERE ID_PRODUCT = idp_product;

  commit;

end CRM_PRODUCT_UPDATE;
/

prompt
prompt Creating procedure CRM_USER_SETAPIKEY
prompt =====================================
prompt
create or replace procedure CRM_USER_SETAPIKEY(idp_user in number, sp_apikey in varchar2) is
begin
  UPDATE CRM_USER SET S_APIKEY = sp_apikey
  WHERE ID_USER = idp_user;
  commit;
end CRM_USER_SETAPIKEY;
/


prompt Done
spool off
set define on
