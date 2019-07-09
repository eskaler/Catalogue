prompt PL/SQL Developer Export User Objects for user SHOP@LOCALHOST:1521/XE
prompt Created by Alexey on 9 Июль 2019 г.
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
  is '��������� ������';
comment on column CRM_ORDERSTATE.id_orderstate
  is '�� ��������� ������';
comment on column CRM_ORDERSTATE.s_name
  is '��������� ��������';
comment on column CRM_ORDERSTATE.s_caption
  is '��������';
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
  d_created       DATE not null,
  id_orderstate   NUMBER not null
)
;
comment on table CRM_ORDER
  is '������';
comment on column CRM_ORDER.id_order
  is '�� ������';
comment on column CRM_ORDER.s_customername
  is '��� ���������';
comment on column CRM_ORDER.s_customerphone
  is '������� ���������';
comment on column CRM_ORDER.d_created
  is '���� �������� ������';
comment on column CRM_ORDER.id_orderstate
  is '�� ��������� ������';
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
  is '��� ������';
comment on column CRM_PRODUCTTYPE.id_producttype
  is '�� ���� ������';
comment on column CRM_PRODUCTTYPE.s_name
  is '��������� ������������ ������';
comment on column CRM_PRODUCTTYPE.s_caption
  is '������������ ������';
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
  s_password VARCHAR2(30) not null
)
;
comment on table CRM_USER
  is '������������';
comment on column CRM_USER.id_user
  is '�� ������������';
comment on column CRM_USER.s_login
  is '�����';
comment on column CRM_USER.s_password
  is '������';
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
  s_caption      VARCHAR2(50) not null,
  s_description  VARCHAR2(1000),
  n_qty          NUMBER not null,
  f_price        FLOAT(2) not null,
  d_created      DATE default SYSDATE not null,
  id_createdby   NUMBER not null,
  d_edited       DATE default SYSDATE,
  id_editedby    NUMBER,
  id_producttype NUMBER
)
;
comment on table CRM_PRODUCT
  is '�����';
comment on column CRM_PRODUCT.id_product
  is '�� ������';
comment on column CRM_PRODUCT.s_name
  is '�������';
comment on column CRM_PRODUCT.s_caption
  is '������������';
comment on column CRM_PRODUCT.s_description
  is '�������� ������';
comment on column CRM_PRODUCT.n_qty
  is '������� ������';
comment on column CRM_PRODUCT.f_price
  is '���� ������';
comment on column CRM_PRODUCT.d_created
  is '���� �������� ������';
comment on column CRM_PRODUCT.id_createdby
  is '�� ���������� ������������';
comment on column CRM_PRODUCT.d_edited
  is '���� �������������� ������';
comment on column CRM_PRODUCT.id_editedby
  is '�� ���������������� ������������';
comment on column CRM_PRODUCT.id_producttype
  is '�� ���� ������';
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
  is '����� � ������';
comment on column CRM_ORDERPRODUCT.id_orderproduct
  is '�� ������ � ������';
comment on column CRM_ORDERPRODUCT.id_order
  is '�� ������';
comment on column CRM_ORDERPRODUCT.id_product
  is '�� ������';
comment on column CRM_ORDERPRODUCT.n_qty
  is '���������� ������ � ������';
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
  is '���������� ������';
comment on column CRM_PHOTO.id_photo
  is '�� ����������';
comment on column CRM_PHOTO.id_product
  is '�� ������';
comment on column CRM_PHOTO.s_server
  is '������ �� ������� �������� ����������';
comment on column CRM_PHOTO.s_filename
  is '���� ����������';
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
  is '������';
comment on column CRM_SESSION.id_session
  is '�� ������';
comment on column CRM_SESSION.s_sessionkey
  is '���� ������';
comment on column CRM_SESSION.id_user
  is '�� ������������';
comment on column CRM_SESSION.d_created
  is '������������ ������';
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
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ORDERPRODUCT
prompt ==================================
prompt
create sequence SEQ_ORDERPRODUCT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
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
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRODUCT
prompt =============================
prompt
create sequence SEQ_PRODUCT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRODUCTTYPE
prompt =================================
prompt
create sequence SEQ_PRODUCTTYPE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
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
       CRM_PRODUCTTYPE.S_CAPTION as "producttype_caption"

  from CRM_PRODUCT
  join CRM_PRODUCTTYPE using (id_producttype);


prompt Done
spool off
set define on
