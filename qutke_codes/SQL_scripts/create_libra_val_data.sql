create table ftuser.libra_val_data(
CMB_NO	    varchar2(64),
CMB_NAME	varchar2(64),
THE_DATE	varchar2(64),
SUBJECT_CODE	varchar2(64),
SUBJECT_NAME	varchar2(150),
HOLDING_UNITS	number(18),
UNIT_COST	number(18),
COST_VALUE	number(18),
COST_NET_WORTH_RATIO	number(18),
QUOTATION_PRICE	number(18),
MARKET_CAP	number(18),
MARKET_CAP_NET_WORTH_RATIO	number(18),
FAIRCOST	number(18),
DATA_TYPE number(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
