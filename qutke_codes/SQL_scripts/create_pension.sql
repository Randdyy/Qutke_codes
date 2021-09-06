-- Create table
create table FUND_PENSION_POSITION
(
  f_code        VARCHAR2(64),
  biz_date      VARCHAR2(8),
  rank          NUMBER(20),
  exchange_type VARCHAR2(64),
  stock_code    VARCHAR2(64),
  stock_name    VARCHAR2(64),
  manager       VARCHAR2(64),
  fund_type1    VARCHAR2(32),
  fund_type2    VARCHAR2(32),
  amount        NUMBER(20,4),
  balance       NUMBER(20,4),
  balance_ratio NUMBER(20,8),
  ref_code      VARCHAR2(64),
  updatetime    DATE default sysdate
)
tablespace tbs_maa_ftuser
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    next 1
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column FUND_PENSION_POSITION.f_code
  is '基金内部编码';
comment on column FUND_PENSION_POSITION.biz_date
  is '日期';
comment on column FUND_PENSION_POSITION.rank
  is '排名';
comment on column FUND_PENSION_POSITION.exchange_type
  is '市场类型';
comment on column FUND_PENSION_POSITION.stock_code
  is '证券代码';
comment on column FUND_PENSION_POSITION.stock_name
  is '证券名称';
comment on column FUND_PENSION_POSITION.manager
  is '管理人';
comment on column FUND_PENSION_POSITION.fund_type1
  is '基金类型1';
comment on column FUND_PENSION_POSITION.fund_type2
  is '基金类型2';
comment on column FUND_PENSION_POSITION.amount
  is '持仓数量';
comment on column FUND_PENSION_POSITION.balance
  is '持仓市值';
comment on column FUND_PENSION_POSITION.balance_ratio
  is '市值占比 ,指在养老金大类中的占比';
comment on column FUND_PENSION_POSITION.ref_code
  is '外部代码';
comment on column FUND_PENSION_POSITION.updatetime
  is '更新时间';
-- Create/Recreate indexes 
create index PK_FUND_PENSION_POSITION on FUND_PENSION_POSITION (F_CODE, BIZ_DATE)
  tablespace tbs_maa_ftuser
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
