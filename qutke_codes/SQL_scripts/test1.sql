-- Create table
create table maa_wind.HKSHAREEODDERIVATIVEINDEX
(
  object_id                   VARCHAR2(100) not null,
  s_info_windcode             VARCHAR2(40),
  financial_trade_dt          VARCHAR2(8),
  trade_crncy_code            VARCHAR2(10),
  tot_shr_today               NUMBER(20,4),
  float_a_shr_today           NUMBER(20,4),
  s_val_mv                    NUMBER(20,4),
  s_dq_mv                     NUMBER(20,4),
  s_dq_close_today            NUMBER(20,4),
  s_pq_high_52w               NUMBER(20,4),
  s_pq_low_52w                NUMBER(20,4),
  s_val_pb_new                NUMBER(20,4),
  s_val_pe_lyr                NUMBER(20,4),
  s_val_pe_ttm                NUMBER(20,4),
  s_val_pcf_ocflyr            NUMBER(20,4),
  s_val_pcf_ocfttm            NUMBER(20,4),
  s_val_pcf_ncflyr            NUMBER(20,4),
  s_val_pcf_ncfttm            NUMBER(20,4),
  s_val_ps_lyr                NUMBER(20,4),
  s_val_ps_ttm                NUMBER(20,4),
  s_dq_turn                   NUMBER(20,4),
  crncy_code                  VARCHAR2(10),
  net_assets_today            NUMBER(20,4),
  net_profit_parent_comp_lyr  NUMBER(20,4),
  net_profit_parent_comp_ttm  NUMBER(20,4),
  net_cash_flows_oper_act_lyr NUMBER(20,4),
  net_cash_flows_oper_act_ttm NUMBER(20,4),
  oper_rev_lyr                NUMBER(20,4),
  oper_rev_ttm                NUMBER(20,4),
  net_incr_cash_cash_equ_lyr  NUMBER(20,4),
  net_incr_cash_cash_equ_ttm  NUMBER(20,4),
  opdate                      DATE,
  opmode                      VARCHAR2(1)
)
tablespace tbs_maa_wind
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 4
    next 4
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.object_id
  is '对象ID';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_info_windcode
  is 'Wind代码';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.financial_trade_dt
  is '交易日期';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.trade_crncy_code
  is '交易币种代码';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.tot_shr_today
  is '当日总股本';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.float_a_shr_today
  is '当日流通股本';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_mv
  is '当日总市值';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_dq_mv
  is '当日流通市值';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_dq_close_today
  is '当日收盘价';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_pq_high_52w
  is '52周最高价';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_pq_low_52w
  is '52周最低价';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_pb_new
  is '市净率(PB)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_pe_lyr
  is '市盈率(PE,LYR)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_pe_ttm
  is '市盈率(PE,TTM)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_pcf_ocflyr
  is '市现率(经营现金流LYR)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_pcf_ocfttm
  is '市现率(经营现金流TTM)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_pcf_ncflyr
  is '市现率(现金净流量LYR)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_pcf_ncfttm
  is '市现率(现金净流量TTM)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_ps_lyr
  is '市销率(PS,LYR)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_val_ps_ttm
  is '市销率(PS,TTM)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.s_dq_turn
  is '换手率';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.crncy_code
  is '财务币种代码';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.net_assets_today
  is '当日净资产';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.net_profit_parent_comp_lyr
  is '归属母公司净利润(LYR)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.net_profit_parent_comp_ttm
  is '归属母公司净利润(TTM)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.net_cash_flows_oper_act_lyr
  is '经营活动产生的现金流量净额(LYR)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.net_cash_flows_oper_act_ttm
  is '经营活动产生的现金流量净额(TTM)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.oper_rev_lyr
  is '营业收入(LYR)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.oper_rev_ttm
  is '营业收入(TTM)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.net_incr_cash_cash_equ_lyr
  is '现金及现金等价物净增加额(LYR)';
comment on column maa_wind.HKSHAREEODDERIVATIVEINDEX.net_incr_cash_cash_equ_ttm
  is '现金及现金等价物净增加额(TTM)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table maa_wind.HKSHAREEODDERIVATIVEINDEX
  add primary key (OBJECT_ID)
  using index 
  tablespace tbs_maa_wind
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 4M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index maa_wind.IX_HKSHAREEODDERIVATIVEINDEX on maa_wind.HKSHAREEODDERIVATIVEINDEX (FINANCIAL_TRADE_DT)
  tablespace tbs_maa_wind
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 144M
    next 4M
    minextents 1
    maxextents unlimited
  );
create index maa_wind.PK_HKSHAREEODDERIVATIVEINDEX on maa_wind.HKSHAREEODDERIVATIVEINDEX (S_INFO_WINDCODE, FINANCIAL_TRADE_DT)
  tablespace tbs_maa_wind
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
