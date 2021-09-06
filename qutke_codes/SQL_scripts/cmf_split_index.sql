CREATE or replace VIEW FT_TABLE25
AS
--create or replace view FT_TABLE25 as
select COMP_ID as FT11
      ,PROVINCE as FT12
      ,CITY as FT13
from maa_wind.CompIntroduction
WHERE COMP_ID IN (SELECT B_INFO_ISSUERCODE from maa_wind.CBondDescription)
;

--- 在 wind PK_CompIntroduction 中建索引
create index maa_wind.PK_CompIntroduction on CompIntroduction (COMP_ID)
  tablespace  tbs_maa_wind
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );





CREATE or replace VIEW FT_TABLE20
AS
--create or replace view FT_TABLE20 as
select S_INFO_WINDCODE as FT02
      ,REGEXP_SUBSTR(S_INFO_WINDCODE, '[^.]+') as FT03
      ,B_INFO_FULLNAME as FT11
      ,B_INFO_ISSUER as FT12
      ,B_INFO_COUPONRATE as FT13
      ,B_INFO_MATURITYDATE as FT14
      ,S_INFO_NAME as FT15
      ,S_INFO_EXCHMARKET as FT16
      ,B_INFO_LISTDATE as FT17
      ,B_INFO_DELISTDATE as FT18
      ,B_INFO_ISSUERCODE as FT19
      ,B_INFO_ISSUERTYPE as FT20
      ,B_INFO_TERM_YEAR_ as FT21
      ,B_INFO_SPECIALBONDTYPE as FT22
      ,IS_PAYADVANCED as FT23
      ,IS_CALLABLE as FT24
      ,IS_CHOOSERIGHT as FT25
      ,IS_NETPRICE as FT26
      ,IS_ACT_DAYS as FT27
      ,B_INFO_COUPONDATETXT as FT28
      ,B_INFO_GUARTYPE as FT29
      ,B_ISSUE_AMOUNTACT as FT30
      ,B_INFO_CARRYDATE as FT31
from maa_wind.CBondDescription
;
create index maa_wind.PK_FT02_PK_CBondDescription on CBondDescription (S_INFO_WINDCODE)
  tablespace  maa_wind
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index maa_wind.PK_FT03_PK_CBondDescription on CBondDescription (REGEXP_SUBSTR(S_INFO_WINDCODE, '[^.]+'))
  tablespace  maa_wind
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index maa_wind.PK_FT15_PK_CBondDescription on CBondDescription (S_INFO_NAME)
  tablespace  maa_wind
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index maa_wind.PK_FT16_PK_CBondDescription on CBondDescription (S_INFO_EXCHMARKET)
  tablespace  maa_wind
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );