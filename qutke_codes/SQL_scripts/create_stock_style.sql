-- Create table
create table maa_ftuser.STOCK_STYLE
(
  stock_code VARCHAR2(64),
  biz_date   VARCHAR2(8),
  quality    NUMBER(20,8),
  value      NUMBER(20,8),
  growth     NUMBER(20,8),
  momentum   NUMBER(20,8),
  liquidity  NUMBER(20,8),
  earning    NUMBER(20,8),
  leverage   NUMBER(20,8),
  sizen      NUMBER(20,8),
  volatility NUMBER(20,8),
  beta       NUMBER(20,8)
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
comment on column STOCK_STYLE.stock_code
  is '股票代码';
comment on column STOCK_STYLE.biz_date
  is '日期';
comment on column STOCK_STYLE.quality
  is '质量';
comment on column STOCK_STYLE.value
  is '价值';
comment on column STOCK_STYLE.growth
  is '成长';
comment on column STOCK_STYLE.momentum
  is '反转';
comment on column STOCK_STYLE.liquidity
  is '流动性';
comment on column STOCK_STYLE.earning
  is '盈利';
comment on column STOCK_STYLE.leverage
  is '杠杆';
comment on column STOCK_STYLE.sizen
  is '规模';
comment on column STOCK_STYLE.volatility
  is '波动性';
comment on column STOCK_STYLE.beta
  is 'Beta';
-- Create/Recreate indexes 
create index PK_STOCK_STYLE on STOCK_STYLE (BIZ_DATE, STOCK_CODE)
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
