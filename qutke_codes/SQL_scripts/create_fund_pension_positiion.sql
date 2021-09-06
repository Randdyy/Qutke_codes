create table FUND_PENSION_POSITION
(
  F_CODE        VARCHAR2(64),
  BIZ_DATE      VARCHAR2(8),
  RANK          NUMBER(20),
  EXCHANGE_TYPE VARCHAR2(64),
  STOCK_CODE    VARCHAR2(64),
  STOCK_NAME    VARCHAR2(64),
  MANAGER       VARCHAR2(64),
  FUND_TYPE1    VARCHAR2(32),
  FUND_TYPE2    VARCHAR2(32),
  AMOUNT        NUMBER(20,4),
  BALANCE       NUMBER(20,4),
  BALANCE_RATIO NUMBER(20,8),
  REF_CODE      VARCHAR2(64),
  UPDATETIME    DATE default sysdate
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the columns 
comment on column FUND_PENSION_POSITION.F_CODE
  is '基金内部编码';
comment on column FUND_PENSION_POSITION.BIZ_DATE
  is '日期';
comment on column FUND_PENSION_POSITION.RANK
  is '排名';
comment on column FUND_PENSION_POSITION.EXCHANGE_TYPE
  is '市场类型';
comment on column FUND_PENSION_POSITION.STOCK_CODE
  is '证券代码';
comment on column FUND_PENSION_POSITION.STOCK_NAME
  is '证券名称';
comment on column FUND_PENSION_POSITION.MANAGER
  is '管理人';
comment on column FUND_PENSION_POSITION.FUND_TYPE1
  is '基金类型1';
comment on column FUND_PENSION_POSITION.FUND_TYPE2
  is '基金类型2';
comment on column FUND_PENSION_POSITION.AMOUNT
  is '持仓数量';
comment on column FUND_PENSION_POSITION.BALANCE
  is '持仓市值';
comment on column FUND_PENSION_POSITION.BALANCE_RATIO
  is '市值占比 ,指在养老金大类中的占比';
comment on column FUND_PENSION_POSITION.REF_CODE
  is '外部代码';
comment on column FUND_PENSION_POSITION.UPDATETIME
  is '更新时间';
-- Create/Recreate indexes 
create index PK_FUND_PENSION_POSITION on FUND_PENSION_POSITION (F_CODE, BIZ_DATE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
