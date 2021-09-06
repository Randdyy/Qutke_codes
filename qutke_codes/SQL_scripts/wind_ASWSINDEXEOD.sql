-- Create table
create table wind.ASWSINDEXEOD
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  s_dq_preclose   NUMBER(20,4),
  s_dq_open       NUMBER(20,4),
  s_dq_high       NUMBER(20,4),
  s_dq_low        NUMBER(20,4),
  s_dq_close      NUMBER(20,4),
  s_dq_volume     NUMBER(20,4),
  s_dq_amount     NUMBER(20,4),
  s_val_pe        NUMBER(20,4),
  s_val_pb        NUMBER(20,4),
  s_dq_mv         NUMBER(20,4),
  s_val_mv        NUMBER(20,4),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
tablespace WIND
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
comment on column wind.ASWSINDEXEOD.object_id
  is '对象ID';
comment on column wind.ASWSINDEXEOD.s_info_windcode
  is '指数Wind代码';
comment on column wind.ASWSINDEXEOD.trade_dt
  is '交易日期';
comment on column wind.ASWSINDEXEOD.s_dq_preclose
  is '昨收盘价';
comment on column wind.ASWSINDEXEOD.s_dq_open
  is '开盘价';
comment on column wind.ASWSINDEXEOD.s_dq_high
  is '最高价';
comment on column wind.ASWSINDEXEOD.s_dq_low
  is '最低价';
comment on column wind.ASWSINDEXEOD.s_dq_close
  is '收盘价';
comment on column wind.ASWSINDEXEOD.s_dq_volume
  is '成交量(百股)';
comment on column wind.ASWSINDEXEOD.s_dq_amount
  is '成交金额(千元)';
comment on column wind.ASWSINDEXEOD.s_val_pe
  is '指数市盈率';
comment on column wind.ASWSINDEXEOD.s_val_pb
  is '指数市净率';
comment on column wind.ASWSINDEXEOD.s_dq_mv
  is 'A股流通市值(万元)';
comment on column wind.ASWSINDEXEOD.s_val_mv
  is '总市值(万元)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table wind.ASWSINDEXEOD
  add primary key (OBJECT_ID)
  using index 
  tablespace WIND
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
