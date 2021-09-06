create index PK_FUND_EQ_POSITION on FUND_EQ_POSITION (BIZ_DATE, F_CODE, EXCHANGE_TYPE, STOCK_CODE)
  tablespace USERS
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
create index PK_FUND_EQ_POSITION_BDRC on FUND_EQ_POSITION (BIZ_DATE, REF_CODE)
  tablespace USERS
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
create index PK_FUND_EQ_POSITION_FC on FUND_EQ_POSITION (F_CODE)
  tablespace USERS
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
create index PK_FUND_EQ_POSITION_FCBDSC on FUND_EQ_POSITION (F_CODE, BIZ_DATE, STOCK_CODE)
  tablespace USERS
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

create index wind.ASHAREEODPRICES_IDX03 on wind.ASHAREEODPRICES (S_INFO_WINDCODE, TRADE_DT, S_DQ_CLOSE, S_DQ_ADJFACTOR, S_DQ_ADJCLOSE, S_DQ_VOLUME)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 584M
    next 4M
    minextents 1
    maxextents unlimited
  );
create index wind.IDX_ASHAREEODPRICES3 on wind.ASHAREEODPRICES (OPDATE)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 208M
    next 4M
    minextents 1
    maxextents unlimited
  );
create index wind.IDX_ASHAREEODPRICES_3 on wind.ASHAREEODPRICES (S_INFO_WINDCODE)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 188M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index wind.IDX_ASHEDOPRICES_1 on wind.ASHAREEODPRICES (S_INFO_WINDCODE, TRADE_DT)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index wind.IDX_ASHEDOPRICES_2 on wind.ASHAREEODPRICES (TRADE_DT)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index wind.I_ASHAREEODPRICES_2 on wind.ASHAREEODPRICES (TRADE_DT, S_INFO_WINDCODE)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 344M
    next 4M
    minextents 1
    maxextents unlimited
  );


create index wind.CBONDCURVECNBD_IDX01 on wind.CBONDCURVECNBD (TRADE_DT, B_ANAL_CURVENUMBER)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2448M
    next 4M
    minextents 1
    maxextents unlimited
  );

create index wind.HKSHAREEODPRICES_IDX01 on wind.HKSHAREEODPRICES (TRADE_DT, S_INFO_WINDCODE)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 260M
    next 4M
    minextents 1
    maxextents unlimited
  );


create index wind.CBONDPRICES_IDX01 on wind.CBONDPRICES (TRADE_DT, S_INFO_WINDCODE)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1968M
    next 4M
    minextents 1
    maxextents unlimited
  );