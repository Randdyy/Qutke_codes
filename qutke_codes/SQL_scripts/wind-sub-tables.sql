create table ASHARECALENDAR
(
  object_id         VARCHAR2(100) not null,
  trade_days        VARCHAR2(8),
  s_info_exchmarket VARCHAR2(40),
  opdate            DATE,
  opmode            VARCHAR2(1)
)
;
comment on column ASHARECALENDAR.object_id
  is '对象ID';
comment on column ASHARECALENDAR.trade_days
  is '交易日';
comment on column ASHARECALENDAR.s_info_exchmarket
  is '交易所英文简称';
create index IDX_ASHARECALENDAR2 on ASHARECALENDAR (S_INFO_EXCHMARKET);
create index IDX_ASHRCALENDAR_1 on ASHARECALENDAR (S_INFO_EXCHMARKET, TRADE_DAYS);
create index IDX_ASHRCALENDAR_2 on ASHARECALENDAR (TRADE_DAYS);
alter table ASHARECALENDAR
  add primary key (OBJECT_ID);


create table ASHAREDESCRIPTION
(
  object_id            VARCHAR2(100) not null,
  s_info_windcode      VARCHAR2(40),
  s_info_code          VARCHAR2(40),
  s_info_name          VARCHAR2(50),
  s_info_compname      VARCHAR2(100),
  s_info_compnameeng   VARCHAR2(100),
  s_info_isincode      VARCHAR2(40),
  s_info_exchmarket    VARCHAR2(40),
  s_info_listboard     VARCHAR2(10),
  s_info_listdate      VARCHAR2(8),
  s_info_delistdate    VARCHAR2(8),
  s_info_sedolcode     VARCHAR2(40),
  crncy_code           VARCHAR2(10),
  s_info_pinyin        VARCHAR2(10),
  s_info_listboardname VARCHAR2(10),
  is_shsc              NUMBER(5),
  s_info_compcode      VARCHAR2(100),
  opdate               DATE,
  opmode               VARCHAR2(1)
)
;
comment on column ASHAREDESCRIPTION.object_id
  is '对象ID';
comment on column ASHAREDESCRIPTION.s_info_windcode
  is 'Wind代码';
comment on column ASHAREDESCRIPTION.s_info_code
  is '交易代码';
comment on column ASHAREDESCRIPTION.s_info_name
  is '证券简称';
comment on column ASHAREDESCRIPTION.s_info_compname
  is '公司中文名称';
comment on column ASHAREDESCRIPTION.s_info_compnameeng
  is '公司英文名称';
comment on column ASHAREDESCRIPTION.s_info_isincode
  is 'ISIN代码';
comment on column ASHAREDESCRIPTION.s_info_exchmarket
  is '交易所';
comment on column ASHAREDESCRIPTION.s_info_listboard
  is '上市板类型';
comment on column ASHAREDESCRIPTION.s_info_listdate
  is '上市日期';
comment on column ASHAREDESCRIPTION.s_info_delistdate
  is '退市日期';
comment on column ASHAREDESCRIPTION.crncy_code
  is '货币代码';
comment on column ASHAREDESCRIPTION.s_info_pinyin
  is '简称拼音';
comment on column ASHAREDESCRIPTION.s_info_listboardname
  is '上市板';
comment on column ASHAREDESCRIPTION.is_shsc
  is '是否在沪股通或深港通范围内';
comment on column ASHAREDESCRIPTION.s_info_compcode
  is '公司ID';
create index IDX_ASHAREDESCRIPTION1 on ASHAREDESCRIPTION (S_INFO_WINDCODE);
create index IDX_ASHAREDESCRIPTION2 on ASHAREDESCRIPTION (S_INFO_COMPNAME);
create index IDX_ASHAREDESCRIPTION3 on ASHAREDESCRIPTION (S_INFO_LISTBOARD);
alter table ASHAREDESCRIPTION
  add primary key (OBJECT_ID);


create table ASHAREEODPRICES
(
  object_id        VARCHAR2(100) not null,
  s_info_windcode  VARCHAR2(40),
  trade_dt         VARCHAR2(8),
  crncy_code       VARCHAR2(10),
  s_dq_preclose    NUMBER(20,4),
  s_dq_open        NUMBER(20,4),
  s_dq_high        NUMBER(20,4),
  s_dq_low         NUMBER(20,4),
  s_dq_close       NUMBER(20,4),
  s_dq_change      NUMBER(20,4),
  s_dq_pctchange   NUMBER(20,4),
  s_dq_volume      NUMBER(20,4),
  s_dq_amount      NUMBER(20,4),
  s_dq_adjpreclose NUMBER(20,4),
  s_dq_adjopen     NUMBER(20,4),
  s_dq_adjhigh     NUMBER(20,4),
  s_dq_adjlow      NUMBER(20,4),
  s_dq_adjclose    NUMBER(20,4),
  s_dq_adjfactor   NUMBER(20,6),
  s_dq_avgprice    NUMBER(20,4),
  s_dq_tradestatus VARCHAR2(10),
  opdate           DATE,
  opmode           VARCHAR2(1)
)
;
comment on column ASHAREEODPRICES.object_id
  is '对象ID';
comment on column ASHAREEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column ASHAREEODPRICES.trade_dt
  is '交易日期';
comment on column ASHAREEODPRICES.crncy_code
  is '货币代码';
comment on column ASHAREEODPRICES.s_dq_preclose
  is '昨收盘价(元)';
comment on column ASHAREEODPRICES.s_dq_open
  is '开盘价(元)';
comment on column ASHAREEODPRICES.s_dq_high
  is '最高价(元)';
comment on column ASHAREEODPRICES.s_dq_low
  is '最低价(元)';
comment on column ASHAREEODPRICES.s_dq_close
  is '收盘价(元)';
comment on column ASHAREEODPRICES.s_dq_change
  is '涨跌(元)';
comment on column ASHAREEODPRICES.s_dq_pctchange
  is '涨跌幅(%)';
comment on column ASHAREEODPRICES.s_dq_volume
  is '成交量(手)';
comment on column ASHAREEODPRICES.s_dq_amount
  is '成交金额(千元)';
comment on column ASHAREEODPRICES.s_dq_adjpreclose
  is '复权昨收盘价(元)';
comment on column ASHAREEODPRICES.s_dq_adjopen
  is '复权开盘价(元)';
comment on column ASHAREEODPRICES.s_dq_adjhigh
  is '复权最高价(元)';
comment on column ASHAREEODPRICES.s_dq_adjlow
  is '复权最低价(元)';
comment on column ASHAREEODPRICES.s_dq_adjclose
  is '复权收盘价(元)';
comment on column ASHAREEODPRICES.s_dq_adjfactor
  is '复权因子';
comment on column ASHAREEODPRICES.s_dq_avgprice
  is '均价(VWAP)';
comment on column ASHAREEODPRICES.s_dq_tradestatus
  is '交易状态';
create index IDX_ASHAREEODPRICES3 on ASHAREEODPRICES (OPDATE);
create index IDX_ASHAREEODPRICES_3 on ASHAREEODPRICES (S_INFO_WINDCODE);
create index IDX_ASHEDOPRICES_1 on ASHAREEODPRICES (S_INFO_WINDCODE, TRADE_DT);
create index IDX_ASHEDOPRICES_2 on ASHAREEODPRICES (TRADE_DT);
alter table ASHAREEODPRICES
  add primary key (OBJECT_ID);


create table ASHAREEODDERIVATIVEINDICATOR
(
  object_id                   VARCHAR2(100) not null,
  s_info_windcode             VARCHAR2(40),
  trade_dt                    VARCHAR2(8),
  crncy_code                  VARCHAR2(10),
  s_val_mv                    NUMBER(20,4),
  s_dq_mv                     NUMBER(20,4),
  s_pq_high_52w_              NUMBER(20,4),
  s_pq_low_52w_               NUMBER(20,4),
  s_val_pe                    NUMBER(20,4),
  s_val_pb_new                NUMBER(20,4),
  s_val_pe_ttm                NUMBER(20,4),
  s_val_pcf_ocf               NUMBER(20,4),
  s_val_pcf_ocfttm            NUMBER(20,4),
  s_val_pcf_ncf               NUMBER(20,4),
  s_val_pcf_ncfttm            NUMBER(20,4),
  s_val_ps                    NUMBER(20,4),
  s_val_ps_ttm                NUMBER(20,4),
  s_dq_turn                   NUMBER(20,4),
  s_dq_freeturnover           NUMBER(20,4),
  opdate                      DATE,
  opmode                      VARCHAR2(1),
  tot_shr_today               NUMBER(20,4),
  float_a_shr_today           NUMBER(20,4),
  s_dq_close_today            NUMBER(20,4),
  s_price_div_dps             NUMBER(20,4),
  s_pq_adjhigh_52w            NUMBER(20,4),
  s_pq_adjlow_52w             NUMBER(20,4),
  free_shares_today           NUMBER(20,4),
  net_profit_parent_comp_ttm  NUMBER(20,4),
  net_profit_parent_comp_lyr  NUMBER(20,4),
  net_assets_today            NUMBER(20,4),
  net_cash_flows_oper_act_ttm NUMBER(20,4),
  net_cash_flows_oper_act_lyr NUMBER(20,4),
  oper_rev_ttm                NUMBER(20,4),
  oper_rev_lyr                NUMBER(20,4),
  net_incr_cash_cash_equ_ttm  NUMBER(20,4),
  net_incr_cash_cash_equ_lyr  NUMBER(20,4),
  up_down_limit_status        NUMBER(2),
  lowest_highest_status       NUMBER(2)
)
;
comment on column ASHAREEODDERIVATIVEINDICATOR.object_id
  is '对象ID';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_info_windcode
  is 'Wind代码';
comment on column ASHAREEODDERIVATIVEINDICATOR.trade_dt
  is '交易日期';
comment on column ASHAREEODDERIVATIVEINDICATOR.crncy_code
  is '货币代码';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_mv
  is '当日总市值';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_dq_mv
  is '当日流通市值';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_pq_high_52w_
  is '52周最高价';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_pq_low_52w_
  is '52周最低价';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_pe
  is '市盈率(PE)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_pb_new
  is '市净率(PB)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_pe_ttm
  is '市盈率(PE,TTM)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_pcf_ocf
  is '市现率(PCF,经营现金流)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_pcf_ocfttm
  is '市现率(PCF,经营现金流TTM)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_pcf_ncf
  is '市现率(PCF,现金净流量)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_pcf_ncfttm
  is '市现率(PCF,现金净流量TTM)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_ps
  is '市销率(PS)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_val_ps_ttm
  is '市销率(PS,TTM)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_dq_turn
  is '换手率';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_dq_freeturnover
  is '换手率(基准.自由流通股本)';
comment on column ASHAREEODDERIVATIVEINDICATOR.tot_shr_today
  is '当日总股本';
comment on column ASHAREEODDERIVATIVEINDICATOR.float_a_shr_today
  is '当日流通股本';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_dq_close_today
  is '当日收盘价';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_price_div_dps
  is '股价/每股派息';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_pq_adjhigh_52w
  is '52周最高价(复权)';
comment on column ASHAREEODDERIVATIVEINDICATOR.s_pq_adjlow_52w
  is '52周最低价(复权)';
comment on column ASHAREEODDERIVATIVEINDICATOR.free_shares_today
  is '当日自由流通股本';
comment on column ASHAREEODDERIVATIVEINDICATOR.net_profit_parent_comp_ttm
  is '归属母公司净利润(TTM)';
comment on column ASHAREEODDERIVATIVEINDICATOR.net_profit_parent_comp_lyr
  is '归属母公司净利润(LYR)';
comment on column ASHAREEODDERIVATIVEINDICATOR.net_assets_today
  is '当日净资产';
comment on column ASHAREEODDERIVATIVEINDICATOR.net_cash_flows_oper_act_ttm
  is '经营活动产生的现金流量净额(TTM)';
comment on column ASHAREEODDERIVATIVEINDICATOR.net_cash_flows_oper_act_lyr
  is '经营活动产生的现金流量净额(LYR)';
comment on column ASHAREEODDERIVATIVEINDICATOR.oper_rev_ttm
  is '营业收入(TTM)';
comment on column ASHAREEODDERIVATIVEINDICATOR.oper_rev_lyr
  is '营业收入(LYR)';
comment on column ASHAREEODDERIVATIVEINDICATOR.net_incr_cash_cash_equ_ttm
  is '现金及现金等价物净增加额(TTM)';
comment on column ASHAREEODDERIVATIVEINDICATOR.net_incr_cash_cash_equ_lyr
  is '现金及现金等价物净增加额(LYR)';
comment on column ASHAREEODDERIVATIVEINDICATOR.up_down_limit_status
  is '涨跌停状态';
comment on column ASHAREEODDERIVATIVEINDICATOR.lowest_highest_status
  is '最高最低价状态';
create index IDX_ASHAREEODDERIVATIVE1 on ASHAREEODDERIVATIVEINDICATOR (S_INFO_WINDCODE);
create index IDX_SHAREEODIND_1 on ASHAREEODDERIVATIVEINDICATOR (S_INFO_WINDCODE, TRADE_DT);
create index IDX_SHAREEODIND_2 on ASHAREEODDERIVATIVEINDICATOR (TRADE_DT);
alter table ASHAREEODDERIVATIVEINDICATOR
  add primary key (OBJECT_ID);


create table ASHAREBALANCESHEET
(
  object_id                      VARCHAR2(100) not null,
  s_info_windcode                VARCHAR2(40),
  wind_code                      VARCHAR2(40),
  ann_dt                         VARCHAR2(8),
  report_period                  VARCHAR2(8),
  statement_type                 VARCHAR2(10),
  crncy_code                     VARCHAR2(10),
  monetary_cap                   NUMBER(20,4),
  tradable_fin_assets            NUMBER(20,4),
  notes_rcv                      NUMBER(20,4),
  acct_rcv                       NUMBER(20,4),
  oth_rcv                        NUMBER(20,4),
  prepay                         NUMBER(20,4),
  dvd_rcv                        NUMBER(20,4),
  int_rcv                        NUMBER(20,4),
  inventories                    NUMBER(20,4),
  consumptive_bio_assets         NUMBER(20,4),
  deferred_exp                   NUMBER(20,4),
  non_cur_assets_due_within_1y   NUMBER(20,4),
  settle_rsrv                    NUMBER(20,4),
  loans_to_oth_banks             NUMBER(20,4),
  prem_rcv                       NUMBER(20,4),
  rcv_from_reinsurer             NUMBER(20,4),
  rcv_from_ceded_insur_cont_rsrv NUMBER(20,4),
  red_monetary_cap_for_sale      NUMBER(20,4),
  oth_cur_assets                 NUMBER(20,4),
  tot_cur_assets                 NUMBER(20,4),
  fin_assets_avail_for_sale      NUMBER(20,4),
  held_to_mty_invest             NUMBER(20,4),
  long_term_eqy_invest           NUMBER(20,4),
  invest_real_estate             NUMBER(20,4),
  time_deposits                  NUMBER(20,4),
  oth_assets                     NUMBER(20,4),
  long_term_rec                  NUMBER(20,4),
  fix_assets                     NUMBER(20,4),
  const_in_prog                  NUMBER(20,4),
  proj_matl                      NUMBER(20,4),
  fix_assets_disp                NUMBER(20,4),
  productive_bio_assets          NUMBER(20,4),
  oil_and_natural_gas_assets     NUMBER(20,4),
  intang_assets                  NUMBER(20,4),
  r_and_d_costs                  NUMBER(20,4),
  goodwill                       NUMBER(20,4),
  long_term_deferred_exp         NUMBER(20,4),
  deferred_tax_assets            NUMBER(20,4),
  loans_and_adv_granted          NUMBER(20,4),
  oth_non_cur_assets             NUMBER(20,4),
  tot_non_cur_assets             NUMBER(20,4),
  cash_deposits_central_bank     NUMBER(20,4),
  asset_dep_oth_banks_fin_inst   NUMBER(20,4),
  precious_metals                NUMBER(20,4),
  derivative_fin_assets          NUMBER(20,4),
  agency_bus_assets              NUMBER(20,4),
  subr_rec                       NUMBER(20,4),
  rcv_ceded_unearned_prem_rsrv   NUMBER(20,4),
  rcv_ceded_claim_rsrv           NUMBER(20,4),
  rcv_ceded_life_insur_rsrv      NUMBER(20,4),
  rcv_ceded_lt_health_insur_rsrv NUMBER(20,4),
  mrgn_paid                      NUMBER(20,4),
  insured_pledge_loan            NUMBER(20,4),
  cap_mrgn_paid                  NUMBER(20,4),
  independent_acct_assets        NUMBER(20,4),
  clients_cap_deposit            NUMBER(20,4),
  clients_rsrv_settle            NUMBER(20,4),
  incl_seat_fees_exchange        NUMBER(20,4),
  rcv_invest                     NUMBER(20,4),
  tot_assets                     NUMBER(20,4),
  st_borrow                      NUMBER(20,4),
  borrow_central_bank            NUMBER(20,4),
  deposit_received_ib_deposits   NUMBER(20,4),
  loans_oth_banks                NUMBER(20,4),
  tradable_fin_liab              NUMBER(20,4),
  notes_payable                  NUMBER(20,4),
  acct_payable                   NUMBER(20,4),
  adv_from_cust                  NUMBER(20,4),
  fund_sales_fin_assets_rp       NUMBER(20,4),
  handling_charges_comm_payable  NUMBER(20,4),
  empl_ben_payable               NUMBER(20,4),
  taxes_surcharges_payable       NUMBER(20,4),
  int_payable                    NUMBER(20,4),
  dvd_payable                    NUMBER(20,4),
  oth_payable                    NUMBER(20,4),
  acc_exp                        NUMBER(20,4),
  deferred_inc                   NUMBER(20,4),
  st_bonds_payable               NUMBER(20,4),
  payable_to_reinsurer           NUMBER(20,4),
  rsrv_insur_cont                NUMBER(20,4),
  acting_trading_sec             NUMBER(20,4),
  acting_uw_sec                  NUMBER(20,4),
  non_cur_liab_due_within_1y     NUMBER(20,4),
  oth_cur_liab                   NUMBER(20,4),
  tot_cur_liab                   NUMBER(20,4),
  lt_borrow                      NUMBER(20,4),
  bonds_payable                  NUMBER(20,4),
  lt_payable                     NUMBER(20,4),
  specific_item_payable          NUMBER(20,4),
  provisions                     NUMBER(20,4),
  deferred_tax_liab              NUMBER(20,4),
  deferred_inc_non_cur_liab      NUMBER(20,4),
  oth_non_cur_liab               NUMBER(20,4),
  tot_non_cur_liab               NUMBER(20,4),
  liab_dep_oth_banks_fin_inst    NUMBER(20,4),
  derivative_fin_liab            NUMBER(20,4),
  cust_bank_dep                  NUMBER(20,4),
  agency_bus_liab                NUMBER(20,4),
  oth_liab                       NUMBER(20,4),
  prem_received_adv              NUMBER(20,4),
  deposit_received               NUMBER(20,4),
  insured_deposit_invest         NUMBER(20,4),
  unearned_prem_rsrv             NUMBER(20,4),
  out_loss_rsrv                  NUMBER(20,4),
  life_insur_rsrv                NUMBER(20,4),
  lt_health_insur_v              NUMBER(20,4),
  independent_acct_liab          NUMBER(20,4),
  incl_pledge_loan               NUMBER(20,4),
  claims_payable                 NUMBER(20,4),
  dvd_payable_insured            NUMBER(20,4),
  tot_liab                       NUMBER(20,4),
  cap_stk                        NUMBER(20,4),
  cap_rsrv                       NUMBER(20,4),
  special_rsrv                   NUMBER(20,4),
  surplus_rsrv                   NUMBER(20,4),
  undistributed_profit           NUMBER(20,4),
  less_tsy_stk                   NUMBER(20,4),
  prov_nom_risks                 NUMBER(20,4),
  cnvd_diff_foreign_curr_stat    NUMBER(20,4),
  unconfirmed_invest_loss        NUMBER(20,4),
  minority_int                   NUMBER(20,4),
  tot_shrhldr_eqy_excl_min_int   NUMBER(20,4),
  tot_shrhldr_eqy_incl_min_int   NUMBER(20,4),
  tot_liab_shrhldr_eqy           NUMBER(20,4),
  comp_type_code                 VARCHAR2(2),
  actual_ann_dt                  VARCHAR2(8),
  spe_cur_assets_diff            NUMBER(20,4),
  tot_cur_assets_diff            NUMBER(20,4),
  spe_non_cur_assets_diff        NUMBER(20,4),
  tot_non_cur_assets_diff        NUMBER(20,4),
  spe_bal_assets_diff            NUMBER(20,4),
  tot_bal_assets_diff            NUMBER(20,4),
  spe_cur_liab_diff              NUMBER(20,4),
  tot_cur_liab_diff              NUMBER(20,4),
  spe_non_cur_liab_diff          NUMBER(20,4),
  tot_non_cur_liab_diff          NUMBER(20,4),
  spe_bal_liab_diff              NUMBER(20,4),
  tot_bal_liab_diff              NUMBER(20,4),
  spe_bal_shrhldr_eqy_diff       NUMBER(20,4),
  tot_bal_shrhldr_eqy_diff       NUMBER(20,4),
  spe_bal_liab_eqy_diff          NUMBER(20,4),
  tot_bal_liab_eqy_diff          NUMBER(20,4),
  lt_payroll_payable             NUMBER(20,4),
  other_comp_income              NUMBER(20,4),
  other_equity_tools             NUMBER(20,4),
  other_equity_tools_p_shr       NUMBER(20,4),
  lending_funds                  NUMBER(20,4),
  accounts_receivable            NUMBER(20,4),
  st_financing_payable           NUMBER(20,4),
  payables                       NUMBER(20,4),
  s_info_compcode                VARCHAR2(10),
  tot_shr                        NUMBER(20,4),
  hfs_assets                     NUMBER(20,4),
  hfs_sales                      NUMBER(20,4),
  fin_assets_cost_sharing        NUMBER(20,4),
  fin_assets_fair_value          NUMBER(20,4),
  contractual_assets             NUMBER(20,4),
  contract_liabilities           NUMBER(20,4),
  accounts_receivable_bill       NUMBER(20,4),
  accounts_payable               NUMBER(20,4),
  oth_rcv_tot                    NUMBER(20,4),
  stm_bs_tot                     NUMBER(20,4),
  const_in_prog_tot              NUMBER(20,4),
  oth_payable_tot                NUMBER(20,4),
  lt_payable_tot                 NUMBER(20,4),
  debt_investment                NUMBER(20,4),
  other_debt_investment          NUMBER(20,4),
  other_equity_investment        NUMBER(20,4),
  other_illiquidfinancial_assets NUMBER(20,4),
  other_sustainable_bond         NUMBER(20,4),
  opdate                         DATE,
  opmode                         VARCHAR2(1)
)
;
comment on column ASHAREBALANCESHEET.object_id
  is '对象ID';
comment on column ASHAREBALANCESHEET.s_info_windcode
  is 'Wind代码';
comment on column ASHAREBALANCESHEET.wind_code
  is 'Wind代码';
comment on column ASHAREBALANCESHEET.ann_dt
  is '公告日期';
comment on column ASHAREBALANCESHEET.report_period
  is '报告期';
comment on column ASHAREBALANCESHEET.statement_type
  is '报表类型';
comment on column ASHAREBALANCESHEET.crncy_code
  is '货币代码';
comment on column ASHAREBALANCESHEET.monetary_cap
  is '货币资金';
comment on column ASHAREBALANCESHEET.tradable_fin_assets
  is '交易性金融资产';
comment on column ASHAREBALANCESHEET.notes_rcv
  is '应收票据';
comment on column ASHAREBALANCESHEET.acct_rcv
  is '应收账款';
comment on column ASHAREBALANCESHEET.oth_rcv
  is '其他应收款';
comment on column ASHAREBALANCESHEET.prepay
  is '预付款项';
comment on column ASHAREBALANCESHEET.dvd_rcv
  is '应收股利';
comment on column ASHAREBALANCESHEET.int_rcv
  is '应收利息';
comment on column ASHAREBALANCESHEET.inventories
  is '存货';
comment on column ASHAREBALANCESHEET.consumptive_bio_assets
  is '消耗性生物资产';
comment on column ASHAREBALANCESHEET.deferred_exp
  is '待摊费用';
comment on column ASHAREBALANCESHEET.non_cur_assets_due_within_1y
  is '一年内到期的非流动资产';
comment on column ASHAREBALANCESHEET.settle_rsrv
  is '结算备付金';
comment on column ASHAREBALANCESHEET.loans_to_oth_banks
  is '拆出资金';
comment on column ASHAREBALANCESHEET.prem_rcv
  is '应收保费';
comment on column ASHAREBALANCESHEET.rcv_from_reinsurer
  is '应收分保账款';
comment on column ASHAREBALANCESHEET.rcv_from_ceded_insur_cont_rsrv
  is '应收分保合同准备金';
comment on column ASHAREBALANCESHEET.red_monetary_cap_for_sale
  is '买入返售金融资产';
comment on column ASHAREBALANCESHEET.oth_cur_assets
  is '其他流动资产';
comment on column ASHAREBALANCESHEET.tot_cur_assets
  is '流动资产合计';
comment on column ASHAREBALANCESHEET.fin_assets_avail_for_sale
  is '可供出售金融资产';
comment on column ASHAREBALANCESHEET.held_to_mty_invest
  is '持有至到期投资';
comment on column ASHAREBALANCESHEET.long_term_eqy_invest
  is '长期股权投资';
comment on column ASHAREBALANCESHEET.invest_real_estate
  is '投资性房地产';
comment on column ASHAREBALANCESHEET.time_deposits
  is '定期存款';
comment on column ASHAREBALANCESHEET.oth_assets
  is '其他资产';
comment on column ASHAREBALANCESHEET.long_term_rec
  is '长期应收款';
comment on column ASHAREBALANCESHEET.fix_assets
  is '固定资产';
comment on column ASHAREBALANCESHEET.const_in_prog
  is '在建工程';
comment on column ASHAREBALANCESHEET.proj_matl
  is '工程物资';
comment on column ASHAREBALANCESHEET.fix_assets_disp
  is '固定资产清理';
comment on column ASHAREBALANCESHEET.productive_bio_assets
  is '生产性生物资产';
comment on column ASHAREBALANCESHEET.oil_and_natural_gas_assets
  is '油气资产';
comment on column ASHAREBALANCESHEET.intang_assets
  is '无形资产';
comment on column ASHAREBALANCESHEET.r_and_d_costs
  is '开发支出';
comment on column ASHAREBALANCESHEET.goodwill
  is '商誉';
comment on column ASHAREBALANCESHEET.long_term_deferred_exp
  is '长期待摊费用';
comment on column ASHAREBALANCESHEET.deferred_tax_assets
  is '递延所得税资产';
comment on column ASHAREBALANCESHEET.loans_and_adv_granted
  is '发放贷款及垫款';
comment on column ASHAREBALANCESHEET.oth_non_cur_assets
  is '其他非流动资产';
comment on column ASHAREBALANCESHEET.tot_non_cur_assets
  is '非流动资产合计';
comment on column ASHAREBALANCESHEET.cash_deposits_central_bank
  is '现金及存放中央银行款项';
comment on column ASHAREBALANCESHEET.asset_dep_oth_banks_fin_inst
  is '存放同业和其它金融机构款项';
comment on column ASHAREBALANCESHEET.precious_metals
  is '贵金属';
comment on column ASHAREBALANCESHEET.derivative_fin_assets
  is '衍生金融资产';
comment on column ASHAREBALANCESHEET.agency_bus_assets
  is '代理业务资产';
comment on column ASHAREBALANCESHEET.subr_rec
  is '应收代位追偿款';
comment on column ASHAREBALANCESHEET.rcv_ceded_unearned_prem_rsrv
  is '应收分保未到期责任准备金';
comment on column ASHAREBALANCESHEET.rcv_ceded_claim_rsrv
  is '应收分保未决赔款准备金';
comment on column ASHAREBALANCESHEET.rcv_ceded_life_insur_rsrv
  is '应收分保寿险责任准备金';
comment on column ASHAREBALANCESHEET.rcv_ceded_lt_health_insur_rsrv
  is '应收分保长期健康险责任准备金';
comment on column ASHAREBALANCESHEET.mrgn_paid
  is '存出保证金';
comment on column ASHAREBALANCESHEET.insured_pledge_loan
  is '保户质押贷款';
comment on column ASHAREBALANCESHEET.cap_mrgn_paid
  is '存出资本保证金';
comment on column ASHAREBALANCESHEET.independent_acct_assets
  is '独立账户资产';
comment on column ASHAREBALANCESHEET.clients_cap_deposit
  is '客户资金存款';
comment on column ASHAREBALANCESHEET.clients_rsrv_settle
  is '客户备付金';
comment on column ASHAREBALANCESHEET.incl_seat_fees_exchange
  is '其中:交易席位费';
comment on column ASHAREBALANCESHEET.rcv_invest
  is '应收款项类投资';
comment on column ASHAREBALANCESHEET.tot_assets
  is '资产总计';
comment on column ASHAREBALANCESHEET.st_borrow
  is '短期借款';
comment on column ASHAREBALANCESHEET.borrow_central_bank
  is '向中央银行借款';
comment on column ASHAREBALANCESHEET.deposit_received_ib_deposits
  is '吸收存款及同业存放';
comment on column ASHAREBALANCESHEET.loans_oth_banks
  is '拆入资金';
comment on column ASHAREBALANCESHEET.tradable_fin_liab
  is '交易性金融负债';
comment on column ASHAREBALANCESHEET.notes_payable
  is '应付票据';
comment on column ASHAREBALANCESHEET.acct_payable
  is '应付账款';
comment on column ASHAREBALANCESHEET.adv_from_cust
  is '预收款项';
comment on column ASHAREBALANCESHEET.fund_sales_fin_assets_rp
  is '卖出回购金融资产款';
comment on column ASHAREBALANCESHEET.handling_charges_comm_payable
  is '应付手续费及佣金';
comment on column ASHAREBALANCESHEET.empl_ben_payable
  is '应付职工薪酬';
comment on column ASHAREBALANCESHEET.taxes_surcharges_payable
  is '应交税费';
comment on column ASHAREBALANCESHEET.int_payable
  is '应付利息';
comment on column ASHAREBALANCESHEET.dvd_payable
  is '应付股利';
comment on column ASHAREBALANCESHEET.oth_payable
  is '其他应付款';
comment on column ASHAREBALANCESHEET.acc_exp
  is '预提费用';
comment on column ASHAREBALANCESHEET.deferred_inc
  is '递延收益';
comment on column ASHAREBALANCESHEET.st_bonds_payable
  is '应付短期债券';
comment on column ASHAREBALANCESHEET.payable_to_reinsurer
  is '应付分保账款';
comment on column ASHAREBALANCESHEET.rsrv_insur_cont
  is '保险合同准备金';
comment on column ASHAREBALANCESHEET.acting_trading_sec
  is '代理买卖证券款';
comment on column ASHAREBALANCESHEET.acting_uw_sec
  is '代理承销证券款';
comment on column ASHAREBALANCESHEET.non_cur_liab_due_within_1y
  is '一年内到期的非流动负债';
comment on column ASHAREBALANCESHEET.oth_cur_liab
  is '其他流动负债';
comment on column ASHAREBALANCESHEET.tot_cur_liab
  is '流动负债合计';
comment on column ASHAREBALANCESHEET.lt_borrow
  is '长期借款';
comment on column ASHAREBALANCESHEET.bonds_payable
  is '应付债券';
comment on column ASHAREBALANCESHEET.lt_payable
  is '长期应付款';
comment on column ASHAREBALANCESHEET.specific_item_payable
  is '专项应付款';
comment on column ASHAREBALANCESHEET.provisions
  is '预计负债';
comment on column ASHAREBALANCESHEET.deferred_tax_liab
  is '递延所得税负债';
comment on column ASHAREBALANCESHEET.deferred_inc_non_cur_liab
  is '递延收益-非流动负债';
comment on column ASHAREBALANCESHEET.oth_non_cur_liab
  is '其他非流动负债';
comment on column ASHAREBALANCESHEET.tot_non_cur_liab
  is '非流动负债合计';
comment on column ASHAREBALANCESHEET.liab_dep_oth_banks_fin_inst
  is '同业和其它金融机构存放款项';
comment on column ASHAREBALANCESHEET.derivative_fin_liab
  is '衍生金融负债';
comment on column ASHAREBALANCESHEET.cust_bank_dep
  is '吸收存款';
comment on column ASHAREBALANCESHEET.agency_bus_liab
  is '代理业务负债';
comment on column ASHAREBALANCESHEET.oth_liab
  is '其他负债';
comment on column ASHAREBALANCESHEET.prem_received_adv
  is '预收保费';
comment on column ASHAREBALANCESHEET.deposit_received
  is '存入保证金';
comment on column ASHAREBALANCESHEET.insured_deposit_invest
  is '保户储金及投资款';
comment on column ASHAREBALANCESHEET.unearned_prem_rsrv
  is '未到期责任准备金';
comment on column ASHAREBALANCESHEET.out_loss_rsrv
  is '未决赔款准备金';
comment on column ASHAREBALANCESHEET.life_insur_rsrv
  is '寿险责任准备金';
comment on column ASHAREBALANCESHEET.lt_health_insur_v
  is '长期健康险责任准备金';
comment on column ASHAREBALANCESHEET.independent_acct_liab
  is '独立账户负债';
comment on column ASHAREBALANCESHEET.incl_pledge_loan
  is '其中:质押借款';
comment on column ASHAREBALANCESHEET.claims_payable
  is '应付赔付款';
comment on column ASHAREBALANCESHEET.dvd_payable_insured
  is '应付保单红利';
comment on column ASHAREBALANCESHEET.tot_liab
  is '负债合计';
comment on column ASHAREBALANCESHEET.cap_stk
  is '股本';
comment on column ASHAREBALANCESHEET.cap_rsrv
  is '资本公积金';
comment on column ASHAREBALANCESHEET.special_rsrv
  is '专项储备';
comment on column ASHAREBALANCESHEET.surplus_rsrv
  is '盈余公积金';
comment on column ASHAREBALANCESHEET.undistributed_profit
  is '未分配利润';
comment on column ASHAREBALANCESHEET.less_tsy_stk
  is '减:库存股';
comment on column ASHAREBALANCESHEET.prov_nom_risks
  is '一般风险准备';
comment on column ASHAREBALANCESHEET.cnvd_diff_foreign_curr_stat
  is '外币报表折算差额';
comment on column ASHAREBALANCESHEET.unconfirmed_invest_loss
  is '未确认的投资损失';
comment on column ASHAREBALANCESHEET.minority_int
  is '少数股东权益';
comment on column ASHAREBALANCESHEET.tot_shrhldr_eqy_excl_min_int
  is '股东权益合计(不含少数股东权益)';
comment on column ASHAREBALANCESHEET.tot_shrhldr_eqy_incl_min_int
  is '股东权益合计(含少数股东权益)';
comment on column ASHAREBALANCESHEET.tot_liab_shrhldr_eqy
  is '负债及股东权益总计';
comment on column ASHAREBALANCESHEET.comp_type_code
  is '公司类型代码';
comment on column ASHAREBALANCESHEET.actual_ann_dt
  is '实际公告日期';
comment on column ASHAREBALANCESHEET.spe_cur_assets_diff
  is '流动资产差额(特殊报表科目)';
comment on column ASHAREBALANCESHEET.tot_cur_assets_diff
  is '流动资产差额(合计平衡项目)';
comment on column ASHAREBALANCESHEET.spe_non_cur_assets_diff
  is '非流动资产差额(特殊报表科目)';
comment on column ASHAREBALANCESHEET.tot_non_cur_assets_diff
  is '非流动资产差额(合计平衡项目)';
comment on column ASHAREBALANCESHEET.spe_bal_assets_diff
  is '资产差额(特殊报表科目)';
comment on column ASHAREBALANCESHEET.tot_bal_assets_diff
  is '资产差额(合计平衡项目)';
comment on column ASHAREBALANCESHEET.spe_cur_liab_diff
  is '流动负债差额(特殊报表科目)';
comment on column ASHAREBALANCESHEET.tot_cur_liab_diff
  is '流动负债差额(合计平衡项目)';
comment on column ASHAREBALANCESHEET.spe_non_cur_liab_diff
  is '非流动负债差额(特殊报表科目)';
comment on column ASHAREBALANCESHEET.tot_non_cur_liab_diff
  is '非流动负债差额(合计平衡项目)';
comment on column ASHAREBALANCESHEET.spe_bal_liab_diff
  is '负债差额(特殊报表科目)';
comment on column ASHAREBALANCESHEET.tot_bal_liab_diff
  is '负债差额(合计平衡项目)';
comment on column ASHAREBALANCESHEET.spe_bal_shrhldr_eqy_diff
  is '股东权益差额(特殊报表科目)';
comment on column ASHAREBALANCESHEET.tot_bal_shrhldr_eqy_diff
  is '股东权益差额(合计平衡项目)';
comment on column ASHAREBALANCESHEET.spe_bal_liab_eqy_diff
  is '负债及股东权益差额(特殊报表项目)';
comment on column ASHAREBALANCESHEET.tot_bal_liab_eqy_diff
  is '负债及股东权益差额(合计平衡项目)';
comment on column ASHAREBALANCESHEET.lt_payroll_payable
  is '长期应付职工薪酬';
comment on column ASHAREBALANCESHEET.other_comp_income
  is '其他综合收益';
comment on column ASHAREBALANCESHEET.other_equity_tools
  is '其他权益工具';
comment on column ASHAREBALANCESHEET.other_equity_tools_p_shr
  is '其他权益工具:优先股';
comment on column ASHAREBALANCESHEET.lending_funds
  is '融出资金';
comment on column ASHAREBALANCESHEET.accounts_receivable
  is '应收款项';
comment on column ASHAREBALANCESHEET.st_financing_payable
  is '应付短期融资款';
comment on column ASHAREBALANCESHEET.payables
  is '应付款项';
comment on column ASHAREBALANCESHEET.s_info_compcode
  is '公司ID';
comment on column ASHAREBALANCESHEET.tot_shr
  is '期末总股本';
comment on column ASHAREBALANCESHEET.hfs_assets
  is '持有待售的资产';
comment on column ASHAREBALANCESHEET.hfs_sales
  is '持有待售的负债';
comment on column ASHAREBALANCESHEET.fin_assets_cost_sharing
  is '以摊余成本计量的金融资产';
comment on column ASHAREBALANCESHEET.fin_assets_fair_value
  is '以公允价值计量且其变动计入其他综合收益的金融资产';
comment on column ASHAREBALANCESHEET.contractual_assets
  is '合同资产';
comment on column ASHAREBALANCESHEET.contract_liabilities
  is '合同负债';
comment on column ASHAREBALANCESHEET.accounts_receivable_bill
  is '应收票据及应收账款';
comment on column ASHAREBALANCESHEET.accounts_payable
  is '应付票据及应付账款';
comment on column ASHAREBALANCESHEET.oth_rcv_tot
  is '其他应收款(合计)（元）';
comment on column ASHAREBALANCESHEET.stm_bs_tot
  is '固定资产(合计)(元)';
comment on column ASHAREBALANCESHEET.const_in_prog_tot
  is '在建工程(合计)(元)';
comment on column ASHAREBALANCESHEET.oth_payable_tot
  is '其他应付款(合计)(元)';
comment on column ASHAREBALANCESHEET.lt_payable_tot
  is '长期应付款(合计)(元)';
comment on column ASHAREBALANCESHEET.debt_investment
  is '债权投资(元)';
comment on column ASHAREBALANCESHEET.other_debt_investment
  is '其他债权投资(元)';
comment on column ASHAREBALANCESHEET.other_equity_investment
  is '其他权益工具投资(元)';
comment on column ASHAREBALANCESHEET.other_illiquidfinancial_assets
  is '其他非流动金融资产(元)';
comment on column ASHAREBALANCESHEET.other_sustainable_bond
  is '其他权益工具:永续债(元)';
create index IDX_ASHAREBALANCESHEET1 on ASHAREBALANCESHEET (S_INFO_WINDCODE);
create index IDX_ASHAREBALANCESHEET2 on ASHAREBALANCESHEET (STATEMENT_TYPE);
create index IDX_ASHAREBALANCESHEET3 on ASHAREBALANCESHEET (REPORT_PERIOD);
alter table ASHAREBALANCESHEET
  add primary key (OBJECT_ID);


create table ASHAREINCOME
(
  object_id                     VARCHAR2(100) not null,
  s_info_windcode               VARCHAR2(40),
  wind_code                     VARCHAR2(40),
  ann_dt                        VARCHAR2(8),
  report_period                 VARCHAR2(8),
  statement_type                VARCHAR2(10),
  crncy_code                    VARCHAR2(10),
  tot_oper_rev                  NUMBER(20,4),
  oper_rev                      NUMBER(20,4),
  int_inc                       NUMBER(20,4),
  net_int_inc                   NUMBER(20,4),
  insur_prem_unearned           NUMBER(20,4),
  handling_chrg_comm_inc        NUMBER(20,4),
  net_handling_chrg_comm_inc    NUMBER(20,4),
  net_inc_other_ops             NUMBER(20,4),
  plus_net_inc_other_bus        NUMBER(20,4),
  prem_inc                      NUMBER(20,4),
  less_ceded_out_prem           NUMBER(20,4),
  chg_unearned_prem_res         NUMBER(20,4),
  incl_reinsurance_prem_inc     NUMBER(20,4),
  net_inc_sec_trading_brok_bus  NUMBER(20,4),
  net_inc_sec_uw_bus            NUMBER(20,4),
  net_inc_ec_asset_mgmt_bus     NUMBER(20,4),
  other_bus_inc                 NUMBER(20,4),
  plus_net_gain_chg_fv          NUMBER(20,4),
  plus_net_invest_inc           NUMBER(20,4),
  incl_inc_invest_assoc_jv_entp NUMBER(20,4),
  plus_net_gain_fx_trans        NUMBER(20,4),
  tot_oper_cost                 NUMBER(20,4),
  less_oper_cost                NUMBER(20,4),
  less_int_exp                  NUMBER(20,4),
  less_handling_chrg_comm_exp   NUMBER(20,4),
  less_taxes_surcharges_ops     NUMBER(20,4),
  less_selling_dist_exp         NUMBER(20,4),
  less_gerl_admin_exp           NUMBER(20,4),
  less_fin_exp                  NUMBER(20,4),
  less_impair_loss_assets       NUMBER(20,4),
  prepay_surr                   NUMBER(20,4),
  tot_claim_exp                 NUMBER(20,4),
  chg_insur_cont_rsrv           NUMBER(20,4),
  dvd_exp_insured               NUMBER(20,4),
  reinsurance_exp               NUMBER(20,4),
  oper_exp                      NUMBER(20,4),
  less_claim_recb_reinsurer     NUMBER(20,4),
  less_ins_rsrv_recb_reinsurer  NUMBER(20,4),
  less_exp_recb_reinsurer       NUMBER(20,4),
  other_bus_cost                NUMBER(20,4),
  oper_profit                   NUMBER(20,4),
  plus_non_oper_rev             NUMBER(20,4),
  less_non_oper_exp             NUMBER(20,4),
  il_net_loss_disp_noncur_asset NUMBER(20,4),
  tot_profit                    NUMBER(20,4),
  inc_tax                       NUMBER(20,4),
  unconfirmed_invest_loss       NUMBER(20,4),
  net_profit_incl_min_int_inc   NUMBER(20,4),
  net_profit_excl_min_int_inc   NUMBER(20,4),
  minority_int_inc              NUMBER(20,4),
  other_compreh_inc             NUMBER(20,4),
  tot_compreh_inc               NUMBER(20,4),
  tot_compreh_inc_parent_comp   NUMBER(20,4),
  tot_compreh_inc_min_shrhldr   NUMBER(20,4),
  ebit                          NUMBER(20,4),
  ebitda                        NUMBER(20,4),
  net_profit_after_ded_nr_lp    NUMBER(20,4),
  net_profit_under_intl_acc_sta NUMBER(20,4),
  comp_type_code                VARCHAR2(2),
  s_fa_eps_basic                NUMBER(20,4),
  s_fa_eps_diluted              NUMBER(20,4),
  actual_ann_dt                 VARCHAR2(8),
  insurance_expense             NUMBER(20,4),
  spe_bal_oper_profit           NUMBER(20,4),
  tot_bal_oper_profit           NUMBER(20,4),
  spe_bal_tot_profit            NUMBER(20,4),
  tot_bal_tot_profit            NUMBER(20,4),
  spe_bal_net_profit            NUMBER(20,4),
  tot_bal_net_profit            NUMBER(20,4),
  undistributed_profit          NUMBER(20,4),
  adjlossgain_prevyear          NUMBER(20,4),
  transfer_from_surplusreserve  NUMBER(20,4),
  transfer_from_housingimprest  NUMBER(20,4),
  transfer_from_others          NUMBER(20,4),
  distributable_profit          NUMBER(20,4),
  withdr_legalsurplus           NUMBER(20,4),
  withdr_legalpubwelfunds       NUMBER(20,4),
  workers_welfare               NUMBER(20,4),
  withdr_buzexpwelfare          NUMBER(20,4),
  withdr_reservefund            NUMBER(20,4),
  distributable_profit_shrhder  NUMBER(20,4),
  prfshare_dvd_payable          NUMBER(20,4),
  withdr_othersurpreserve       NUMBER(20,4),
  comshare_dvd_payable          NUMBER(20,4),
  capitalized_comstock_div      NUMBER(20,4),
  s_info_compcode               VARCHAR2(10),
  net_after_ded_nr_lp_correct   NUMBER(20,4),
  other_income                  NUMBER(20,4),
  memo                          VARCHAR2(1000),
  asset_disposal_income         NUMBER(20,4),
  continued_net_profit          NUMBER(20,4),
  end_net_profit                NUMBER(20,4),
  credit_impairment_loss        NUMBER(20,4),
  net_exposure_hedging_benefits NUMBER(20,4),
  rd_expense                    NUMBER(20,4),
  stmnote_finexp                NUMBER(20,4),
  fin_exp_int_inc               NUMBER(20,4),
  opdate                        DATE,
  opmode                        VARCHAR2(1)
)
;
comment on column ASHAREINCOME.object_id
  is '对象ID';
comment on column ASHAREINCOME.s_info_windcode
  is 'Wind代码';
comment on column ASHAREINCOME.wind_code
  is 'Wind代码';
comment on column ASHAREINCOME.ann_dt
  is '公告日期';
comment on column ASHAREINCOME.report_period
  is '报告期';
comment on column ASHAREINCOME.statement_type
  is '报表类型';
comment on column ASHAREINCOME.crncy_code
  is '货币代码';
comment on column ASHAREINCOME.tot_oper_rev
  is '营业总收入';
comment on column ASHAREINCOME.oper_rev
  is '营业收入';
comment on column ASHAREINCOME.int_inc
  is '利息收入';
comment on column ASHAREINCOME.net_int_inc
  is '利息净收入';
comment on column ASHAREINCOME.insur_prem_unearned
  is '已赚保费';
comment on column ASHAREINCOME.handling_chrg_comm_inc
  is '手续费及佣金收入';
comment on column ASHAREINCOME.net_handling_chrg_comm_inc
  is '手续费及佣金净收入';
comment on column ASHAREINCOME.net_inc_other_ops
  is '其他经营净收益';
comment on column ASHAREINCOME.plus_net_inc_other_bus
  is '加:其他业务净收益';
comment on column ASHAREINCOME.prem_inc
  is '保费业务收入';
comment on column ASHAREINCOME.less_ceded_out_prem
  is '减:分出保费';
comment on column ASHAREINCOME.chg_unearned_prem_res
  is '提取未到期责任准备金';
comment on column ASHAREINCOME.incl_reinsurance_prem_inc
  is '其中:分保费收入';
comment on column ASHAREINCOME.net_inc_sec_trading_brok_bus
  is '代理买卖证券业务净收入';
comment on column ASHAREINCOME.net_inc_sec_uw_bus
  is '证券承销业务净收入';
comment on column ASHAREINCOME.net_inc_ec_asset_mgmt_bus
  is '受托客户资产管理业务净收入';
comment on column ASHAREINCOME.other_bus_inc
  is '其他业务收入';
comment on column ASHAREINCOME.plus_net_gain_chg_fv
  is '加:公允价值变动净收益';
comment on column ASHAREINCOME.plus_net_invest_inc
  is '加:投资净收益';
comment on column ASHAREINCOME.incl_inc_invest_assoc_jv_entp
  is '其中:对联营企业和合营企业的投资收益';
comment on column ASHAREINCOME.plus_net_gain_fx_trans
  is '加:汇兑净收益';
comment on column ASHAREINCOME.tot_oper_cost
  is '营业总成本';
comment on column ASHAREINCOME.less_oper_cost
  is '减:营业成本';
comment on column ASHAREINCOME.less_int_exp
  is '减:利息支出';
comment on column ASHAREINCOME.less_handling_chrg_comm_exp
  is '减:手续费及佣金支出';
comment on column ASHAREINCOME.less_taxes_surcharges_ops
  is '减:营业税金及附加';
comment on column ASHAREINCOME.less_selling_dist_exp
  is '减:销售费用';
comment on column ASHAREINCOME.less_gerl_admin_exp
  is '减:管理费用';
comment on column ASHAREINCOME.less_fin_exp
  is '减:财务费用';
comment on column ASHAREINCOME.less_impair_loss_assets
  is '减:资产减值损失';
comment on column ASHAREINCOME.prepay_surr
  is '退保金';
comment on column ASHAREINCOME.tot_claim_exp
  is '赔付总支出';
comment on column ASHAREINCOME.chg_insur_cont_rsrv
  is '提取保险责任准备金';
comment on column ASHAREINCOME.dvd_exp_insured
  is '保户红利支出';
comment on column ASHAREINCOME.reinsurance_exp
  is '分保费用';
comment on column ASHAREINCOME.oper_exp
  is '营业支出';
comment on column ASHAREINCOME.less_claim_recb_reinsurer
  is '减:摊回赔付支出';
comment on column ASHAREINCOME.less_ins_rsrv_recb_reinsurer
  is '减:摊回保险责任准备金';
comment on column ASHAREINCOME.less_exp_recb_reinsurer
  is '减:摊回分保费用';
comment on column ASHAREINCOME.other_bus_cost
  is '其他业务成本';
comment on column ASHAREINCOME.oper_profit
  is '营业利润';
comment on column ASHAREINCOME.plus_non_oper_rev
  is '加:营业外收入';
comment on column ASHAREINCOME.less_non_oper_exp
  is '减:营业外支出';
comment on column ASHAREINCOME.il_net_loss_disp_noncur_asset
  is '其中:减:非流动资产处置净损失';
comment on column ASHAREINCOME.tot_profit
  is '利润总额';
comment on column ASHAREINCOME.inc_tax
  is '所得税';
comment on column ASHAREINCOME.unconfirmed_invest_loss
  is '未确认投资损失';
comment on column ASHAREINCOME.net_profit_incl_min_int_inc
  is '净利润(含少数股东损益)';
comment on column ASHAREINCOME.net_profit_excl_min_int_inc
  is '净利润(不含少数股东损益)';
comment on column ASHAREINCOME.minority_int_inc
  is '少数股东损益';
comment on column ASHAREINCOME.other_compreh_inc
  is '其他综合收益';
comment on column ASHAREINCOME.tot_compreh_inc
  is '综合收益总额';
comment on column ASHAREINCOME.tot_compreh_inc_parent_comp
  is '综合收益总额(母公司)';
comment on column ASHAREINCOME.tot_compreh_inc_min_shrhldr
  is '综合收益总额(少数股东)';
comment on column ASHAREINCOME.ebit
  is '息税前利润';
comment on column ASHAREINCOME.ebitda
  is '息税折旧摊销前利润';
comment on column ASHAREINCOME.net_profit_after_ded_nr_lp
  is '扣除非经常性损益后净利润（扣除少数股东损益）';
comment on column ASHAREINCOME.net_profit_under_intl_acc_sta
  is '国际会计准则净利润';
comment on column ASHAREINCOME.comp_type_code
  is '公司类型代码';
comment on column ASHAREINCOME.s_fa_eps_basic
  is '基本每股收益';
comment on column ASHAREINCOME.s_fa_eps_diluted
  is '稀释每股收益';
comment on column ASHAREINCOME.actual_ann_dt
  is '实际公告日期';
comment on column ASHAREINCOME.insurance_expense
  is '保险业务支出';
comment on column ASHAREINCOME.spe_bal_oper_profit
  is '营业利润差额(特殊报表科目)';
comment on column ASHAREINCOME.tot_bal_oper_profit
  is '营业利润差额(合计平衡项目)';
comment on column ASHAREINCOME.spe_bal_tot_profit
  is '利润总额差额(特殊报表科目)';
comment on column ASHAREINCOME.tot_bal_tot_profit
  is '利润总额差额(合计平衡项目)';
comment on column ASHAREINCOME.spe_bal_net_profit
  is '净利润差额(特殊报表科目)';
comment on column ASHAREINCOME.tot_bal_net_profit
  is '净利润差额(合计平衡项目)';
comment on column ASHAREINCOME.undistributed_profit
  is '年初未分配利润';
comment on column ASHAREINCOME.adjlossgain_prevyear
  is '调整以前年度损益';
comment on column ASHAREINCOME.transfer_from_surplusreserve
  is '盈余公积转入';
comment on column ASHAREINCOME.transfer_from_housingimprest
  is '住房周转金转入';
comment on column ASHAREINCOME.transfer_from_others
  is '其他转入';
comment on column ASHAREINCOME.distributable_profit
  is '可分配利润';
comment on column ASHAREINCOME.withdr_legalsurplus
  is '提取法定盈余公积';
comment on column ASHAREINCOME.withdr_legalpubwelfunds
  is '提取法定公益金';
comment on column ASHAREINCOME.workers_welfare
  is '职工奖金福利';
comment on column ASHAREINCOME.withdr_buzexpwelfare
  is '提取企业发展基金';
comment on column ASHAREINCOME.withdr_reservefund
  is '提取储备基金';
comment on column ASHAREINCOME.distributable_profit_shrhder
  is '可供股东分配的利润';
comment on column ASHAREINCOME.prfshare_dvd_payable
  is '应付优先股股利';
comment on column ASHAREINCOME.withdr_othersurpreserve
  is '提取任意盈余公积金';
comment on column ASHAREINCOME.comshare_dvd_payable
  is '应付普通股股利';
comment on column ASHAREINCOME.capitalized_comstock_div
  is '转作股本的普通股股利';
comment on column ASHAREINCOME.s_info_compcode
  is '公司ID';
comment on column ASHAREINCOME.net_after_ded_nr_lp_correct
  is '扣除非经常性损益后的净利润(财务重要指标(更正前))';
comment on column ASHAREINCOME.other_income
  is '其他收益';
comment on column ASHAREINCOME.memo
  is '备注';
comment on column ASHAREINCOME.asset_disposal_income
  is '资产处置收益';
comment on column ASHAREINCOME.continued_net_profit
  is '持续经营净利润';
comment on column ASHAREINCOME.end_net_profit
  is '终止经营净利润';
comment on column ASHAREINCOME.credit_impairment_loss
  is '信用减值损失';
comment on column ASHAREINCOME.net_exposure_hedging_benefits
  is '净敞口套期收益';
comment on column ASHAREINCOME.rd_expense
  is '研发费用';
comment on column ASHAREINCOME.stmnote_finexp
  is '财务费用:利息费用';
comment on column ASHAREINCOME.fin_exp_int_inc
  is '财务费用:利息收入';
create index IDX_ASHAREINCOME1 on ASHAREINCOME (S_INFO_WINDCODE);
alter table ASHAREINCOME
  add primary key (OBJECT_ID);


create table ASHARECASHFLOW
(
  object_id                      VARCHAR2(100) not null,
  s_info_windcode                VARCHAR2(40),
  wind_code                      VARCHAR2(40),
  ann_dt                         VARCHAR2(8),
  report_period                  VARCHAR2(8),
  statement_type                 VARCHAR2(10),
  crncy_code                     VARCHAR2(10),
  cash_recp_sg_and_rs            NUMBER(20,4),
  recp_tax_rends                 NUMBER(20,4),
  net_incr_dep_cob               NUMBER(20,4),
  net_incr_loans_central_bank    NUMBER(20,4),
  net_incr_fund_borr_ofi         NUMBER(20,4),
  cash_recp_prem_orig_inco       NUMBER(20,4),
  net_incr_insured_dep           NUMBER(20,4),
  net_cash_received_reinsu_bus   NUMBER(20,4),
  net_incr_disp_tfa              NUMBER(20,4),
  net_incr_int_handling_chrg     NUMBER(20,4),
  net_incr_disp_faas             NUMBER(20,4),
  net_incr_loans_other_bank      NUMBER(20,4),
  net_incr_repurch_bus_fund      NUMBER(20,4),
  other_cash_recp_ral_oper_act   NUMBER(20,4),
  stot_cash_inflows_oper_act     NUMBER(20,4),
  cash_pay_goods_purch_serv_rec  NUMBER(20,4),
  cash_pay_beh_empl              NUMBER(20,4),
  pay_all_typ_tax                NUMBER(20,4),
  net_incr_clients_loan_adv      NUMBER(20,4),
  net_incr_dep_cbob              NUMBER(20,4),
  cash_pay_claims_orig_inco      NUMBER(20,4),
  handling_chrg_paid             NUMBER(20,4),
  comm_insur_plcy_paid           NUMBER(20,4),
  other_cash_pay_ral_oper_act    NUMBER(20,4),
  stot_cash_outflows_oper_act    NUMBER(20,4),
  net_cash_flows_oper_act        NUMBER(20,4),
  cash_recp_disp_withdrwl_invest NUMBER(20,4),
  cash_recp_return_invest        NUMBER(20,4),
  net_cash_recp_disp_fiolta      NUMBER(20,4),
  net_cash_recp_disp_sobu        NUMBER(20,4),
  other_cash_recp_ral_inv_act    NUMBER(20,4),
  stot_cash_inflows_inv_act      NUMBER(20,4),
  cash_pay_acq_const_fiolta      NUMBER(20,4),
  cash_paid_invest               NUMBER(20,4),
  net_cash_pay_aquis_sobu        NUMBER(20,4),
  other_cash_pay_ral_inv_act     NUMBER(20,4),
  net_incr_pledge_loan           NUMBER(20,4),
  stot_cash_outflows_inv_act     NUMBER(20,4),
  net_cash_flows_inv_act         NUMBER(20,4),
  cash_recp_cap_contrib          NUMBER(20,4),
  incl_cash_rec_saims            NUMBER(20,4),
  cash_recp_borrow               NUMBER(20,4),
  proc_issue_bonds               NUMBER(20,4),
  other_cash_recp_ral_fnc_act    NUMBER(20,4),
  stot_cash_inflows_fnc_act      NUMBER(20,4),
  cash_prepay_amt_borr           NUMBER(20,4),
  cash_pay_dist_dpcp_int_exp     NUMBER(20,4),
  incl_dvd_profit_paid_sc_ms     NUMBER(20,4),
  other_cash_pay_ral_fnc_act     NUMBER(20,4),
  stot_cash_outflows_fnc_act     NUMBER(20,4),
  net_cash_flows_fnc_act         NUMBER(20,4),
  eff_fx_flu_cash                NUMBER(20,4),
  net_incr_cash_cash_equ         NUMBER(20,4),
  cash_cash_equ_beg_period       NUMBER(20,4),
  cash_cash_equ_end_period       NUMBER(20,4),
  net_profit                     NUMBER(20,4),
  unconfirmed_invest_loss        NUMBER(20,4),
  plus_prov_depr_assets          NUMBER(20,4),
  depr_fa_coga_dpba              NUMBER(20,4),
  amort_intang_assets            NUMBER(20,4),
  amort_lt_deferred_exp          NUMBER(20,4),
  decr_deferred_exp              NUMBER(20,4),
  incr_acc_exp                   NUMBER(20,4),
  loss_disp_fiolta               NUMBER(20,4),
  loss_scr_fa                    NUMBER(20,4),
  loss_fv_chg                    NUMBER(20,4),
  fin_exp                        NUMBER(20,4),
  invest_loss                    NUMBER(20,4),
  decr_deferred_inc_tax_assets   NUMBER(20,4),
  incr_deferred_inc_tax_liab     NUMBER(20,4),
  decr_inventories               NUMBER(20,4),
  decr_oper_payable              NUMBER(20,4),
  incr_oper_payable              NUMBER(20,4),
  others                         NUMBER(20,4),
  im_net_cash_flows_oper_act     NUMBER(20,4),
  conv_debt_into_cap             NUMBER(20,4),
  conv_corp_bonds_due_within_1y  NUMBER(20,4),
  fa_fnc_leases                  NUMBER(20,4),
  end_bal_cash                   NUMBER(20,4),
  less_beg_bal_cash              NUMBER(20,4),
  plus_end_bal_cash_equ          NUMBER(20,4),
  less_beg_bal_cash_equ          NUMBER(20,4),
  im_net_incr_cash_cash_equ      NUMBER(20,4),
  free_cash_flow                 NUMBER(20,4),
  comp_type_code                 VARCHAR2(2),
  actual_ann_dt                  VARCHAR2(8),
  spe_bal_cash_inflows_oper      NUMBER(20,4),
  tot_bal_cash_inflows_oper      NUMBER(20,4),
  spe_bal_cash_outflows_oper     NUMBER(20,4),
  tot_bal_cash_outflows_oper     NUMBER(20,4),
  tot_bal_netcash_outflows_oper  NUMBER(20,4),
  spe_bal_cash_inflows_inv       NUMBER(20,4),
  tot_bal_cash_inflows_inv       NUMBER(20,4),
  spe_bal_cash_outflows_inv      NUMBER(20,4),
  tot_bal_cash_outflows_inv      NUMBER(20,4),
  tot_bal_netcash_outflows_inv   NUMBER(20,4),
  spe_bal_cash_inflows_fnc       NUMBER(20,4),
  tot_bal_cash_inflows_fnc       NUMBER(20,4),
  spe_bal_cash_outflows_fnc      NUMBER(20,4),
  tot_bal_cash_outflows_fnc      NUMBER(20,4),
  tot_bal_netcash_outflows_fnc   NUMBER(20,4),
  spe_bal_netcash_inc            NUMBER(20,4),
  tot_bal_netcash_inc            NUMBER(20,4),
  spe_bal_netcash_equ_undir      NUMBER(20,4),
  tot_bal_netcash_equ_undir      NUMBER(20,4),
  spe_bal_netcash_inc_undir      NUMBER(20,4),
  tot_bal_netcash_inc_undir      NUMBER(20,4),
  s_info_compcode                VARCHAR2(10),
  s_dismantle_capital_add_net    NUMBER(20,4),
  is_calculation                 NUMBER(5),
  opdate                         DATE,
  opmode                         VARCHAR2(1)
)
;
comment on column ASHARECASHFLOW.object_id
  is '对象ID';
comment on column ASHARECASHFLOW.s_info_windcode
  is 'Wind代码';
comment on column ASHARECASHFLOW.wind_code
  is 'Wind代码';
comment on column ASHARECASHFLOW.ann_dt
  is '公告日期';
comment on column ASHARECASHFLOW.report_period
  is '报告期';
comment on column ASHARECASHFLOW.statement_type
  is '报表类型';
comment on column ASHARECASHFLOW.crncy_code
  is '货币代码';
comment on column ASHARECASHFLOW.cash_recp_sg_and_rs
  is '销售商品、提供劳务收到的现金';
comment on column ASHARECASHFLOW.recp_tax_rends
  is '收到的税费返还';
comment on column ASHARECASHFLOW.net_incr_dep_cob
  is '客户存款和同业存放款项净增加额';
comment on column ASHARECASHFLOW.net_incr_loans_central_bank
  is '向中央银行借款净增加额';
comment on column ASHARECASHFLOW.net_incr_fund_borr_ofi
  is '向其他金融机构拆入资金净增加额';
comment on column ASHARECASHFLOW.cash_recp_prem_orig_inco
  is '收到原保险合同保费取得的现金';
comment on column ASHARECASHFLOW.net_incr_insured_dep
  is '保户储金净增加额';
comment on column ASHARECASHFLOW.net_cash_received_reinsu_bus
  is '收到再保业务现金净额';
comment on column ASHARECASHFLOW.net_incr_disp_tfa
  is '处置交易性金融资产净增加额';
comment on column ASHARECASHFLOW.net_incr_int_handling_chrg
  is '收取利息和手续费净增加额';
comment on column ASHARECASHFLOW.net_incr_disp_faas
  is '处置可供出售金融资产净增加额';
comment on column ASHARECASHFLOW.net_incr_loans_other_bank
  is '拆入资金净增加额';
comment on column ASHARECASHFLOW.net_incr_repurch_bus_fund
  is '回购业务资金净增加额';
comment on column ASHARECASHFLOW.other_cash_recp_ral_oper_act
  is '收到其他与经营活动有关的现金';
comment on column ASHARECASHFLOW.stot_cash_inflows_oper_act
  is '经营活动现金流入小计';
comment on column ASHARECASHFLOW.cash_pay_goods_purch_serv_rec
  is '购买商品、接受劳务支付的现金';
comment on column ASHARECASHFLOW.cash_pay_beh_empl
  is '支付给职工以及为职工支付的现金';
comment on column ASHARECASHFLOW.pay_all_typ_tax
  is '支付的各项税费';
comment on column ASHARECASHFLOW.net_incr_clients_loan_adv
  is '客户贷款及垫款净增加额';
comment on column ASHARECASHFLOW.net_incr_dep_cbob
  is '存放央行和同业款项净增加额';
comment on column ASHARECASHFLOW.cash_pay_claims_orig_inco
  is '支付原保险合同赔付款项的现金';
comment on column ASHARECASHFLOW.handling_chrg_paid
  is '支付手续费的现金';
comment on column ASHARECASHFLOW.comm_insur_plcy_paid
  is '支付保单红利的现金';
comment on column ASHARECASHFLOW.other_cash_pay_ral_oper_act
  is '支付其他与经营活动有关的现金';
comment on column ASHARECASHFLOW.stot_cash_outflows_oper_act
  is '经营活动现金流出小计';
comment on column ASHARECASHFLOW.net_cash_flows_oper_act
  is '经营活动产生的现金流量净额';
comment on column ASHARECASHFLOW.cash_recp_disp_withdrwl_invest
  is '收回投资收到的现金';
comment on column ASHARECASHFLOW.cash_recp_return_invest
  is '取得投资收益收到的现金';
comment on column ASHARECASHFLOW.net_cash_recp_disp_fiolta
  is '处置固定资产、无形资产和其他长期资产收回的现金净额';
comment on column ASHARECASHFLOW.net_cash_recp_disp_sobu
  is '处置子公司及其他营业单位收到的现金净额';
comment on column ASHARECASHFLOW.other_cash_recp_ral_inv_act
  is '收到其他与投资活动有关的现金';
comment on column ASHARECASHFLOW.stot_cash_inflows_inv_act
  is '投资活动现金流入小计';
comment on column ASHARECASHFLOW.cash_pay_acq_const_fiolta
  is '购建固定资产、无形资产和其他长期资产支付的现金';
comment on column ASHARECASHFLOW.cash_paid_invest
  is '投资支付的现金';
comment on column ASHARECASHFLOW.net_cash_pay_aquis_sobu
  is '取得子公司及其他营业单位支付的现金净额';
comment on column ASHARECASHFLOW.other_cash_pay_ral_inv_act
  is '支付其他与投资活动有关的现金';
comment on column ASHARECASHFLOW.net_incr_pledge_loan
  is '质押贷款净增加额';
comment on column ASHARECASHFLOW.stot_cash_outflows_inv_act
  is '投资活动现金流出小计';
comment on column ASHARECASHFLOW.net_cash_flows_inv_act
  is '投资活动产生的现金流量净额';
comment on column ASHARECASHFLOW.cash_recp_cap_contrib
  is '吸收投资收到的现金';
comment on column ASHARECASHFLOW.incl_cash_rec_saims
  is '其中:子公司吸收少数股东投资收到的现金';
comment on column ASHARECASHFLOW.cash_recp_borrow
  is '取得借款收到的现金';
comment on column ASHARECASHFLOW.proc_issue_bonds
  is '发行债券收到的现金';
comment on column ASHARECASHFLOW.other_cash_recp_ral_fnc_act
  is '收到其他与筹资活动有关的现金';
comment on column ASHARECASHFLOW.stot_cash_inflows_fnc_act
  is '筹资活动现金流入小计';
comment on column ASHARECASHFLOW.cash_prepay_amt_borr
  is '偿还债务支付的现金';
comment on column ASHARECASHFLOW.cash_pay_dist_dpcp_int_exp
  is '分配股利、利润或偿付利息支付的现金';
comment on column ASHARECASHFLOW.incl_dvd_profit_paid_sc_ms
  is '其中:子公司支付给少数股东的股利、利润';
comment on column ASHARECASHFLOW.other_cash_pay_ral_fnc_act
  is '支付其他与筹资活动有关的现金';
comment on column ASHARECASHFLOW.stot_cash_outflows_fnc_act
  is '筹资活动现金流出小计';
comment on column ASHARECASHFLOW.net_cash_flows_fnc_act
  is '筹资活动产生的现金流量净额';
comment on column ASHARECASHFLOW.eff_fx_flu_cash
  is '汇率变动对现金的影响';
comment on column ASHARECASHFLOW.net_incr_cash_cash_equ
  is '现金及现金等价物净增加额';
comment on column ASHARECASHFLOW.cash_cash_equ_beg_period
  is '期初现金及现金等价物余额';
comment on column ASHARECASHFLOW.cash_cash_equ_end_period
  is '期末现金及现金等价物余额';
comment on column ASHARECASHFLOW.net_profit
  is '净利润';
comment on column ASHARECASHFLOW.unconfirmed_invest_loss
  is '未确认投资损失';
comment on column ASHARECASHFLOW.plus_prov_depr_assets
  is '加:资产减值准备';
comment on column ASHARECASHFLOW.depr_fa_coga_dpba
  is '固定资产折旧、油气资产折耗、生产性生物资产折旧';
comment on column ASHARECASHFLOW.amort_intang_assets
  is '无形资产摊销';
comment on column ASHARECASHFLOW.amort_lt_deferred_exp
  is '长期待摊费用摊销';
comment on column ASHARECASHFLOW.decr_deferred_exp
  is '待摊费用减少';
comment on column ASHARECASHFLOW.incr_acc_exp
  is '预提费用增加';
comment on column ASHARECASHFLOW.loss_disp_fiolta
  is '处置固定、无形资产和其他长期资产的损失';
comment on column ASHARECASHFLOW.loss_scr_fa
  is '固定资产报废损失';
comment on column ASHARECASHFLOW.loss_fv_chg
  is '公允价值变动损失';
comment on column ASHARECASHFLOW.fin_exp
  is '财务费用';
comment on column ASHARECASHFLOW.invest_loss
  is '投资损失';
comment on column ASHARECASHFLOW.decr_deferred_inc_tax_assets
  is '递延所得税资产减少';
comment on column ASHARECASHFLOW.incr_deferred_inc_tax_liab
  is '递延所得税负债增加';
comment on column ASHARECASHFLOW.decr_inventories
  is '存货的减少';
comment on column ASHARECASHFLOW.decr_oper_payable
  is '经营性应收项目的减少';
comment on column ASHARECASHFLOW.incr_oper_payable
  is '经营性应付项目的增加';
comment on column ASHARECASHFLOW.others
  is '其他';
comment on column ASHARECASHFLOW.im_net_cash_flows_oper_act
  is '间接法-经营活动产生的现金流量净额';
comment on column ASHARECASHFLOW.conv_debt_into_cap
  is '债务转为资本';
comment on column ASHARECASHFLOW.conv_corp_bonds_due_within_1y
  is '一年内到期的可转换公司债券';
comment on column ASHARECASHFLOW.fa_fnc_leases
  is '融资租入固定资产';
comment on column ASHARECASHFLOW.end_bal_cash
  is '现金的期末余额';
comment on column ASHARECASHFLOW.less_beg_bal_cash
  is '减:现金的期初余额';
comment on column ASHARECASHFLOW.plus_end_bal_cash_equ
  is '加:现金等价物的期末余额';
comment on column ASHARECASHFLOW.less_beg_bal_cash_equ
  is '减:现金等价物的期初余额';
comment on column ASHARECASHFLOW.im_net_incr_cash_cash_equ
  is '间接法-现金及现金等价物净增加额';
comment on column ASHARECASHFLOW.free_cash_flow
  is '企业自由现金流量(FCFF)';
comment on column ASHARECASHFLOW.comp_type_code
  is '公司类型代码';
comment on column ASHARECASHFLOW.actual_ann_dt
  is '实际公告日期';
comment on column ASHARECASHFLOW.spe_bal_cash_inflows_oper
  is '经营活动现金流入差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_cash_inflows_oper
  is '经营活动现金流入差额(合计平衡项目)';
comment on column ASHARECASHFLOW.spe_bal_cash_outflows_oper
  is '经营活动现金流出差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_cash_outflows_oper
  is '经营活动现金流出差额(合计平衡项目)';
comment on column ASHARECASHFLOW.tot_bal_netcash_outflows_oper
  is '经营活动产生的现金流量净额差额(合计平衡项目)';
comment on column ASHARECASHFLOW.spe_bal_cash_inflows_inv
  is '投资活动现金流入差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_cash_inflows_inv
  is '投资活动现金流入差额(合计平衡项目)';
comment on column ASHARECASHFLOW.spe_bal_cash_outflows_inv
  is '投资活动现金流出差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_cash_outflows_inv
  is '投资活动现金流出差额(合计平衡项目)';
comment on column ASHARECASHFLOW.tot_bal_netcash_outflows_inv
  is '投资活动产生的现金流量净额差额(合计平衡项目)';
comment on column ASHARECASHFLOW.spe_bal_cash_inflows_fnc
  is '筹资活动现金流入差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_cash_inflows_fnc
  is '筹资活动现金流入差额(合计平衡项目)';
comment on column ASHARECASHFLOW.spe_bal_cash_outflows_fnc
  is '筹资活动现金流出差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_cash_outflows_fnc
  is '筹资活动现金流出差额(合计平衡项目)';
comment on column ASHARECASHFLOW.tot_bal_netcash_outflows_fnc
  is '筹资活动产生的现金流量净额差额(合计平衡项目)';
comment on column ASHARECASHFLOW.spe_bal_netcash_inc
  is '现金净增加额差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_netcash_inc
  is '现金净增加额差额(合计平衡项目)';
comment on column ASHARECASHFLOW.spe_bal_netcash_equ_undir
  is '间接法-经营活动现金流量净额差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_netcash_equ_undir
  is '间接法-经营活动现金流量净额差额(合计平衡项目)';
comment on column ASHARECASHFLOW.spe_bal_netcash_inc_undir
  is '间接法-现金净增加额差额(特殊报表科目)';
comment on column ASHARECASHFLOW.tot_bal_netcash_inc_undir
  is '间接法-现金净增加额差额(合计平衡项目)';
comment on column ASHARECASHFLOW.s_info_compcode
  is '公司ID';
comment on column ASHARECASHFLOW.s_dismantle_capital_add_net
  is '拆出资金净增加额';
comment on column ASHARECASHFLOW.is_calculation
  is '是否计算报表';
create index IDX_ACF_5 on ASHARECASHFLOW (S_INFO_WINDCODE, ANN_DT, REPORT_PERIOD);
create index IDX_ACF_ANNDT on ASHARECASHFLOW (ANN_DT);
create index IDX_ACF_RPT_PRD on ASHARECASHFLOW (REPORT_PERIOD);
create index IDX_ACF_WINDCD on ASHARECASHFLOW (S_INFO_WINDCODE);
alter table ASHARECASHFLOW
  add primary key (OBJECT_ID);


create table ASHAREFINANCIALINDICATOR
(
  object_id                      VARCHAR2(100) not null,
  s_info_windcode                VARCHAR2(40),
  wind_code                      VARCHAR2(40),
  ann_dt                         VARCHAR2(8),
  report_period                  VARCHAR2(8),
  crncy_code                     VARCHAR2(10),
  s_fa_extraordinary             NUMBER(20,4),
  s_fa_deductedprofit            NUMBER(20,4),
  s_fa_grossmargin               NUMBER(20,4),
  s_fa_operateincome             NUMBER(20,4),
  s_fa_investincome              NUMBER(20,4),
  s_stmnote_finexp               NUMBER(20,4),
  s_stm_is                       NUMBER(20,4),
  s_fa_ebit                      NUMBER(20,4),
  s_fa_ebitda                    NUMBER(20,4),
  s_fa_fcff                      NUMBER(20,4),
  s_fa_fcfe                      NUMBER(20,4),
  s_fa_exinterestdebt_current    NUMBER(20,4),
  s_fa_exinterestdebt_noncurrent NUMBER(20,4),
  s_fa_interestdebt              NUMBER(20,4),
  s_fa_netdebt                   NUMBER(20,4),
  s_fa_tangibleasset             NUMBER(20,4),
  s_fa_workingcapital            NUMBER(20,4),
  s_fa_networkingcapital         NUMBER(20,4),
  s_fa_investcapital             NUMBER(20,4),
  s_fa_retainedearnings          NUMBER(20,4),
  s_fa_eps_basic                 NUMBER(20,4),
  s_fa_eps_diluted               NUMBER(20,4),
  s_fa_eps_diluted2              NUMBER(20,4),
  s_fa_bps                       NUMBER(20,4),
  s_fa_ocfps                     NUMBER(20,4),
  s_fa_grps                      NUMBER(20,4),
  s_fa_orps                      NUMBER(20,4),
  s_fa_surpluscapitalps          NUMBER(20,4),
  s_fa_surplusreserveps          NUMBER(20,4),
  s_fa_undistributedps           NUMBER(20,4),
  s_fa_retainedps                NUMBER(20,4),
  s_fa_cfps                      NUMBER(20,4),
  s_fa_ebitps                    NUMBER(20,4),
  s_fa_fcffps                    NUMBER(20,4),
  s_fa_fcfeps                    NUMBER(20,4),
  s_fa_netprofitmargin           NUMBER(20,4),
  s_fa_grossprofitmargin         NUMBER(20,4),
  s_fa_cogstosales               NUMBER(20,4),
  s_fa_expensetosales            NUMBER(20,4),
  s_fa_profittogr                NUMBER(20,4),
  s_fa_saleexpensetogr           NUMBER(20,4),
  s_fa_adminexpensetogr          NUMBER(20,4),
  s_fa_finaexpensetogr           NUMBER(20,4),
  s_fa_impairtogr_ttm            NUMBER(20,4),
  s_fa_gctogr                    NUMBER(20,4),
  s_fa_optogr                    NUMBER(20,4),
  s_fa_ebittogr                  NUMBER(20,4),
  s_fa_roe                       NUMBER(20,4),
  s_fa_roe_deducted              NUMBER(20,4),
  s_fa_roa2                      NUMBER(20,4),
  s_fa_roa                       NUMBER(20,4),
  s_fa_roic                      NUMBER(20,4),
  s_fa_roe_yearly                NUMBER(20,4),
  s_fa_roa2_yearly               NUMBER(20,4),
  s_fa_roe_avg                   NUMBER(20,4),
  s_fa_operateincometoebt        NUMBER(20,4),
  s_fa_investincometoebt         NUMBER(20,4),
  s_fa_nonoperateprofittoebt     NUMBER(20,4),
  s_fa_taxtoebt                  NUMBER(20,4),
  s_fa_deductedprofittoprofit    NUMBER(20,4),
  s_fa_salescashintoor           NUMBER(20,4),
  s_fa_ocftoor                   NUMBER(20,4),
  s_fa_ocftooperateincome        NUMBER(20,4),
  s_fa_capitalizedtoda           NUMBER(20,4),
  s_fa_debttoassets              NUMBER(20,4),
  s_fa_assetstoequity            NUMBER(20,4),
  s_fa_dupont_assetstoequity     NUMBER(20,4),
  s_fa_catoassets                NUMBER(20,4),
  s_fa_ncatoassets               NUMBER(20,4),
  s_fa_tangibleassetstoassets    NUMBER(20,4),
  s_fa_intdebttototalcap         NUMBER(20,4),
  s_fa_equitytototalcapital      NUMBER(20,4),
  s_fa_currentdebttodebt         NUMBER(20,4),
  s_fa_longdebtodebt             NUMBER(20,4),
  s_fa_current                   NUMBER(20,4),
  s_fa_quick                     NUMBER(20,4),
  s_fa_cashratio                 NUMBER(20,4),
  s_fa_ocftoshortdebt            NUMBER(20,4),
  s_fa_debttoequity              NUMBER(20,4),
  s_fa_equitytodebt              NUMBER(20,4),
  s_fa_equitytointerestdebt      NUMBER(20,4),
  s_fa_tangibleassettodebt       NUMBER(20,4),
  s_fa_tangassettointdebt        NUMBER(20,4),
  s_fa_tangibleassettonetdebt    NUMBER(20,4),
  s_fa_ocftodebt                 NUMBER(20,4),
  s_fa_ocftointerestdebt         NUMBER(20,4),
  s_fa_ocftonetdebt              NUMBER(20,4),
  s_fa_ebittointerest            NUMBER(20,4),
  s_fa_longdebttoworkingcapital  NUMBER(20,4),
  s_fa_ebitdatodebt              NUMBER(20,4),
  s_fa_turndays                  NUMBER(20,4),
  s_fa_invturndays               NUMBER(20,4),
  s_fa_arturndays                NUMBER(20,4),
  s_fa_invturn                   NUMBER(20,4),
  s_fa_arturn                    NUMBER(20,4),
  s_fa_caturn                    NUMBER(20,4),
  s_fa_faturn                    NUMBER(20,4),
  s_fa_assetsturn                NUMBER(20,4),
  s_fa_roa_yearly                NUMBER(20,4),
  s_fa_dupont_roa                NUMBER(20,4),
  s_stm_bs                       NUMBER(20,4),
  s_fa_prefinexpense_opprofit    NUMBER(20,4),
  s_fa_nonopprofit               NUMBER(20,4),
  s_fa_optoebt                   NUMBER(20,4),
  s_fa_noptoebt                  NUMBER(20,4),
  s_fa_ocftoprofit               NUMBER(20,4),
  s_fa_cashtoliqdebt             NUMBER(20,4),
  s_fa_cashtoliqdebtwithinterest NUMBER(20,4),
  s_fa_optoliqdebt               NUMBER(20,4),
  s_fa_optodebt                  NUMBER(20,4),
  s_fa_roic_yearly               NUMBER(20,4),
  s_fa_tot_faturn                NUMBER(20,4),
  s_fa_profittoop                NUMBER(20,4),
  s_qfa_operateincome            NUMBER(20,4),
  s_qfa_investincome             NUMBER(20,4),
  s_qfa_deductedprofit           NUMBER(20,4),
  s_qfa_eps                      NUMBER(20,4),
  s_qfa_netprofitmargin          NUMBER(20,4),
  s_qfa_grossprofitmargin        NUMBER(20,4),
  s_qfa_expensetosales           NUMBER(20,4),
  s_qfa_profittogr               NUMBER(20,4),
  s_qfa_saleexpensetogr          NUMBER(20,4),
  s_qfa_adminexpensetogr         NUMBER(20,4),
  s_qfa_finaexpensetogr          NUMBER(20,4),
  s_qfa_impairtogr_ttm           NUMBER(20,4),
  s_qfa_gctogr                   NUMBER(20,4),
  s_qfa_optogr                   NUMBER(20,4),
  s_qfa_roe                      NUMBER(20,4),
  s_qfa_roe_deducted             NUMBER(20,4),
  s_qfa_roa                      NUMBER(20,4),
  s_qfa_operateincometoebt       NUMBER(20,4),
  s_qfa_investincometoebt        NUMBER(20,4),
  s_qfa_deductedprofittoprofit   NUMBER(20,4),
  s_qfa_salescashintoor          NUMBER(20,4),
  s_qfa_ocftosales               NUMBER(20,4),
  s_qfa_ocftoor                  NUMBER(20,4),
  s_fa_yoyeps_basic              NUMBER(20,4),
  s_fa_yoyeps_diluted            NUMBER(20,4),
  s_fa_yoyocfps                  NUMBER(20,4),
  s_fa_yoyop                     NUMBER(20,4),
  s_fa_yoyebt                    NUMBER(20,4),
  s_fa_yoynetprofit              NUMBER(20,4),
  s_fa_yoynetprofit_deducted     NUMBER(20,4),
  s_fa_yoyocf                    NUMBER(20,4),
  s_fa_yoyroe                    NUMBER(20,4),
  s_fa_yoybps                    NUMBER(20,4),
  s_fa_yoyassets                 NUMBER(20,4),
  s_fa_yoyequity                 NUMBER(20,4),
  s_fa_yoy_tr                    NUMBER(20,4),
  s_fa_yoy_or                    NUMBER(20,4),
  s_qfa_yoygr                    NUMBER(20,4),
  s_qfa_cgrgr                    NUMBER(20,4),
  s_qfa_yoysales                 NUMBER(20,4),
  s_qfa_cgrsales                 NUMBER(20,4),
  s_qfa_yoyop                    NUMBER(20,4),
  s_qfa_cgrop                    NUMBER(20,4),
  s_qfa_yoyprofit                NUMBER(20,4),
  s_qfa_cgrprofit                NUMBER(20,4),
  s_qfa_yoynetprofit             NUMBER(20,4),
  s_qfa_cgrnetprofit             NUMBER(20,4),
  s_fa_yoy_equity                NUMBER(20,4),
  rd_expense                     NUMBER(20,4),
  waa_roe                        NUMBER(20,4),
  s_info_compcode                VARCHAR2(10),
  opdate                         DATE,
  opmode                         VARCHAR2(1)
)
;
comment on column ASHAREFINANCIALINDICATOR.object_id
  is '对象ID';
comment on column ASHAREFINANCIALINDICATOR.s_info_windcode
  is 'Wind代码';
comment on column ASHAREFINANCIALINDICATOR.wind_code
  is 'Wind代码';
comment on column ASHAREFINANCIALINDICATOR.ann_dt
  is '公告日期';
comment on column ASHAREFINANCIALINDICATOR.report_period
  is '报告期';
comment on column ASHAREFINANCIALINDICATOR.crncy_code
  is '货币代码';
comment on column ASHAREFINANCIALINDICATOR.s_fa_extraordinary
  is '非经常性损益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_deductedprofit
  is '扣除非经常性损益后的净利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_grossmargin
  is '毛利';
comment on column ASHAREFINANCIALINDICATOR.s_fa_operateincome
  is '经营活动净收益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_investincome
  is '价值变动净收益';
comment on column ASHAREFINANCIALINDICATOR.s_stmnote_finexp
  is '利息费用';
comment on column ASHAREFINANCIALINDICATOR.s_stm_is
  is '折旧与摊销';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ebit
  is '息税前利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ebitda
  is '息税折旧摊销前利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_fcff
  is '企业自由现金流量(FCFF)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_fcfe
  is '股权自由现金流量(FCFE)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_exinterestdebt_current
  is '无息流动负债';
comment on column ASHAREFINANCIALINDICATOR.s_fa_exinterestdebt_noncurrent
  is '无息非流动负债';
comment on column ASHAREFINANCIALINDICATOR.s_fa_interestdebt
  is '带息债务';
comment on column ASHAREFINANCIALINDICATOR.s_fa_netdebt
  is '净债务';
comment on column ASHAREFINANCIALINDICATOR.s_fa_tangibleasset
  is '有形资产';
comment on column ASHAREFINANCIALINDICATOR.s_fa_workingcapital
  is '营运资金';
comment on column ASHAREFINANCIALINDICATOR.s_fa_networkingcapital
  is '营运流动资本';
comment on column ASHAREFINANCIALINDICATOR.s_fa_investcapital
  is '全部投入资本';
comment on column ASHAREFINANCIALINDICATOR.s_fa_retainedearnings
  is '留存收益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_eps_basic
  is '基本每股收益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_eps_diluted
  is '稀释每股收益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_eps_diluted2
  is '期末摊薄每股收益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_bps
  is '每股净资产';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ocfps
  is '每股经营活动产生的现金流量净额';
comment on column ASHAREFINANCIALINDICATOR.s_fa_grps
  is '每股营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_orps
  is '每股营业收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_surpluscapitalps
  is '每股资本公积';
comment on column ASHAREFINANCIALINDICATOR.s_fa_surplusreserveps
  is '每股盈余公积';
comment on column ASHAREFINANCIALINDICATOR.s_fa_undistributedps
  is '每股未分配利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_retainedps
  is '每股留存收益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_cfps
  is '每股现金流量净额';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ebitps
  is '每股息税前利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_fcffps
  is '每股企业自由现金流量';
comment on column ASHAREFINANCIALINDICATOR.s_fa_fcfeps
  is '每股股东自由现金流量';
comment on column ASHAREFINANCIALINDICATOR.s_fa_netprofitmargin
  is '销售净利率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_grossprofitmargin
  is '销售毛利率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_cogstosales
  is '销售成本率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_expensetosales
  is '销售期间费用率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_profittogr
  is '净利润/营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_saleexpensetogr
  is '销售费用/营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_adminexpensetogr
  is '管理费用/营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_finaexpensetogr
  is '财务费用/营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_impairtogr_ttm
  is '资产减值损失/营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_gctogr
  is '营业总成本/营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_optogr
  is '营业利润/营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ebittogr
  is '息税前利润/营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roe
  is '净资产收益率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roe_deducted
  is '净资产收益率(扣除非经常损益)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roa2
  is '总资产报酬率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roa
  is '总资产净利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roic
  is '投入资本回报率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roe_yearly
  is '年化净资产收益率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roa2_yearly
  is '年化总资产报酬率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roe_avg
  is '平均净资产收益率(增发条件)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_operateincometoebt
  is '经营活动净收益/利润总额';
comment on column ASHAREFINANCIALINDICATOR.s_fa_investincometoebt
  is '价值变动净收益/利润总额';
comment on column ASHAREFINANCIALINDICATOR.s_fa_nonoperateprofittoebt
  is '营业外收支净额/利润总额';
comment on column ASHAREFINANCIALINDICATOR.s_fa_taxtoebt
  is '所得税/利润总额';
comment on column ASHAREFINANCIALINDICATOR.s_fa_deductedprofittoprofit
  is '扣除非经常损益后的净利润/净利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_salescashintoor
  is '销售商品提供劳务收到的现金/营业收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ocftoor
  is '经营活动产生的现金流量净额/营业收入';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ocftooperateincome
  is '经营活动产生的现金流量净额/经营活动净收益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_capitalizedtoda
  is '资本支出/折旧和摊销';
comment on column ASHAREFINANCIALINDICATOR.s_fa_debttoassets
  is '资产负债率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_assetstoequity
  is '权益乘数';
comment on column ASHAREFINANCIALINDICATOR.s_fa_dupont_assetstoequity
  is '权益乘数(用于杜邦分析)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_catoassets
  is '流动资产/总资产';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ncatoassets
  is '非流动资产/总资产';
comment on column ASHAREFINANCIALINDICATOR.s_fa_tangibleassetstoassets
  is '有形资产/总资产';
comment on column ASHAREFINANCIALINDICATOR.s_fa_intdebttototalcap
  is '带息债务/全部投入资本';
comment on column ASHAREFINANCIALINDICATOR.s_fa_equitytototalcapital
  is '归属于母公司的股东权益/全部投入资本';
comment on column ASHAREFINANCIALINDICATOR.s_fa_currentdebttodebt
  is '流动负债/负债合计';
comment on column ASHAREFINANCIALINDICATOR.s_fa_longdebtodebt
  is '非流动负债/负债合计';
comment on column ASHAREFINANCIALINDICATOR.s_fa_current
  is '流动比率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_quick
  is '速动比率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_cashratio
  is '保守速动比率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ocftoshortdebt
  is '经营活动产生的现金流量净额/流动负债';
comment on column ASHAREFINANCIALINDICATOR.s_fa_debttoequity
  is '产权比率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_equitytodebt
  is '归属于母公司的股东权益/负债合计';
comment on column ASHAREFINANCIALINDICATOR.s_fa_equitytointerestdebt
  is '归属于母公司的股东权益/带息债务';
comment on column ASHAREFINANCIALINDICATOR.s_fa_tangibleassettodebt
  is '有形资产/负债合计';
comment on column ASHAREFINANCIALINDICATOR.s_fa_tangassettointdebt
  is '有形资产/带息债务';
comment on column ASHAREFINANCIALINDICATOR.s_fa_tangibleassettonetdebt
  is '有形资产/净债务';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ocftodebt
  is '经营活动产生的现金流量净额/负债合计';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ocftointerestdebt
  is '经营活动产生的现金流量净额/带息债务';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ocftonetdebt
  is '经营活动产生的现金流量净额/净债务';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ebittointerest
  is '已获利息倍数(EBIT/利息费用)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_longdebttoworkingcapital
  is '长期债务与营运资金比率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ebitdatodebt
  is '息税折旧摊销前利润/负债合计';
comment on column ASHAREFINANCIALINDICATOR.s_fa_turndays
  is '营业周期';
comment on column ASHAREFINANCIALINDICATOR.s_fa_invturndays
  is '存货周转天数';
comment on column ASHAREFINANCIALINDICATOR.s_fa_arturndays
  is '应收账款周转天数';
comment on column ASHAREFINANCIALINDICATOR.s_fa_invturn
  is '存货周转率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_arturn
  is '应收账款周转率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_caturn
  is '流动资产周转率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_faturn
  is '固定资产周转率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_assetsturn
  is '总资产周转率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roa_yearly
  is '年化总资产净利率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_dupont_roa
  is '总资产净利率(杜邦分析)';
comment on column ASHAREFINANCIALINDICATOR.s_stm_bs
  is '固定资产合计';
comment on column ASHAREFINANCIALINDICATOR.s_fa_prefinexpense_opprofit
  is '扣除财务费用前营业利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_nonopprofit
  is '非营业利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_optoebt
  is '营业利润／利润总额';
comment on column ASHAREFINANCIALINDICATOR.s_fa_noptoebt
  is '非营业利润／利润总额';
comment on column ASHAREFINANCIALINDICATOR.s_fa_ocftoprofit
  is '经营活动产生的现金流量净额／营业利润';
comment on column ASHAREFINANCIALINDICATOR.s_fa_cashtoliqdebt
  is '货币资金／流动负债';
comment on column ASHAREFINANCIALINDICATOR.s_fa_cashtoliqdebtwithinterest
  is '货币资金／带息流动负债';
comment on column ASHAREFINANCIALINDICATOR.s_fa_optoliqdebt
  is '营业利润／流动负债';
comment on column ASHAREFINANCIALINDICATOR.s_fa_optodebt
  is '营业利润／负债合计';
comment on column ASHAREFINANCIALINDICATOR.s_fa_roic_yearly
  is '年化投入资本回报率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_tot_faturn
  is '固定资产合计周转率';
comment on column ASHAREFINANCIALINDICATOR.s_fa_profittoop
  is '利润总额／营业收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_operateincome
  is '单季度.经营活动净收益';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_investincome
  is '单季度.价值变动净收益';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_deductedprofit
  is '单季度.扣除非经常损益后的净利润';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_eps
  is '单季度.每股收益';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_netprofitmargin
  is '单季度.销售净利率';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_grossprofitmargin
  is '单季度.销售毛利率';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_expensetosales
  is '单季度.销售期间费用率';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_profittogr
  is '单季度.净利润／营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_saleexpensetogr
  is '单季度.销售费用／营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_adminexpensetogr
  is '单季度.管理费用／营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_finaexpensetogr
  is '单季度.财务费用／营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_impairtogr_ttm
  is '单季度.资产减值损失／营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_gctogr
  is '单季度.营业总成本／营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_optogr
  is '单季度.营业利润／营业总收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_roe
  is '单季度.净资产收益率';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_roe_deducted
  is '单季度.净资产收益率(扣除非经常损益)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_roa
  is '单季度.总资产净利润';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_operateincometoebt
  is '单季度.经营活动净收益／利润总额';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_investincometoebt
  is '单季度.价值变动净收益／利润总额';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_deductedprofittoprofit
  is '单季度.扣除非经常损益后的净利润／净利润';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_salescashintoor
  is '单季度.销售商品提供劳务收到的现金／营业收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_ocftosales
  is '单季度.经营活动产生的现金流量净额／营业收入';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_ocftoor
  is '单季度.经营活动产生的现金流量净额／经营活动净收益';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyeps_basic
  is '同比增长率-基本每股收益(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyeps_diluted
  is '同比增长率-稀释每股收益(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyocfps
  is '同比增长率-每股经营活动产生的现金流量净额(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyop
  is '同比增长率-营业利润(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyebt
  is '同比增长率-利润总额(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoynetprofit
  is '同比增长率-归属母公司股东的净利润(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoynetprofit_deducted
  is '同比增长率-归属母公司股东的净利润-扣除非经常损益(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyocf
  is '同比增长率-经营活动产生的现金流量净额(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyroe
  is '同比增长率-净资产收益率(摊薄)(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoybps
  is '相对年初增长率-每股净资产(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyassets
  is '相对年初增长率-资产总计(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoyequity
  is '相对年初增长率-归属母公司的股东权益(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoy_tr
  is '营业总收入同比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoy_or
  is '营业收入同比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_yoygr
  is '单季度.营业总收入同比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_cgrgr
  is '单季度.营业总收入环比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_yoysales
  is '单季度.营业收入同比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_cgrsales
  is '单季度.营业收入环比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_yoyop
  is '单季度.营业利润同比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_cgrop
  is '单季度.营业利润环比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_yoyprofit
  is '单季度.净利润同比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_cgrprofit
  is '单季度.净利润环比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_yoynetprofit
  is '单季度.归属母公司股东的净利润同比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_qfa_cgrnetprofit
  is '单季度.归属母公司股东的净利润环比增长率(%)';
comment on column ASHAREFINANCIALINDICATOR.s_fa_yoy_equity
  is '净资产(同比增长率)';
comment on column ASHAREFINANCIALINDICATOR.rd_expense
  is '研发费用';
comment on column ASHAREFINANCIALINDICATOR.waa_roe
  is '加权平均净资产收益率';
comment on column ASHAREFINANCIALINDICATOR.s_info_compcode
  is '公司ID';
create index IDX_ASHAREFINANCIALINDICATOR1 on ASHAREFINANCIALINDICATOR (S_INFO_WINDCODE);
create index IDX_ASHAREFINANCIALINDICATOR2 on ASHAREFINANCIALINDICATOR (REPORT_PERIOD);
create index IDX_ASHAREFINANCIALINDICATOR3 on ASHAREFINANCIALINDICATOR (S_FA_YOYEPS_BASIC);
create index IDX_ASHAREFINANCIALINDICATOR4 on ASHAREFINANCIALINDICATOR (ANN_DT);
create index IDX_ASHAREFINANCIALINDICATOR5 on ASHAREFINANCIALINDICATOR (ANN_DT, S_INFO_WINDCODE);
alter table ASHAREFINANCIALINDICATOR
  add primary key (OBJECT_ID);


create table AINDEXDESCRIPTION
(
  object_id                VARCHAR2(100) not null,
  s_info_windcode          VARCHAR2(40),
  s_info_code              VARCHAR2(40),
  s_info_name              VARCHAR2(50),
  s_info_compname          VARCHAR2(100),
  s_info_exchmarket        VARCHAR2(40),
  s_info_index_baseper     VARCHAR2(8),
  s_info_index_basept      NUMBER(20,4),
  s_info_listdate          VARCHAR2(8),
  s_info_index_weightsrule VARCHAR2(10),
  s_info_publisher         VARCHAR2(100),
  s_info_indexcode         NUMBER(9),
  s_info_indexstyle        VARCHAR2(40),
  index_intro              CLOB,
  weight_type              NUMBER(9),
  expire_date              VARCHAR2(8),
  income_processing_method VARCHAR2(20),
  opdate                   DATE,
  opmode                   VARCHAR2(1)
)
;
comment on column AINDEXDESCRIPTION.object_id
  is '对象ID';
comment on column AINDEXDESCRIPTION.s_info_windcode
  is 'Wind代码';
comment on column AINDEXDESCRIPTION.s_info_code
  is '交易代码';
comment on column AINDEXDESCRIPTION.s_info_name
  is '证券简称';
comment on column AINDEXDESCRIPTION.s_info_compname
  is '指数名称';
comment on column AINDEXDESCRIPTION.s_info_exchmarket
  is '交易所';
comment on column AINDEXDESCRIPTION.s_info_index_baseper
  is '基期';
comment on column AINDEXDESCRIPTION.s_info_index_basept
  is '基点';
comment on column AINDEXDESCRIPTION.s_info_listdate
  is '发布日期';
comment on column AINDEXDESCRIPTION.s_info_index_weightsrule
  is '加权方式';
comment on column AINDEXDESCRIPTION.s_info_publisher
  is '发布方';
comment on column AINDEXDESCRIPTION.s_info_indexcode
  is '指数类别代码';
comment on column AINDEXDESCRIPTION.s_info_indexstyle
  is '指数风格';
comment on column AINDEXDESCRIPTION.index_intro
  is '指数简介';
comment on column AINDEXDESCRIPTION.weight_type
  is '权重类型';
comment on column AINDEXDESCRIPTION.expire_date
  is '终止发布日期';
comment on column AINDEXDESCRIPTION.income_processing_method
  is '收益处理方式';
create index IDX_AINDEXDESCRIPTION1 on AINDEXDESCRIPTION (S_INFO_WINDCODE);
create index IDX_AINDEXDESCRIPTION2 on AINDEXDESCRIPTION (S_INFO_EXCHMARKET);
alter table AINDEXDESCRIPTION
  add primary key (OBJECT_ID);


create table AINDEXEODPRICES
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  crncy_code      VARCHAR2(10),
  s_dq_preclose   NUMBER(20,4),
  s_dq_open       NUMBER(20,4),
  s_dq_high       NUMBER(20,4),
  s_dq_low        NUMBER(20,4),
  s_dq_close      NUMBER(20,4),
  s_dq_change     NUMBER(20,4),
  s_dq_pctchange  NUMBER(20,4),
  s_dq_volume     NUMBER(20,4),
  s_dq_amount     NUMBER(20,4),
  sec_id          VARCHAR2(10),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column AINDEXEODPRICES.object_id
  is '对象ID';
comment on column AINDEXEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column AINDEXEODPRICES.trade_dt
  is '交易日期';
comment on column AINDEXEODPRICES.crncy_code
  is '货币代码';
comment on column AINDEXEODPRICES.s_dq_preclose
  is '昨收盘价(点)';
comment on column AINDEXEODPRICES.s_dq_open
  is '开盘价(点)';
comment on column AINDEXEODPRICES.s_dq_high
  is '最高价(点)';
comment on column AINDEXEODPRICES.s_dq_low
  is '最低价(点)';
comment on column AINDEXEODPRICES.s_dq_close
  is '收盘价(点)';
comment on column AINDEXEODPRICES.s_dq_change
  is '涨跌(点)';
comment on column AINDEXEODPRICES.s_dq_pctchange
  is '涨跌幅(%)';
comment on column AINDEXEODPRICES.s_dq_volume
  is '成交量(手)';
comment on column AINDEXEODPRICES.s_dq_amount
  is '成交金额(千元)';
comment on column AINDEXEODPRICES.sec_id
  is '证券ID';
create index IDX_AINDEXEODPRICES1 on AINDEXEODPRICES (S_INFO_WINDCODE);
create index IDX_AINDEXEODPRICES2 on AINDEXEODPRICES (TRADE_DT);
create index IDX_AINDEXEODPRICES3 on AINDEXEODPRICES (s_info_windcode, TRADE_DT);
alter table AINDEXEODPRICES
  add primary key (OBJECT_ID);


create table ASHARETTMHIS
(
  object_id                      VARCHAR2(100) not null,
  s_info_compcode                VARCHAR2(40),
  ann_dt                         VARCHAR2(8),
  report_period                  VARCHAR2(8),
  statement_type                 VARCHAR2(80),
  tot_oper_rev_ttm               NUMBER(20,4),
  oper_rev_ttm                   NUMBER(20,4),
  net_profit_ttm                 NUMBER(20,4),
  net_profit_parent_comp_ttm     NUMBER(20,4),
  net_cash_flows_oper_act_ttm    NUMBER(20,4),
  net_incr_cash_cash_equ_ttm     NUMBER(20,4),
  crncy_code                     VARCHAR2(10),
  s_fa_cost_ttm                  NUMBER(20,4),
  s_fa_expense_ttm               NUMBER(20,4),
  s_fa_grossmargin_ttm           NUMBER(20,4),
  s_fa_operateincome_ttm         NUMBER(20,4),
  s_fa_investincome_ttm          NUMBER(20,4),
  s_fa_op_ttm                    NUMBER(20,4),
  s_fa_ebt_ttm                   NUMBER(20,4),
  s_fa_gr_ttm                    NUMBER(20,4),
  s_fa_gc_ttm                    NUMBER(20,4),
  s_fa_investcashflow_ttm        NUMBER(20,4),
  s_fa_financecashflow_ttm       NUMBER(20,4),
  s_fa_asset_mrq                 NUMBER(20,4),
  s_fa_debt_mrq                  NUMBER(20,4),
  s_fa_totalequity_mrq           NUMBER(20,4),
  s_fa_equity_mrq                NUMBER(20,4),
  s_fa_netprofitmargin_ttm       NUMBER(20,4),
  s_fa_grossprofitmargin_ttm     NUMBER(20,4),
  s_fa_expensetosales_ttm        NUMBER(20,4),
  s_fa_profittogr_ttm            NUMBER(20,4),
  s_fa_operateexpensetogr_ttm    NUMBER(20,4),
  s_fa_adminexpensetogr_ttm      NUMBER(20,4),
  s_fa_finaexpensetogr_ttm       NUMBER(20,4),
  s_fa_impairtogr_ttm            NUMBER(20,4),
  s_fa_gctogr_ttm                NUMBER(20,4),
  s_fa_optogr_ttm                NUMBER(20,4),
  s_fa_roa_ttm                   NUMBER(20,4),
  s_fa_roa2_ttm                  NUMBER(20,4),
  s_fa_roe_ttm                   NUMBER(20,4),
  s_fa_operateincometoebt_ttm    NUMBER(20,4),
  s_fa_investincometoebt_ttm     NUMBER(20,4),
  s_fa_nonoperateprofittoebt_ttm NUMBER(20,4),
  s_fa_salescashintoor_ttm       NUMBER(20,4),
  s_fa_ocftoor_ttm               NUMBER(20,4),
  s_fa_ocftooperateincome_ttm    NUMBER(20,4),
  s_fa_deductedprofit_ttm        NUMBER(20,4),
  s_fa_ebitda_ttm_inverse        NUMBER(20,4),
  s_fa_ebitda_ttm                NUMBER(20,4),
  s_fa_ebit_ttm                  NUMBER(20,4),
  fa_roic_ttm                    NUMBER(20,4),
  s_fa_salescashin_ttm           NUMBER(20,4),
  s_fa_operateexpense_ttm        NUMBER(20,4),
  s_fa_adminexpense_ttm          NUMBER(20,4),
  s_fa_finaexpense_ttm           NUMBER(20,4),
  s_fa_expense                   NUMBER(20,4),
  s_fa_nonoperateprofit_ttm      NUMBER(20,4),
  s_fa_impairment_ttm            NUMBER(20,4),
  s_fa_ebit_ttm_inverse          NUMBER(20,4),
  s_fa_investcapital_mrq         NUMBER(20,4),
  fa_roic_ttm2                   NUMBER(20,4),
  s_stm_bsmrq                    NUMBER(20,4),
  s_fa_nonopprofit_ttm           NUMBER(20,4),
  s_fa_prefinexp_op_ttm          NUMBER(20,4),
  s_fa_optoebt_ttm               NUMBER(20,4),
  s_fa_noptoebt_ttm              NUMBER(20,4),
  s_fa_taxtoebt_ttm              NUMBER(20,4),
  s_fa_optoor_ttm                NUMBER(20,4),
  s_fa_ebttoor_ttm               NUMBER(20,4),
  s_fa_prefinexpoptoor_ttm       NUMBER(20,4),
  s_fa_netprofittoor_ttm         NUMBER(20,4),
  s_fa_prefinexpoptoebt_ttm      NUMBER(20,4),
  s_fa_ocftoop_ttm               NUMBER(20,4),
  roa_exclminintinc_ttm          NUMBER(20,4),
  s_fa_debttoassets_mrq          NUMBER(20,4),
  int_exp_ttm                    NUMBER(20,4),
  inc_tax_ttm                    NUMBER(20,4),
  minority_int_ttm               NUMBER(20,4),
  continuous_net_op_ttm          NUMBER(20,4),
  noncontinuous_net_op_ttm       NUMBER(20,4),
  nonnetoptotaxprofit            NUMBER(20,4),
  netoptotaxprofit               NUMBER(20,4),
  s_info_windcode                VARCHAR2(40),
  opdate                         DATE,
  opmode                         VARCHAR2(1)
)
;
comment on column ASHARETTMHIS.object_id
  is '对象ID';
comment on column ASHARETTMHIS.s_info_compcode
  is '公司ID';
comment on column ASHARETTMHIS.ann_dt
  is '公告日期';
comment on column ASHARETTMHIS.report_period
  is '截止日期';
comment on column ASHARETTMHIS.statement_type
  is '报表类型';
comment on column ASHARETTMHIS.tot_oper_rev_ttm
  is '营业总收入(TTM)';
comment on column ASHARETTMHIS.oper_rev_ttm
  is '营业收入(TTM)';
comment on column ASHARETTMHIS.net_profit_ttm
  is '净利润(TTM)';
comment on column ASHARETTMHIS.net_profit_parent_comp_ttm
  is '归属于母公司的净利润(TTM)';
comment on column ASHARETTMHIS.net_cash_flows_oper_act_ttm
  is '经营活动现金净流量(TTM)';
comment on column ASHARETTMHIS.net_incr_cash_cash_equ_ttm
  is '现金净流量(TTM)';
comment on column ASHARETTMHIS.crncy_code
  is '货币代码';
comment on column ASHARETTMHIS.s_fa_cost_ttm
  is '营业成本-非金融类(TTM)';
comment on column ASHARETTMHIS.s_fa_expense_ttm
  is '营业支出-金融类(TTM)';
comment on column ASHARETTMHIS.s_fa_grossmargin_ttm
  is '毛利(TTM)';
comment on column ASHARETTMHIS.s_fa_operateincome_ttm
  is '经营活动净收益(TTM)';
comment on column ASHARETTMHIS.s_fa_investincome_ttm
  is '价值变动净收益(TTM)';
comment on column ASHARETTMHIS.s_fa_op_ttm
  is '营业利润(TTM)';
comment on column ASHARETTMHIS.s_fa_ebt_ttm
  is '利润总额(TTM)';
comment on column ASHARETTMHIS.s_fa_gr_ttm
  is '营业总收入(TTM)';
comment on column ASHARETTMHIS.s_fa_gc_ttm
  is '营业总成本(TTM)';
comment on column ASHARETTMHIS.s_fa_investcashflow_ttm
  is '投资活动现金净流量(TTM)';
comment on column ASHARETTMHIS.s_fa_financecashflow_ttm
  is '筹资活动现金净流量(TTM)';
comment on column ASHARETTMHIS.s_fa_asset_mrq
  is '资产总计(MRQ)';
comment on column ASHARETTMHIS.s_fa_debt_mrq
  is '负债合计(MRQ)';
comment on column ASHARETTMHIS.s_fa_totalequity_mrq
  is '股东权益(MRQ)';
comment on column ASHARETTMHIS.s_fa_equity_mrq
  is '归属于母公司的股东权益(MRQ)';
comment on column ASHARETTMHIS.s_fa_netprofitmargin_ttm
  is '销售净利率(TTM)';
comment on column ASHARETTMHIS.s_fa_grossprofitmargin_ttm
  is '销售毛利率(TTM)';
comment on column ASHARETTMHIS.s_fa_expensetosales_ttm
  is '销售期间费用率(TTM)';
comment on column ASHARETTMHIS.s_fa_profittogr_ttm
  is '净利润/营业总收入(TTM)';
comment on column ASHARETTMHIS.s_fa_operateexpensetogr_ttm
  is '销售费用/营业总收入(TTM)';
comment on column ASHARETTMHIS.s_fa_adminexpensetogr_ttm
  is '管理费用/营业总收入(TTM)';
comment on column ASHARETTMHIS.s_fa_finaexpensetogr_ttm
  is '财务费用/营业总收入(TTM)';
comment on column ASHARETTMHIS.s_fa_impairtogr_ttm
  is '资产减值损失/营业总收入(TTM)';
comment on column ASHARETTMHIS.s_fa_gctogr_ttm
  is '营业总成本/营业总收入(TTM)';
comment on column ASHARETTMHIS.s_fa_optogr_ttm
  is '营业利润/营业总收入(TTM)';
comment on column ASHARETTMHIS.s_fa_roa_ttm
  is '总资产净利率(TTM)';
comment on column ASHARETTMHIS.s_fa_roa2_ttm
  is '总资产报酬率(TTM)';
comment on column ASHARETTMHIS.s_fa_roe_ttm
  is '净资产收益率(TTM)';
comment on column ASHARETTMHIS.s_fa_operateincometoebt_ttm
  is '经营活动净收益/利润总额(TTM)';
comment on column ASHARETTMHIS.s_fa_investincometoebt_ttm
  is '价值变动净收益/利润总额(TTM)';
comment on column ASHARETTMHIS.s_fa_nonoperateprofittoebt_ttm
  is '营业外收支净额/利润总额(TTM)';
comment on column ASHARETTMHIS.s_fa_salescashintoor_ttm
  is '销售商品提供劳务收到的现金/营业收入(TTM)';
comment on column ASHARETTMHIS.s_fa_ocftoor_ttm
  is '经营活动产生的现金流量净额/营业收入(TTM)';
comment on column ASHARETTMHIS.s_fa_ocftooperateincome_ttm
  is '经营活动产生的现金流量净额/经营活动净收益(TTM)';
comment on column ASHARETTMHIS.s_fa_deductedprofit_ttm
  is '扣除非经常性损益后的净利润(TTM)';
comment on column ASHARETTMHIS.s_fa_ebitda_ttm_inverse
  is 'EBITDA(TTM反推法)';
comment on column ASHARETTMHIS.s_fa_ebitda_ttm
  is 'EBITDA(TTM)';
comment on column ASHARETTMHIS.s_fa_ebit_ttm
  is 'EBIT(TTM)';
comment on column ASHARETTMHIS.fa_roic_ttm
  is '投入资本回报率(TTM)';
comment on column ASHARETTMHIS.s_fa_salescashin_ttm
  is '销售商品提供劳务收到的现金(TTM)';
comment on column ASHARETTMHIS.s_fa_operateexpense_ttm
  is '销售费用(TTM)';
comment on column ASHARETTMHIS.s_fa_adminexpense_ttm
  is '管理费用(TTM)';
comment on column ASHARETTMHIS.s_fa_finaexpense_ttm
  is '财务费用(TTM)';
comment on column ASHARETTMHIS.s_fa_expense
  is '期间费用(TTM)';
comment on column ASHARETTMHIS.s_fa_nonoperateprofit_ttm
  is '营业外收支净额(TTM)';
comment on column ASHARETTMHIS.s_fa_impairment_ttm
  is '资产减值损失(TTM)';
comment on column ASHARETTMHIS.s_fa_ebit_ttm_inverse
  is 'EBIT(TTM反推法)';
comment on column ASHARETTMHIS.s_fa_investcapital_mrq
  is '全部投入资本(MRQ)';
comment on column ASHARETTMHIS.fa_roic_ttm2
  is '投入资本回报率ROIC(TTM)';
comment on column ASHARETTMHIS.s_stm_bsmrq
  is '固定资产合计(MRQ)';
comment on column ASHARETTMHIS.s_fa_nonopprofit_ttm
  is '非营业利润(TTM)';
comment on column ASHARETTMHIS.s_fa_prefinexp_op_ttm
  is '扣除财务费用前营业利润(TTM)';
comment on column ASHARETTMHIS.s_fa_optoebt_ttm
  is '营业利润/利润总额(TTM)';
comment on column ASHARETTMHIS.s_fa_noptoebt_ttm
  is '非营业利润/利润总额(TTM)';
comment on column ASHARETTMHIS.s_fa_taxtoebt_ttm
  is '税项/利润总额(TTM)';
comment on column ASHARETTMHIS.s_fa_optoor_ttm
  is '营业利润/营业收入(TTM)';
comment on column ASHARETTMHIS.s_fa_ebttoor_ttm
  is '利润总额/营业收入(TTM)';
comment on column ASHARETTMHIS.s_fa_prefinexpoptoor_ttm
  is '扣除融资费用前营业利润/营业收入(TTM)';
comment on column ASHARETTMHIS.s_fa_netprofittoor_ttm
  is '归属母公司股东的净利润/营业收入(TTM)';
comment on column ASHARETTMHIS.s_fa_prefinexpoptoebt_ttm
  is '扣除融资费用前营业利润/利润总额(TTM)';
comment on column ASHARETTMHIS.s_fa_ocftoop_ttm
  is '经营活动产生的现金流量净额/营业利润(TTM)';
comment on column ASHARETTMHIS.roa_exclminintinc_ttm
  is '总资产净利率-不含少数股东损益(TTM)';
comment on column ASHARETTMHIS.s_fa_debttoassets_mrq
  is '资产负债率(MRQ)';
comment on column ASHARETTMHIS.int_exp_ttm
  is '利息支出(TTM)';
comment on column ASHARETTMHIS.inc_tax_ttm
  is '所得税(TTM)';
comment on column ASHARETTMHIS.minority_int_ttm
  is '少数股东权益(TTM)';
comment on column ASHARETTMHIS.continuous_net_op_ttm
  is '持续经营净利润(TTM)';
comment on column ASHARETTMHIS.noncontinuous_net_op_ttm
  is '非持续经营净利润(TTM)';
comment on column ASHARETTMHIS.nonnetoptotaxprofit
  is '非持续经营净利润/税后利润(TTM)';
comment on column ASHARETTMHIS.netoptotaxprofit
  is '持续经营净利润/税后利润(TTM)';
comment on column ASHARETTMHIS.s_info_windcode
  is 'Wind代码';
alter table ASHARETTMHIS
  add primary key (OBJECT_ID);


create table ASHAREINDUSTRIESCODE
(
  object_id       VARCHAR2(100) not null,
  industriescode  VARCHAR2(38),
  industriesname  VARCHAR2(50),
  levelnum        NUMBER(1),
  used            NUMBER(1),
  industriesalias VARCHAR2(12),
  opdate          DATE,
  opmode          VARCHAR2(1),
  sequence        NUMBER(4),
  memo            VARCHAR2(100)
)
;
comment on column ASHAREINDUSTRIESCODE.object_id
  is '对象ID';
comment on column ASHAREINDUSTRIESCODE.industriescode
  is '行业代码';
comment on column ASHAREINDUSTRIESCODE.industriesname
  is '行业名称';
comment on column ASHAREINDUSTRIESCODE.levelnum
  is '级数';
comment on column ASHAREINDUSTRIESCODE.used
  is '是否有效';
comment on column ASHAREINDUSTRIESCODE.industriesalias
  is '板块别名';
comment on column ASHAREINDUSTRIESCODE.sequence
  is '展示序号';
comment on column ASHAREINDUSTRIESCODE.memo
  is '备注';
create index IDX_ASHAREINDUSTRIESCODE1 on ASHAREINDUSTRIESCODE (INDUSTRIESCODE);
alter table ASHAREINDUSTRIESCODE
  add primary key (OBJECT_ID);


create table ASHARESWINDUSTRIESCLASS
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  sw_ind_code     VARCHAR2(50),
  entry_dt        VARCHAR2(8),
  remove_dt       VARCHAR2(8),
  cur_sign        VARCHAR2(10),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column ASHARESWINDUSTRIESCLASS.object_id
  is '对象ID';
comment on column ASHARESWINDUSTRIESCLASS.s_info_windcode
  is 'Wind代码';
comment on column ASHARESWINDUSTRIESCLASS.sw_ind_code
  is '申万行业代码';
comment on column ASHARESWINDUSTRIESCLASS.entry_dt
  is '纳入日期';
comment on column ASHARESWINDUSTRIESCLASS.remove_dt
  is '剔除日期';
comment on column ASHARESWINDUSTRIESCLASS.cur_sign
  is '最新标志';
create index IDX_ASHARESWINDUSTRIESCLASS1 on ASHARESWINDUSTRIESCLASS (S_INFO_WINDCODE);
create index IDX_ASHARESWINDUSTRIESCLASS2 on ASHARESWINDUSTRIESCLASS (CUR_SIGN);
alter table ASHARESWINDUSTRIESCLASS
  add primary key (OBJECT_ID);


create table AINDEXHS300WEIGHT
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  s_con_windcode  VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  i_weight        NUMBER(20,4),
  s_in_index      NUMBER(20,2),
  i_weight_11     NUMBER(20,2),
  i_weight_12     NUMBER(20,4),
  i_weight_14     NUMBER(20,8),
  i_weight_15     NUMBER(20,4),
  i_weight_16     NUMBER(20,4),
  i_weight_17     NUMBER(20,2),
  i_weight_18     NUMBER(20,2),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column AINDEXHS300WEIGHT.object_id
  is '对象ID';
comment on column AINDEXHS300WEIGHT.s_info_windcode
  is '指数Wind代码';
comment on column AINDEXHS300WEIGHT.s_con_windcode
  is '成份股Wind代码';
comment on column AINDEXHS300WEIGHT.trade_dt
  is '交易日期';
comment on column AINDEXHS300WEIGHT.i_weight
  is '权重';
comment on column AINDEXHS300WEIGHT.s_in_index
  is '计算用股本(股)';
comment on column AINDEXHS300WEIGHT.i_weight_11
  is '总股本(股)';
comment on column AINDEXHS300WEIGHT.i_weight_12
  is '自由流通比例(%)(归档后)';
comment on column AINDEXHS300WEIGHT.i_weight_14
  is '权重因子';
comment on column AINDEXHS300WEIGHT.i_weight_15
  is '收盘';
comment on column AINDEXHS300WEIGHT.i_weight_16
  is '调整后开盘参考价';
comment on column AINDEXHS300WEIGHT.i_weight_17
  is '总市值';
comment on column AINDEXHS300WEIGHT.i_weight_18
  is '计算用市值';
create index IDX_AINDEXHS300WEIGHT1 on AINDEXHS300WEIGHT (S_INFO_WINDCODE);
create index IDX_AINDEXHS300WEIGHT3 on AINDEXHS300WEIGHT (S_CON_WINDCODE);
create index IDX_AINDEXHS300WEIGHT_1 on AINDEXHS300WEIGHT (S_INFO_WINDCODE, S_CON_WINDCODE, TRADE_DT);
create index IDX_AINDEXHS300WEIGHT_2 on AINDEXHS300WEIGHT (S_CON_WINDCODE, TRADE_DT);
create index IDX_AINDEXHS300WEIGHT_3 on AINDEXHS300WEIGHT (TRADE_DT);
alter table AINDEXHS300WEIGHT
  add primary key (OBJECT_ID);


create table ASHARECONSEPTION
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  wind_sec_code   VARCHAR2(50),
  wind_sec_name   VARCHAR2(100),
  entry_dt        VARCHAR2(8),
  remove_dt       VARCHAR2(8),
  cur_sign        VARCHAR2(10),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column ASHARECONSEPTION.object_id
  is '对象ID';
comment on column ASHARECONSEPTION.s_info_windcode
  is 'Wind代码';
comment on column ASHARECONSEPTION.wind_sec_code
  is 'Wind概念板块代码';
comment on column ASHARECONSEPTION.wind_sec_name
  is 'Wind概念板块名称';
comment on column ASHARECONSEPTION.entry_dt
  is '纳入日期';
comment on column ASHARECONSEPTION.remove_dt
  is '剔除日期';
comment on column ASHARECONSEPTION.cur_sign
  is '最新标志';
create index PK_ASHARECONSEPTION on ASHARECONSEPTION (S_INFO_WINDCODE, ENTRY_DT, REMOVE_DT);
alter table ASHARECONSEPTION
  add primary key (OBJECT_ID);


create table AINDEXCSI500WEIGHT
(
  object_id       VARCHAR2(100) not null,
  trade_dt        VARCHAR2(10),
  s_info_windcode VARCHAR2(40),
  indexname       VARCHAR2(40),
  indexname_eng   VARCHAR2(100),
  s_con_windcode  VARCHAR2(40),
  exchange        VARCHAR2(20),
  tot_shr         NUMBER(20,2),
  free_shr_ratio  NUMBER(20,4),
  shr_calculation NUMBER(20,2),
  weightfactor    NUMBER(20,8),
  closevalue      NUMBER(20,4),
  open_adjusted   NUMBER(20,4),
  tot_mv          NUMBER(20,2),
  mv_calculation  NUMBER(20,2),
  weight          NUMBER(20,4),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column AINDEXCSI500WEIGHT.object_id
  is '对象ID';
comment on column AINDEXCSI500WEIGHT.trade_dt
  is '生效日期';
comment on column AINDEXCSI500WEIGHT.s_info_windcode
  is 'Wind代码';
comment on column AINDEXCSI500WEIGHT.indexname
  is '指数名称';
comment on column AINDEXCSI500WEIGHT.indexname_eng
  is '指数英文名称';
comment on column AINDEXCSI500WEIGHT.s_con_windcode
  is 'Wind代码';
comment on column AINDEXCSI500WEIGHT.exchange
  is '交易所';
comment on column AINDEXCSI500WEIGHT.tot_shr
  is '总股本(股)';
comment on column AINDEXCSI500WEIGHT.free_shr_ratio
  is '自由流通比例(%)(归档后)';
comment on column AINDEXCSI500WEIGHT.shr_calculation
  is '计算用股本(股)';
comment on column AINDEXCSI500WEIGHT.weightfactor
  is '权重因子';
comment on column AINDEXCSI500WEIGHT.closevalue
  is '收盘';
comment on column AINDEXCSI500WEIGHT.open_adjusted
  is '调整后开盘参考价';
comment on column AINDEXCSI500WEIGHT.tot_mv
  is '总市值';
comment on column AINDEXCSI500WEIGHT.mv_calculation
  is '计算用市值';
comment on column AINDEXCSI500WEIGHT.weight
  is '权重(%)';
create index IDX_AINDEXCSI500WEIGHT1 on AINDEXCSI500WEIGHT (S_INFO_WINDCODE);
create index IDX_AINDEXCSI500WEIGHT2 on AINDEXCSI500WEIGHT (S_CON_WINDCODE);
create index IDX_AINDEXCSI500WEIGHT3 on AINDEXCSI500WEIGHT (TRADE_DT);
create index PK_AINDEXCSI500WEIGHT on AINDEXCSI500WEIGHT (TRADE_DT, S_INFO_WINDCODE, S_CON_WINDCODE);
alter table AINDEXCSI500WEIGHT
  add primary key (OBJECT_ID);


create table CFUTURESDESCRIPTION
(
  object_id         VARCHAR2(100) not null,
  s_info_windcode   VARCHAR2(40),
  s_info_code       VARCHAR2(40),
  s_info_name       VARCHAR2(50),
  s_info_ename      VARCHAR2(200),
  fs_info_sccode    VARCHAR2(50),
  fs_info_type      NUMBER(1),
  fs_info_cctype    NUMBER(9),
  s_info_exchmarket VARCHAR2(10),
  s_info_listdate   VARCHAR2(8),
  s_info_delistdate VARCHAR2(8),
  fs_info_dlmonth   VARCHAR2(8),
  fs_info_lprice    NUMBER(20,4),
  fs_info_ltdldate  VARCHAR2(8),
  opdate            DATE,
  opmode            VARCHAR2(1),
  s_info_fullname   VARCHAR2(40)
)
;
create index IDX_CFUTURESDESCRIPTION1 on CFUTURESDESCRIPTION (S_INFO_WINDCODE);
create index IDX_CFUTURESDESC_1 on CFUTURESDESCRIPTION (S_INFO_WINDCODE, S_INFO_CODE);
alter table CFUTURESDESCRIPTION
  add primary key (OBJECT_ID);


create table CFUTURESCONTPRO
(
  object_id            VARCHAR2(38) not null,
  s_info_windcode      VARCHAR2(40),
  s_info_code          VARCHAR2(20),
  s_info_name          VARCHAR2(40),
  s_info_tunit         VARCHAR2(40),
  s_info_punit         NUMBER(20,4),
  s_info_mfprice       VARCHAR2(200),
  s_info_ftmargins     VARCHAR2(800),
  s_info_cdmonths      VARCHAR2(200),
  s_info_thours        VARCHAR2(800),
  s_info_ltdated       VARCHAR2(200),
  s_info_ddate         VARCHAR2(400),
  s_info_cemultiplier  NUMBER(20,4),
  s_info_listdate      VARCHAR2(8),
  s_info_delistdate    VARCHAR2(8),
  s_info_exname        VARCHAR2(20),
  s_info_dmean         VARCHAR2(400),
  s_info_dsite         VARCHAR2(400),
  s_info_ltdatehour    VARCHAR2(400),
  s_info_cevalue       VARCHAR2(400),
  s_info_maxpricefluct VARCHAR2(800),
  s_info_poslimit      VARCHAR2(800),
  opdate               DATE,
  opmode               VARCHAR2(1),
  s_info_udlsecode     VARCHAR2(20),
  fs_info_punit        VARCHAR2(200),
  s_info_rtd           NUMBER(20,4),
  s_sub_typcode        NUMBER(9),
  contract_id          VARCHAR2(10)
)
;
alter table CFUTURESCONTPRO
  add primary key (OBJECT_ID);


create table CFUTURESMARGINRATIO
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  marginratio     VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column CFUTURESMARGINRATIO.object_id
  is '对象ID';
comment on column CFUTURESMARGINRATIO.s_info_windcode
  is '合约Wind代码';
comment on column CFUTURESMARGINRATIO.marginratio
  is '保证金比例';
comment on column CFUTURESMARGINRATIO.trade_dt
  is '变动日期';
create index PK_CFUTURESMARGINRATIO on CFUTURESMARGINRATIO (S_INFO_WINDCODE, TRADE_DT);
alter table CFUTURESMARGINRATIO
  add primary key (OBJECT_ID);


create table HS300IEODPRICES
(
  object_id       VARCHAR2(38) not null,
  s_info_windcode VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  crncy_code      VARCHAR2(10),
  pre_close       NUMBER(20,4),
  open            NUMBER(20,4),
  high            NUMBER(20,4),
  low             NUMBER(20,4),
  close           NUMBER(20,4),
  chg             NUMBER(20,4),
  pct_chg         NUMBER(20,4),
  volume          NUMBER(20,4),
  amt             NUMBER(20,4),
  opdate          DATE,
  opmode          VARCHAR2(1),
  s_dq_open       NUMBER(20,4),
  s_dq_high       NUMBER(20,4),
  s_dq_low        NUMBER(20,4),
  s_dq_close      NUMBER(20,4)
)
;
comment on column HS300IEODPRICES.object_id
  is '对象ID';
comment on column HS300IEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column HS300IEODPRICES.trade_dt
  is '交易日期';
comment on column HS300IEODPRICES.crncy_code
  is '货币代码';
comment on column HS300IEODPRICES.pre_close
  is '昨收盘价(点)';
comment on column HS300IEODPRICES.chg
  is '涨跌(点)';
comment on column HS300IEODPRICES.pct_chg
  is '涨跌幅(%)';
comment on column HS300IEODPRICES.volume
  is '成交量(手)';
comment on column HS300IEODPRICES.amt
  is '成交金额(千元)';
comment on column HS300IEODPRICES.s_dq_open
  is '开盘价(点)';
comment on column HS300IEODPRICES.s_dq_high
  is '最高价(点)';
comment on column HS300IEODPRICES.s_dq_low
  is '最低价(点)';
comment on column HS300IEODPRICES.s_dq_close
  is '收盘价(点)';
create index PK_HS300IEODPRICES on HS300IEODPRICES (S_INFO_WINDCODE, TRADE_DT);
alter table HS300IEODPRICES
  add primary key (OBJECT_ID);


create table HKEXCALENDAR
(
  object_id         VARCHAR2(100) not null,
  trade_days        VARCHAR2(8),
  s_info_exchmarket VARCHAR2(40),
  opdate            DATE,
  opmode            VARCHAR2(1)
)
;
comment on column HKEXCALENDAR.object_id
  is '对象ID';
comment on column HKEXCALENDAR.trade_days
  is '日期';
comment on column HKEXCALENDAR.s_info_exchmarket
  is '交易所英文简称';
create index PK_HKEXCALENDAR on HKEXCALENDAR (TRADE_DAYS);
alter table HKEXCALENDAR
  add primary key (OBJECT_ID);


create table HKSHAREDESCRIPTION
(
  object_id           VARCHAR2(100) not null,
  s_info_windcode     VARCHAR2(40),
  s_info_code         VARCHAR2(40),
  s_info_isincode     VARCHAR2(40),
  s_info_name         VARCHAR2(50),
  s_info_name_eng     VARCHAR2(200),
  s_info_fullname     VARCHAR2(100),
  s_info_fullname_eng VARCHAR2(200),
  securityclass       NUMBER(9),
  securitysubclass    NUMBER(9),
  securitytype        VARCHAR2(10),
  s_info_countrycode  VARCHAR2(10),
  s_info_exchange_eng VARCHAR2(40),
  s_info_exchange     VARCHAR2(40),
  s_info_listboard    VARCHAR2(10),
  s_info_compcode     VARCHAR2(10),
  s_info_status       NUMBER(9),
  crncy_code          VARCHAR2(10),
  s_info_par          NUMBER(24,8),
  min_prc_chg_unit    NUMBER(24,8),
  s_info_unitperlot   NUMBER(20,4),
  s_info_listdate     VARCHAR2(8),
  s_info_delistdate   VARCHAR2(8),
  s_info_listprice    NUMBER(24,8),
  is_hksc             NUMBER(5),
  istemporarysymbol   NUMBER(5),
  is_h                NUMBER(1),
  opdate              DATE,
  opmode              VARCHAR2(1)
)
;
comment on column HKSHAREDESCRIPTION.object_id
  is '对象ID';
comment on column HKSHAREDESCRIPTION.s_info_windcode
  is 'Wind代码';
comment on column HKSHAREDESCRIPTION.s_info_code
  is '交易代码';
comment on column HKSHAREDESCRIPTION.s_info_isincode
  is '[内部]ISIN代码';
comment on column HKSHAREDESCRIPTION.s_info_name
  is '证券中文简称';
comment on column HKSHAREDESCRIPTION.s_info_name_eng
  is '[内部]证券英文简称';
comment on column HKSHAREDESCRIPTION.s_info_fullname
  is '[内部]证券中文全称';
comment on column HKSHAREDESCRIPTION.s_info_fullname_eng
  is '[内部]证券英文全称';
comment on column HKSHAREDESCRIPTION.securityclass
  is '品种大类代码';
comment on column HKSHAREDESCRIPTION.securitysubclass
  is '品种细类代码';
comment on column HKSHAREDESCRIPTION.securitytype
  is '品种类型(兼容)';
comment on column HKSHAREDESCRIPTION.s_info_countrycode
  is '国家及地区代码';
comment on column HKSHAREDESCRIPTION.s_info_exchange_eng
  is '交易所英文简称';
comment on column HKSHAREDESCRIPTION.s_info_exchange
  is '交易所名称(兼容)';
comment on column HKSHAREDESCRIPTION.s_info_listboard
  is '上市板';
comment on column HKSHAREDESCRIPTION.s_info_compcode
  is '公司id';
comment on column HKSHAREDESCRIPTION.s_info_status
  is '存续状态';
comment on column HKSHAREDESCRIPTION.crncy_code
  is '交易币种';
comment on column HKSHAREDESCRIPTION.s_info_par
  is '面值';
comment on column HKSHAREDESCRIPTION.min_prc_chg_unit
  is '最小价格变动单位';
comment on column HKSHAREDESCRIPTION.s_info_unitperlot
  is '每手数量';
comment on column HKSHAREDESCRIPTION.s_info_listdate
  is '开始交易日期';
comment on column HKSHAREDESCRIPTION.s_info_delistdate
  is '最后交易日期';
comment on column HKSHAREDESCRIPTION.s_info_listprice
  is '挂牌价';
comment on column HKSHAREDESCRIPTION.is_hksc
  is '是否在港股通范围内';
comment on column HKSHAREDESCRIPTION.istemporarysymbol
  is '是否并行临时代码';
comment on column HKSHAREDESCRIPTION.is_h
  is '是否是H股';
create index IDX_HKDESCRIPTION_NAME on HKSHAREDESCRIPTION (S_INFO_NAME);
create index PK_HKSHAREDESCRIPTION1 on HKSHAREDESCRIPTION (S_INFO_WINDCODE);
create index PK_HKSHAREDESCRIPTION2 on HKSHAREDESCRIPTION (S_INFO_CODE);
alter table HKSHAREDESCRIPTION
  add primary key (OBJECT_ID);


create table HKBALANCESHEETSIMPLE
(
  object_id          VARCHAR2(100) not null,
  s_info_compcode    VARCHAR2(40),
  report_type        VARCHAR2(100),
  statement_type     VARCHAR2(40),
  report_period      VARCHAR2(8),
  tot_cur_assets     NUMBER(20,4),
  tot_non_cur_assets NUMBER(20,4),
  tot_assets         NUMBER(20,4),
  tot_cur_liab       NUMBER(20,4),
  tot_non_cur_liab   NUMBER(20,4),
  total_liabilities  NUMBER(20,4),
  parsh_int          NUMBER(20,4),
  minority_int       NUMBER(20,4),
  tot_shrhldr_eqy    NUMBER(20,4),
  crncy_code         VARCHAR2(10),
  ann_dt             VARCHAR2(8),
  acc_sta_code       NUMBER(9),
  opdate             DATE,
  opmode             VARCHAR2(1)
)
;
comment on column HKBALANCESHEETSIMPLE.object_id
  is '对象ID';
comment on column HKBALANCESHEETSIMPLE.s_info_compcode
  is '公司id';
comment on column HKBALANCESHEETSIMPLE.report_type
  is '报告类型代码';
comment on column HKBALANCESHEETSIMPLE.statement_type
  is '报表类型代码';
comment on column HKBALANCESHEETSIMPLE.report_period
  is '截至日期';
comment on column HKBALANCESHEETSIMPLE.tot_cur_assets
  is '流动资产合计';
comment on column HKBALANCESHEETSIMPLE.tot_non_cur_assets
  is '非流动资产合计';
comment on column HKBALANCESHEETSIMPLE.tot_assets
  is '总资产';
comment on column HKBALANCESHEETSIMPLE.tot_cur_liab
  is '流动负债合计';
comment on column HKBALANCESHEETSIMPLE.tot_non_cur_liab
  is '非流动负债合计';
comment on column HKBALANCESHEETSIMPLE.total_liabilities
  is '总负债';
comment on column HKBALANCESHEETSIMPLE.parsh_int
  is '股东权益';
comment on column HKBALANCESHEETSIMPLE.minority_int
  is '少数股东权益';
comment on column HKBALANCESHEETSIMPLE.tot_shrhldr_eqy
  is '股东权益合计';
comment on column HKBALANCESHEETSIMPLE.crncy_code
  is '货币代码';
comment on column HKBALANCESHEETSIMPLE.ann_dt
  is '公告日期';
comment on column HKBALANCESHEETSIMPLE.acc_sta_code
  is '会计准则类型代码';
alter table HKBALANCESHEETSIMPLE
  add primary key (OBJECT_ID);


create table HKINCOMESIMPLE
(
  object_id            VARCHAR2(100) not null,
  s_info_compcode      VARCHAR2(40),
  report_type          VARCHAR2(100),
  statement_type       VARCHAR2(40),
  fiscalyear           VARCHAR2(8),
  begindate            VARCHAR2(8),
  enddate              VARCHAR2(8),
  tot_oper_rev         NUMBER(20,4),
  tot_oper_cost        NUMBER(20,4),
  opprofit             NUMBER(20,4),
  profit_bef_tax       NUMBER(20,4),
  less_tax             NUMBER(20,4),
  minority_int_inc     NUMBER(20,4),
  net_profit_cs        NUMBER(20,4),
  np_belongto_commonsh NUMBER(20,4),
  crncy_code           VARCHAR2(20),
  ann_dt               VARCHAR2(8),
  acc_sta_code         NUMBER(9),
  opdate               DATE,
  opmode               VARCHAR2(1)
)
;
comment on column HKINCOMESIMPLE.object_id
  is '对象ID';
comment on column HKINCOMESIMPLE.s_info_compcode
  is '公司id';
comment on column HKINCOMESIMPLE.report_type
  is '报告类型';
comment on column HKINCOMESIMPLE.statement_type
  is '报表类型代码';
comment on column HKINCOMESIMPLE.fiscalyear
  is '会计年度';
comment on column HKINCOMESIMPLE.begindate
  is '起始日期';
comment on column HKINCOMESIMPLE.enddate
  is '截止日期';
comment on column HKINCOMESIMPLE.tot_oper_rev
  is '总营业收入';
comment on column HKINCOMESIMPLE.tot_oper_cost
  is '总营业支出';
comment on column HKINCOMESIMPLE.opprofit
  is '营业利润';
comment on column HKINCOMESIMPLE.profit_bef_tax
  is '除税前利润(除税前盈利)';
comment on column HKINCOMESIMPLE.less_tax
  is '所得税';
comment on column HKINCOMESIMPLE.minority_int_inc
  is '少数股东损益';
comment on column HKINCOMESIMPLE.net_profit_cs
  is '净利润';
comment on column HKINCOMESIMPLE.np_belongto_commonsh
  is '归属普通股东净利润';
comment on column HKINCOMESIMPLE.crncy_code
  is '货币代码';
comment on column HKINCOMESIMPLE.ann_dt
  is '公告日期';
comment on column HKINCOMESIMPLE.acc_sta_code
  is '会计准则类型代码';
alter table HKINCOMESIMPLE
  add primary key (OBJECT_ID);


create table HKCASHFLOWSIMPLE
(
  object_id               VARCHAR2(100) not null,
  s_info_compcode         VARCHAR2(40),
  report_type             VARCHAR2(100),
  statement_type          VARCHAR2(40),
  begindate               VARCHAR2(8),
  enddate                 VARCHAR2(8),
  net_cash_flows_oper_act NUMBER(20,4),
  net_cash_flows_inv_act  NUMBER(20,4),
  net_cash_flows_fund_act NUMBER(20,4),
  net_incr_cash_cash_equ  NUMBER(20,4),
  crncy_code              VARCHAR2(20),
  ann_dt                  VARCHAR2(8),
  acc_sta_code            NUMBER(9),
  opdate                  DATE,
  opmode                  VARCHAR2(1)
)
;
comment on column HKCASHFLOWSIMPLE.object_id
  is '对象ID';
comment on column HKCASHFLOWSIMPLE.s_info_compcode
  is '公司id';
comment on column HKCASHFLOWSIMPLE.report_type
  is '报告类型代码';
comment on column HKCASHFLOWSIMPLE.statement_type
  is '报表类型代码';
comment on column HKCASHFLOWSIMPLE.begindate
  is '起始日期';
comment on column HKCASHFLOWSIMPLE.enddate
  is '截止日期';
comment on column HKCASHFLOWSIMPLE.net_cash_flows_oper_act
  is '经营活动产生的现金流量净额';
comment on column HKCASHFLOWSIMPLE.net_cash_flows_inv_act
  is '投资活动产生的现金流量净额';
comment on column HKCASHFLOWSIMPLE.net_cash_flows_fund_act
  is '筹资活动产生现金流量净额(融资活动产生的现金流量净额)';
comment on column HKCASHFLOWSIMPLE.net_incr_cash_cash_equ
  is '现金及现金等价物净增加额';
comment on column HKCASHFLOWSIMPLE.crncy_code
  is '货币代码';
comment on column HKCASHFLOWSIMPLE.ann_dt
  is '公告日期';
comment on column HKCASHFLOWSIMPLE.acc_sta_code
  is '会计准则类型代码';
alter table HKCASHFLOWSIMPLE
  add primary key (OBJECT_ID);


create table HKFINANCIALINDICATOR
(
  object_id                  VARCHAR2(100) not null,
  s_info_compcode            VARCHAR2(40),
  report_type                VARCHAR2(100),
  statement_type             VARCHAR2(40),
  begindate                  VARCHAR2(8),
  enddate                    VARCHAR2(8),
  eps_basic                  NUMBER(20,8),
  eps_diluted                NUMBER(20,8),
  bps                        NUMBER(20,8),
  grps                       NUMBER(22,4),
  cash_flows_opera_activ_per NUMBER(20,8),
  net_profit_rate            NUMBER(22,4),
  grossprofitmargin          NUMBER(22,4),
  opprofit_rate              NUMBER(22,4),
  profit_bef_tax_rate        NUMBER(20,4),
  roe                        NUMBER(20,4),
  roa                        NUMBER(20,4),
  roic                       NUMBER(22,4),
  effe_income_tax_rate       NUMBER(22,4),
  ocftoor                    NUMBER(22,4),
  debttoequity               NUMBER(22,4),
  assetstoequity             NUMBER(22,4),
  debttoassets               NUMBER(22,4),
  tot_liab_investcapital     NUMBER(20,4),
  parsh_int_investcapital    NUMBER(22,4),
  quick_ratio                NUMBER(20,4),
  current_ratio              NUMBER(20,4),
  cashtoliqdebt              NUMBER(20,4),
  non_cur_assets_to_equity   NUMBER(20,4),
  ffo_to_tot_liab            NUMBER(22,4),
  ffo_to_tot_cur_liab        NUMBER(22,4),
  invturn                    NUMBER(20,4),
  caturn                     NUMBER(22,4),
  faturn                     NUMBER(22,4),
  assetsturn                 NUMBER(22,4),
  input_costs                NUMBER(22,4),
  crncy_code                 VARCHAR2(10),
  ann_dt                     VARCHAR2(8),
  opdate                     DATE,
  opmode                     VARCHAR2(1)
)
;
comment on column HKFINANCIALINDICATOR.object_id
  is '对象ID';
comment on column HKFINANCIALINDICATOR.s_info_compcode
  is '公司id';
comment on column HKFINANCIALINDICATOR.report_type
  is '报告类型';
comment on column HKFINANCIALINDICATOR.statement_type
  is '报表类型';
comment on column HKFINANCIALINDICATOR.begindate
  is '起始日期';
comment on column HKFINANCIALINDICATOR.enddate
  is '截止日期';
comment on column HKFINANCIALINDICATOR.eps_basic
  is '每股收益-基本';
comment on column HKFINANCIALINDICATOR.eps_diluted
  is '每股收益-稀释';
comment on column HKFINANCIALINDICATOR.bps
  is '每股净资产';
comment on column HKFINANCIALINDICATOR.grps
  is '每股总营业收入';
comment on column HKFINANCIALINDICATOR.cash_flows_opera_activ_per
  is '每股经营性现金流量';
comment on column HKFINANCIALINDICATOR.net_profit_rate
  is '净利润率';
comment on column HKFINANCIALINDICATOR.grossprofitmargin
  is '销售毛利率';
comment on column HKFINANCIALINDICATOR.opprofit_rate
  is '营业利润率';
comment on column HKFINANCIALINDICATOR.profit_bef_tax_rate
  is '税前利润率(%)';
comment on column HKFINANCIALINDICATOR.roe
  is '平均净资产收益率';
comment on column HKFINANCIALINDICATOR.roa
  is '平均总资产报酬率';
comment on column HKFINANCIALINDICATOR.roic
  is '投入资本回报率ROIC';
comment on column HKFINANCIALINDICATOR.effe_income_tax_rate
  is '有效所得税率';
comment on column HKFINANCIALINDICATOR.ocftoor
  is '经营活动产生的现金流量净额/总营业收入';
comment on column HKFINANCIALINDICATOR.debttoequity
  is '产权比率';
comment on column HKFINANCIALINDICATOR.assetstoequity
  is '权益乘数';
comment on column HKFINANCIALINDICATOR.debttoassets
  is '资产负债率';
comment on column HKFINANCIALINDICATOR.tot_liab_investcapital
  is '总负债/投入资本(%)';
comment on column HKFINANCIALINDICATOR.parsh_int_investcapital
  is '归属母公司股东权益/投入资本';
comment on column HKFINANCIALINDICATOR.quick_ratio
  is '速动比率(倍)';
comment on column HKFINANCIALINDICATOR.current_ratio
  is '流动比率(倍)';
comment on column HKFINANCIALINDICATOR.cashtoliqdebt
  is '货币资金／流动负债 ';
comment on column HKFINANCIALINDICATOR.non_cur_assets_to_equity
  is '非流动负债合计/股东权益(%)';
comment on column HKFINANCIALINDICATOR.ffo_to_tot_liab
  is '经营活动产生的现金流量净额/总负债';
comment on column HKFINANCIALINDICATOR.ffo_to_tot_cur_liab
  is '经营活动产生的现金流量净额/流动负债合计';
comment on column HKFINANCIALINDICATOR.invturn
  is '存货周转率(倍)';
comment on column HKFINANCIALINDICATOR.caturn
  is '流动资产周转率';
comment on column HKFINANCIALINDICATOR.faturn
  is '固定资产周转率';
comment on column HKFINANCIALINDICATOR.assetsturn
  is '总资产周转率';
comment on column HKFINANCIALINDICATOR.input_costs
  is '投入资本';
comment on column HKFINANCIALINDICATOR.crncy_code
  is '货币代码';
comment on column HKFINANCIALINDICATOR.ann_dt
  is '公告日期';
alter table HKFINANCIALINDICATOR
  add primary key (OBJECT_ID);


create table HKSTOCKHSINDUSTRIESMEMBERS
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  hs_ind_code     VARCHAR2(50),
  entry_dt        VARCHAR2(8),
  remove_dt       VARCHAR2(8),
  cur_sign        NUMBER(1),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
alter table HKSTOCKHSINDUSTRIESMEMBERS
  add primary key (OBJECT_ID);


create table HKSTOCKINDUSTRIESCODE
(
  object_id       VARCHAR2(100) not null,
  industriesclass VARCHAR2(100),
  industriescode  VARCHAR2(38),
  industriesname  VARCHAR2(50),
  levelnum        NUMBER(1),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column HKSTOCKINDUSTRIESCODE.object_id
  is '对象ID';
comment on column HKSTOCKINDUSTRIESCODE.industriesclass
  is '行业分类';
comment on column HKSTOCKINDUSTRIESCODE.industriescode
  is '行业代码';
comment on column HKSTOCKINDUSTRIESCODE.industriesname
  is '行业名称';
comment on column HKSTOCKINDUSTRIESCODE.levelnum
  is '级数';
alter table HKSTOCKINDUSTRIESCODE
  add primary key (OBJECT_ID);


create table HKSHAREEODDERIVATIVEINDEX
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
;
comment on column HKSHAREEODDERIVATIVEINDEX.object_id
  is '对象ID';
comment on column HKSHAREEODDERIVATIVEINDEX.s_info_windcode
  is 'Wind代码';
comment on column HKSHAREEODDERIVATIVEINDEX.financial_trade_dt
  is '交易日期';
comment on column HKSHAREEODDERIVATIVEINDEX.trade_crncy_code
  is '交易币种代码';
comment on column HKSHAREEODDERIVATIVEINDEX.tot_shr_today
  is '当日总股本';
comment on column HKSHAREEODDERIVATIVEINDEX.float_a_shr_today
  is '当日流通股本';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_mv
  is '当日总市值';
comment on column HKSHAREEODDERIVATIVEINDEX.s_dq_mv
  is '当日流通市值';
comment on column HKSHAREEODDERIVATIVEINDEX.s_dq_close_today
  is '当日收盘价';
comment on column HKSHAREEODDERIVATIVEINDEX.s_pq_high_52w
  is '52周最高价';
comment on column HKSHAREEODDERIVATIVEINDEX.s_pq_low_52w
  is '52周最低价';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_pb_new
  is '市净率(PB)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_pe_lyr
  is '市盈率(PE,LYR)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_pe_ttm
  is '市盈率(PE,TTM)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_pcf_ocflyr
  is '市现率(经营现金流LYR)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_pcf_ocfttm
  is '市现率(经营现金流TTM)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_pcf_ncflyr
  is '市现率(现金净流量LYR)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_pcf_ncfttm
  is '市现率(现金净流量TTM)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_ps_lyr
  is '市销率(PS,LYR)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_val_ps_ttm
  is '市销率(PS,TTM)';
comment on column HKSHAREEODDERIVATIVEINDEX.s_dq_turn
  is '换手率';
comment on column HKSHAREEODDERIVATIVEINDEX.crncy_code
  is '财务币种代码';
comment on column HKSHAREEODDERIVATIVEINDEX.net_assets_today
  is '当日净资产';
comment on column HKSHAREEODDERIVATIVEINDEX.net_profit_parent_comp_lyr
  is '归属母公司净利润(LYR)';
comment on column HKSHAREEODDERIVATIVEINDEX.net_profit_parent_comp_ttm
  is '归属母公司净利润(TTM)';
comment on column HKSHAREEODDERIVATIVEINDEX.net_cash_flows_oper_act_lyr
  is '经营活动产生的现金流量净额(LYR)';
comment on column HKSHAREEODDERIVATIVEINDEX.net_cash_flows_oper_act_ttm
  is '经营活动产生的现金流量净额(TTM)';
comment on column HKSHAREEODDERIVATIVEINDEX.oper_rev_lyr
  is '营业收入(LYR)';
comment on column HKSHAREEODDERIVATIVEINDEX.oper_rev_ttm
  is '营业收入(TTM)';
comment on column HKSHAREEODDERIVATIVEINDEX.net_incr_cash_cash_equ_lyr
  is '现金及现金等价物净增加额(LYR)';
comment on column HKSHAREEODDERIVATIVEINDEX.net_incr_cash_cash_equ_ttm
  is '现金及现金等价物净增加额(TTM)';
create index IX_HKSHAREEODDERIVATIVEINDEX on HKSHAREEODDERIVATIVEINDEX (FINANCIAL_TRADE_DT);
create index PK_HKSHAREEODDERIVATIVEINDEX on HKSHAREEODDERIVATIVEINDEX (S_INFO_WINDCODE, FINANCIAL_TRADE_DT);
alter table HKSHAREEODDERIVATIVEINDEX
  add primary key (OBJECT_ID);


create table CBONDDESCRIPTION
(
  object_id                VARCHAR2(100) not null,
  s_info_windcode          VARCHAR2(40),
  b_info_fullname          VARCHAR2(100),
  b_info_issuer            VARCHAR2(100),
  b_issue_announcement     VARCHAR2(8),
  b_issue_firstissue       VARCHAR2(8),
  b_issue_lastissue        VARCHAR2(8),
  b_issue_amountplan       NUMBER(20,4),
  b_issue_amountact        NUMBER(20,4),
  b_info_issueprice        NUMBER(20,4),
  b_info_par               NUMBER(20),
  b_info_couponrate        NUMBER(20,4),
  b_info_spread            NUMBER(20,4),
  b_info_carrydate         VARCHAR2(8),
  b_info_enddate           VARCHAR2(8),
  b_info_maturitydate      VARCHAR2(8),
  b_info_term_year_        NUMBER(20,4),
  b_info_term_day_         NUMBER(20,4),
  b_info_paymentdate       VARCHAR2(8),
  b_info_paymenttype       NUMBER(9),
  b_info_interestfrequency VARCHAR2(20),
  b_info_form              VARCHAR2(10),
  b_info_coupon            NUMBER(9),
  b_info_interesttype      NUMBER(9),
  b_info_act               NUMBER(20,4),
  b_issue_fee              NUMBER(20,4),
  b_redemption_feeration   NUMBER(20,4),
  b_info_taxrate           NUMBER(20,4),
  crncy_code               VARCHAR2(10),
  s_info_name              VARCHAR2(50),
  s_info_exchmarket        VARCHAR2(10),
  b_info_guarantor         VARCHAR2(100),
  b_info_guartype          NUMBER(9),
  b_info_listdate          VARCHAR2(8),
  b_info_yearsnumber       NUMBER(20),
  s_div_recorddate         VARCHAR2(8),
  b_info_codebyplacing     VARCHAR2(10),
  b_info_delistdate        VARCHAR2(8),
  b_info_issuetype         NUMBER(9),
  b_info_guarintroduction  VARCHAR2(500),
  b_info_bgndbyplacing     VARCHAR2(8),
  b_info_enddbyplacing     VARCHAR2(8),
  b_info_amountbyplacing   NUMBER(20,4),
  b_info_underwritingcode  NUMBER(9),
  b_info_issuercode        VARCHAR2(100),
  b_info_formercode        VARCHAR2(40),
  b_info_coupontxt         VARCHAR2(1000),
  is_failure               NUMBER(5),
  is_crossmarket           NUMBER(5),
  b_info_coupondatetxt     VARCHAR2(1000),
  b_info_subordinateornot  NUMBER(5),
  b_tendrst_referyield     NUMBER(20,4),
  b_info_curpar            NUMBER(20,4),
  s_info_formerwindcode    VARCHAR2(40),
  is_corporate_bond        NUMBER(5),
  b_info_issuertype        VARCHAR2(40),
  b_info_specialbondtype   VARCHAR2(40),
  is_payadvanced           VARCHAR2(1),
  is_callable              VARCHAR2(1),
  is_chooseright           VARCHAR2(1),
  is_netprice              NUMBER(1),
  is_act_days              NUMBER(1),
  is_incbonds              NUMBER(5),
  issue_object             VARCHAR2(100),
  b_info_actualbenchmark   VARCHAR2(8),
  register_file_type_code  NUMBER(9),
  register_file_number     VARCHAR2(1000),
  list_ann_date            VARCHAR2(8),
  reimbursement            VARCHAR2(20),
  bond_rating              VARCHAR2(10),
  ann_date                 VARCHAR2(8),
  b_issue_amount_max       NUMBER(24,8),
  opdate                   DATE,
  opmode                   VARCHAR2(1)
)
;
comment on column CBONDDESCRIPTION.object_id
  is '对象ID';
comment on column CBONDDESCRIPTION.s_info_windcode
  is 'Wind代码';
comment on column CBONDDESCRIPTION.b_info_fullname
  is '债券名称';
comment on column CBONDDESCRIPTION.b_info_issuer
  is '发行人';
comment on column CBONDDESCRIPTION.b_issue_announcement
  is '发行公告日';
comment on column CBONDDESCRIPTION.b_issue_firstissue
  is '发行起始日';
comment on column CBONDDESCRIPTION.b_issue_lastissue
  is '发行截止日';
comment on column CBONDDESCRIPTION.b_issue_amountplan
  is '计划发行总量(亿元)';
comment on column CBONDDESCRIPTION.b_issue_amountact
  is '实际发行总量(亿元)';
comment on column CBONDDESCRIPTION.b_info_issueprice
  is '发行价格';
comment on column CBONDDESCRIPTION.b_info_par
  is '面值';
comment on column CBONDDESCRIPTION.b_info_couponrate
  is '发行票面利率(%)';
comment on column CBONDDESCRIPTION.b_info_spread
  is '利差(%)';
comment on column CBONDDESCRIPTION.b_info_carrydate
  is '计息起始日';
comment on column CBONDDESCRIPTION.b_info_enddate
  is '计息截止日';
comment on column CBONDDESCRIPTION.b_info_maturitydate
  is '到期日';
comment on column CBONDDESCRIPTION.b_info_term_year_
  is '债券期限(年)';
comment on column CBONDDESCRIPTION.b_info_term_day_
  is '债券期限(天)';
comment on column CBONDDESCRIPTION.b_info_paymentdate
  is '兑付日';
comment on column CBONDDESCRIPTION.b_info_paymenttype
  is '计息方式';
comment on column CBONDDESCRIPTION.b_info_interestfrequency
  is '付息频率';
comment on column CBONDDESCRIPTION.b_info_form
  is '债券形式';
comment on column CBONDDESCRIPTION.b_info_coupon
  is '息票品种';
comment on column CBONDDESCRIPTION.b_info_interesttype
  is '附息利率品种';
comment on column CBONDDESCRIPTION.b_info_act
  is '特殊年计息天数';
comment on column CBONDDESCRIPTION.b_issue_fee
  is '发行手续费率(%)';
comment on column CBONDDESCRIPTION.b_redemption_feeration
  is '兑付手续费率(%)';
comment on column CBONDDESCRIPTION.b_info_taxrate
  is '所得税率';
comment on column CBONDDESCRIPTION.crncy_code
  is '货币代码';
comment on column CBONDDESCRIPTION.s_info_name
  is '债券简称';
comment on column CBONDDESCRIPTION.s_info_exchmarket
  is '交易所';
comment on column CBONDDESCRIPTION.b_info_guarantor
  is '担保人';
comment on column CBONDDESCRIPTION.b_info_guartype
  is '担保方式';
comment on column CBONDDESCRIPTION.b_info_listdate
  is '上市日期';
comment on column CBONDDESCRIPTION.b_info_yearsnumber
  is '年内序号';
comment on column CBONDDESCRIPTION.s_div_recorddate
  is '兑付登记起始日';
comment on column CBONDDESCRIPTION.b_info_codebyplacing
  is '上网发行认购代码';
comment on column CBONDDESCRIPTION.b_info_delistdate
  is '退市日期';
comment on column CBONDDESCRIPTION.b_info_issuetype
  is '发行方式';
comment on column CBONDDESCRIPTION.b_info_guarintroduction
  is '担保简介';
comment on column CBONDDESCRIPTION.b_info_bgndbyplacing
  is '上网发行起始日期';
comment on column CBONDDESCRIPTION.b_info_enddbyplacing
  is '上网发行截止日期';
comment on column CBONDDESCRIPTION.b_info_amountbyplacing
  is '上网发行数量(亿元)';
comment on column CBONDDESCRIPTION.b_info_underwritingcode
  is '承销方式代码';
comment on column CBONDDESCRIPTION.b_info_issuercode
  is '发行人编号';
comment on column CBONDDESCRIPTION.b_info_formercode
  is '原债券代码';
comment on column CBONDDESCRIPTION.b_info_coupontxt
  is '利率说明';
comment on column CBONDDESCRIPTION.is_failure
  is '是否发行失败';
comment on column CBONDDESCRIPTION.is_crossmarket
  is '是否跨市场';
comment on column CBONDDESCRIPTION.b_info_coupondatetxt
  is '付息日说明';
comment on column CBONDDESCRIPTION.b_info_subordinateornot
  is '是否次级债或混合资本债';
comment on column CBONDDESCRIPTION.b_tendrst_referyield
  is '参考收益率';
comment on column CBONDDESCRIPTION.b_info_curpar
  is '最新面值';
comment on column CBONDDESCRIPTION.s_info_formerwindcode
  is '原Wind代码';
comment on column CBONDDESCRIPTION.is_corporate_bond
  is '是否公司债';
comment on column CBONDDESCRIPTION.b_info_issuertype
  is '发行人类型';
comment on column CBONDDESCRIPTION.b_info_specialbondtype
  is '特殊债券类型';
comment on column CBONDDESCRIPTION.is_payadvanced
  is '是否可提前兑付';
comment on column CBONDDESCRIPTION.is_callable
  is '是否可赎回';
comment on column CBONDDESCRIPTION.is_chooseright
  is '是否有选择权';
comment on column CBONDDESCRIPTION.is_netprice
  is '是否净价';
comment on column CBONDDESCRIPTION.is_act_days
  is '是否按实际天数计息';
comment on column CBONDDESCRIPTION.is_incbonds
  is '是否增发债';
comment on column CBONDDESCRIPTION.issue_object
  is '发行对象';
comment on column CBONDDESCRIPTION.b_info_actualbenchmark
  is '计息基准';
comment on column CBONDDESCRIPTION.register_file_type_code
  is '注册文件类型代码';
comment on column CBONDDESCRIPTION.register_file_number
  is '注册文件号';
comment on column CBONDDESCRIPTION.list_ann_date
  is '上市公告日';
comment on column CBONDDESCRIPTION.reimbursement
  is '偿还方式';
comment on column CBONDDESCRIPTION.bond_rating
  is '发行时债券评级';
comment on column CBONDDESCRIPTION.ann_date
  is '公告日期';
comment on column CBONDDESCRIPTION.b_issue_amount_max
  is '发行金额上限';
create index IDX_1CF80028 on CBONDDESCRIPTION (CRNCY_CODE, B_INFO_MATURITYDATE);
create index IDX_1CF80029 on CBONDDESCRIPTION (B_ISSUE_FIRSTISSUE);
create index IDX_BND_FORMERWINDCODE on CBONDDESCRIPTION (S_INFO_FORMERWINDCODE);
create index IDX_CBONDDESCRIPTION1 on CBONDDESCRIPTION (B_INFO_ISSUERCODE);
create index IDX_CBONDDESCRIPTION2 on CBONDDESCRIPTION (B_INFO_FORMERCODE);
create index IDX_CBONDDESCRIPTION3 on CBONDDESCRIPTION (B_INFO_MATURITYDATE);
create index IDX_CBONDDESCRIPTION5 on CBONDDESCRIPTION (B_INFO_CARRYDATE);
create index IDX_CBONDDESCRIPTION6 on CBONDDESCRIPTION (S_INFO_EXCHMARKET);
create index IDX_CBONDDESCRIPTION7 on CBONDDESCRIPTION (CRNCY_CODE);
create index IDX_CBONDDESCRIPTION8 on CBONDDESCRIPTION (B_INFO_PAYMENTDATE);
create index IDX_CBONDDESC_1 on CBONDDESCRIPTION (S_INFO_WINDCODE);
create index IDX_CBONDDESC_2 on CBONDDESCRIPTION (B_INFO_FULLNAME);
alter table CBONDDESCRIPTION
  add primary key (OBJECT_ID);


create table CBONDINDUSTRYWIND
(
  object_id            VARCHAR2(100) not null,
  s_info_windcode      VARCHAR2(40),
  s_info_industrycode  VARCHAR2(20),
  s_info_industryname  VARCHAR2(100),
  s_info_industrycode2 VARCHAR2(20),
  s_info_industryname2 VARCHAR2(100),
  opdate               DATE,
  opmode               VARCHAR2(1)
)
;
create index IDX_BONDINDWIND_1 on CBONDINDUSTRYWIND (S_INFO_WINDCODE);
create index IDX_CBONDINDUSTRYWIND2 on CBONDINDUSTRYWIND (S_INFO_INDUSTRYNAME);
alter table CBONDINDUSTRYWIND
  add primary key (OBJECT_ID);


create table CBONDPLATEWIND
(
  object_id           VARCHAR2(100) not null,
  s_info_windcode     VARCHAR2(40),
  s_info_industrycode VARCHAR2(20),
  s_info_industryname VARCHAR2(100),
  opdate              DATE,
  opmode              VARCHAR2(1)
)
;
create index IDX_CBONDPLATEWIND on CBONDPLATEWIND (S_INFO_WINDCODE, S_INFO_INDUSTRYCODE);
create index IDX_CBONDPLATEWIND1 on CBONDPLATEWIND (S_INFO_WINDCODE);
create index IDX_CBONDPLATEWIND2 on CBONDPLATEWIND (S_INFO_INDUSTRYCODE);
alter table CBONDPLATEWIND
  add primary key (OBJECT_ID);


create table CBONDNEGATIVECREDITEVENT
(
  object_id       VARCHAR2(38) not null,
  s_info_windcode VARCHAR2(40),
  acu_date        VARCHAR2(8),
  event_type      NUMBER(9),
  s_info_compcode VARCHAR2(40),
  subject_type    NUMBER(9),
  event_title     VARCHAR2(200),
  event_memo      VARCHAR2(3000),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column CBONDNEGATIVECREDITEVENT.object_id
  is '对象ID';
comment on column CBONDNEGATIVECREDITEVENT.s_info_windcode
  is 'wind代码';
comment on column CBONDNEGATIVECREDITEVENT.acu_date
  is '[内部]发生日期';
comment on column CBONDNEGATIVECREDITEVENT.event_type
  is '事件类型';
comment on column CBONDNEGATIVECREDITEVENT.s_info_compcode
  is '公司ID';
comment on column CBONDNEGATIVECREDITEVENT.subject_type
  is '主体类型代码';
comment on column CBONDNEGATIVECREDITEVENT.event_title
  is '事件标题 ';
comment on column CBONDNEGATIVECREDITEVENT.event_memo
  is '事件摘要 ';
create index PK_CBONDNEGATIVECREDITEVENT on CBONDNEGATIVECREDITEVENT (S_INFO_WINDCODE, ACU_DATE);
alter table CBONDNEGATIVECREDITEVENT
  add primary key (OBJECT_ID);


create table CBONDRATING
(
  object_id                  VARCHAR2(100) not null,
  s_info_windcode            VARCHAR2(40),
  ann_dt                     VARCHAR2(8),
  b_rate_style               VARCHAR2(100),
  b_info_creditrating        VARCHAR2(40),
  b_info_creditratingagency  VARCHAR2(10),
  b_info_creditratingexplain VARCHAR2(1000),
  b_info_precreditrating     VARCHAR2(40),
  b_creditrating_change      VARCHAR2(10),
  ann_dt2                    VARCHAR2(8),
  opdate                     DATE,
  opmode                     VARCHAR2(1)
)
;
comment on column CBONDRATING.object_id
  is '对象ID';
comment on column CBONDRATING.s_info_windcode
  is 'Wind代码';
comment on column CBONDRATING.ann_dt
  is '评级日期';
comment on column CBONDRATING.b_rate_style
  is '评级类型';
comment on column CBONDRATING.b_info_creditrating
  is '信用评级';
comment on column CBONDRATING.b_info_creditratingagency
  is '评级机构代码';
comment on column CBONDRATING.b_info_creditratingexplain
  is '评级说明';
comment on column CBONDRATING.b_info_precreditrating
  is '前次信用评级';
comment on column CBONDRATING.b_creditrating_change
  is '评级变动方向';
comment on column CBONDRATING.ann_dt2
  is '公告日期';
create index PK_CBONDRATING on CBONDRATING (S_INFO_WINDCODE, ANN_DT);
alter table CBONDRATING
  add primary key (OBJECT_ID);


create table CBONDVALUATION
(
  object_id               VARCHAR2(100) not null,
  s_info_windcode         VARCHAR2(40),
  trade_dt                VARCHAR2(8),
  b_anal_duration         NUMBER(24,8),
  b_anal_modifiedduration NUMBER(24,8),
  b_anal_bduration        NUMBER(24,8),
  b_anal_sduration        NUMBER(24,8),
  b_anal_convexity        NUMBER(24,8),
  b_anal_accrueddays      NUMBER(20,4),
  b_anal_accruedinterest  NUMBER(24,8),
  b_anal_ytc              NUMBER(24,8),
  b_anal_ytp              NUMBER(24,8),
  b_anal_ptmyear          NUMBER(20,4),
  b_anal_ytm              NUMBER(24,8),
  b_info_weightedrt       NUMBER(20,8),

  b_anal_ytm_interest     NUMBER(24,8),
  b_anal_ytm_compound  	  NUMBER(24,8),
  b_anal_ytm_compound_be  NUMBER(24,8),
  b_anal_ytm_open         NUMBER(24,8),
  b_anal_ytm_high         NUMBER(24,8),
  b_anal_ytm_low          NUMBER(24,8),

  opdate                  DATE,
  opmode                  VARCHAR2(1)
)
;
comment on column CBONDVALUATION.object_id
  is '对象ID';
comment on column CBONDVALUATION.s_info_windcode
  is 'Wind代码';
comment on column CBONDVALUATION.trade_dt
  is '交易日期';
comment on column CBONDVALUATION.b_anal_duration
  is '久期';
comment on column CBONDVALUATION.b_anal_modifiedduration
  is '修正久期';
comment on column CBONDVALUATION.b_anal_bduration
  is '基准久期';
comment on column CBONDVALUATION.b_anal_sduration
  is '利差久期';
comment on column CBONDVALUATION.b_anal_convexity
  is '凸性';
comment on column CBONDVALUATION.b_anal_accrueddays
  is '已计息时间';
comment on column CBONDVALUATION.b_anal_accruedinterest
  is '应计利息';
comment on column CBONDVALUATION.b_anal_ytc
  is '赎回收益率(%)';
comment on column CBONDVALUATION.b_anal_ytp
  is '回售收益率(%)';
comment on column CBONDVALUATION.b_anal_ptmyear
  is '剩余期限(年)';
comment on column CBONDVALUATION.b_anal_ytm
  is '到期收益率(%)';
comment on column CBONDVALUATION.b_info_weightedrt
  is '加权剩余期限(年)';

comment on column CBONDVALUATION.b_anal_ytm_interest
  is '收盘价到期收益率(单利)(%)';
comment on column CBONDVALUATION.b_anal_ytm_compound
  is '收盘价到期收益率(复利)(%)';
comment on column CBONDVALUATION.b_anal_ytm_compound_be
  is '收盘价到期收益率(复利BE)(%)';
comment on column CBONDVALUATION.b_anal_ytm_open
  is '开盘价到期收益率(%)';
comment on column CBONDVALUATION.b_anal_ytm_high
  is '最高价到期收益率(%)';
comment on column CBONDVALUATION.b_anal_ytm_low
  is '最低价到期收益率(%)';

create index IDX_CBONDVALUATION1 on CBONDVALUATION (S_INFO_WINDCODE);
create index IDX_CBONDVALUATION2 on CBONDVALUATION (TRADE_DT);
create index IND_CBONDVALUATION on CBONDVALUATION (S_INFO_WINDCODE, TRADE_DT);
alter table CBONDVALUATION
  add primary key (OBJECT_ID);


create table CBONDISSUER
(
  object_id             VARCHAR2(100) not null,
  s_info_windcode       VARCHAR2(40),
  s_info_compname       VARCHAR2(100),
  s_info_compcode       VARCHAR2(10),
  used                  NUMBER(1),
  s_info_compind_code1  VARCHAR2(50),
  s_info_compind_name1  VARCHAR2(100),
  s_info_compind_code2  VARCHAR2(50),
  s_info_compind_name2  VARCHAR2(100),
  s_info_compind_code3  VARCHAR2(50),
  s_info_compind_name3  VARCHAR2(100),
  s_info_compind_code4  VARCHAR2(50),
  s_info_compind_name4  VARCHAR2(100),
  s_info_compregaddress VARCHAR2(80),
  s_info_comptype       VARCHAR2(40),
  s_info_listcompornot  NUMBER(1),
  opdate                DATE,
  opmode                VARCHAR2(1),
  s_info_effective_dt   VARCHAR2(8),
  s_info_invalid_dt     VARCHAR2(8)
)
;
create index IDX_CBONDISSUER1 on CBONDISSUER (S_INFO_WINDCODE);
alter table CBONDISSUER
  add primary key (OBJECT_ID);


create table COMPINTRODUCTION
(
  object_id             VARCHAR2(100) not null,
  comp_id               VARCHAR2(40),
  comp_name             VARCHAR2(150),
  comp_sname            VARCHAR2(40),
  comp_name_eng         VARCHAR2(100),
  comp_snameeng         VARCHAR2(100),
  province              VARCHAR2(20),
  city                  VARCHAR2(50),
  address               VARCHAR2(500),
  office                VARCHAR2(300),
  zipcode               VARCHAR2(10),
  phone                 VARCHAR2(50),
  fax                   VARCHAR2(50),
  email                 VARCHAR2(80),
  website               VARCHAR2(80),
  registernumber        VARCHAR2(20),
  chairman              VARCHAR2(100),
  president             VARCHAR2(100),
  discloser             VARCHAR2(500),
  regcapital            NUMBER(20,4),
  currencycode          VARCHAR2(10),
  founddate             VARCHAR2(8),
  enddate               VARCHAR2(8),
  briefing              VARCHAR2(2000),
  comp_type             VARCHAR2(100),
  comp_property         VARCHAR2(100),
  country               VARCHAR2(20),
  businessscope         VARCHAR2(2500),
  company_type          VARCHAR2(10),
  s_info_totalemployees NUMBER(20),
  main_business         VARCHAR2(1000),
  social_credit_code    VARCHAR2(30),
  s_info_org_code       VARCHAR2(30),
  opdate                DATE,
  opmode                VARCHAR2(1)
)
;
comment on column COMPINTRODUCTION.object_id
  is '对象ID';
comment on column COMPINTRODUCTION.comp_id
  is '公司ID';
comment on column COMPINTRODUCTION.comp_name
  is '公司名称';
comment on column COMPINTRODUCTION.comp_sname
  is '公司中文简称';
comment on column COMPINTRODUCTION.comp_name_eng
  is '英文名称';
comment on column COMPINTRODUCTION.comp_snameeng
  is '英文名称缩写';
comment on column COMPINTRODUCTION.province
  is '省份';
comment on column COMPINTRODUCTION.city
  is '城市';
comment on column COMPINTRODUCTION.address
  is '注册地址';
comment on column COMPINTRODUCTION.office
  is '办公地址';
comment on column COMPINTRODUCTION.zipcode
  is '邮编';
comment on column COMPINTRODUCTION.phone
  is '电话';
comment on column COMPINTRODUCTION.fax
  is '传真';
comment on column COMPINTRODUCTION.email
  is '电子邮件';
comment on column COMPINTRODUCTION.website
  is '公司网址';
comment on column COMPINTRODUCTION.registernumber
  is '工商登记号';
comment on column COMPINTRODUCTION.chairman
  is '法人代表';
comment on column COMPINTRODUCTION.president
  is '总经理';
comment on column COMPINTRODUCTION.discloser
  is '信息披露人';
comment on column COMPINTRODUCTION.regcapital
  is '注册资本';
comment on column COMPINTRODUCTION.currencycode
  is '货币代码';
comment on column COMPINTRODUCTION.founddate
  is '成立日期';
comment on column COMPINTRODUCTION.enddate
  is '公司终止日期';
comment on column COMPINTRODUCTION.briefing
  is '公司简介';
comment on column COMPINTRODUCTION.comp_type
  is '公司类型';
comment on column COMPINTRODUCTION.comp_property
  is '企业性质';
comment on column COMPINTRODUCTION.country
  is '国籍';
comment on column COMPINTRODUCTION.businessscope
  is '经营范围';
comment on column COMPINTRODUCTION.company_type
  is '公司类别';
comment on column COMPINTRODUCTION.s_info_totalemployees
  is '员工总数(人)';
comment on column COMPINTRODUCTION.main_business
  is '主要产品及业务';
comment on column COMPINTRODUCTION.social_credit_code
  is '统一社会信用编码';
comment on column COMPINTRODUCTION.s_info_org_code
  is '组织机构代码';
create index IDX_COMPINTRODUCTION2 on COMPINTRODUCTION (COMP_NAME);
create index IDX_COMPINTRODUCTION3 on COMPINTRODUCTION (COMP_SNAME);
create index PK_COMPINTRODUCTION on COMPINTRODUCTION (COMP_ID);
alter table COMPINTRODUCTION
  add primary key (OBJECT_ID);


create table HKSHAREEODPRICES
(
  object_id        VARCHAR2(100) not null,
  s_info_windcode  VARCHAR2(40),
  trade_dt         VARCHAR2(8),
  crncy_code       VARCHAR2(10),
  s_dq_open        NUMBER(20,4),
  s_dq_high        NUMBER(20,4),
  s_dq_low         NUMBER(20,4),
  s_dq_close       NUMBER(20,4),
  s_dq_volume      NUMBER(20,4),
  s_dq_amount      NUMBER(20,4),
  s_dq_preclose    NUMBER(20,4),
  s_dq_adjpreclose NUMBER(20,4),
  s_dq_adjopen     NUMBER(20,4),
  s_dq_adjhigh     NUMBER(20,4),
  s_dq_adjlow      NUMBER(20,4),
  s_dq_adjclose    NUMBER(20,4),
  s_dq_adjfactor   NUMBER(20,8),
  s_dq_avgprice    NUMBER(20,4),
  opdate           DATE,
  opmode           VARCHAR2(1)
)
;
comment on column HKSHAREEODPRICES.object_id
  is '对象ID';
comment on column HKSHAREEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column HKSHAREEODPRICES.trade_dt
  is '交易日期';
comment on column HKSHAREEODPRICES.crncy_code
  is '货币代码';
comment on column HKSHAREEODPRICES.s_dq_open
  is '开盘价(元)';
comment on column HKSHAREEODPRICES.s_dq_high
  is '最高价(元)';
comment on column HKSHAREEODPRICES.s_dq_low
  is '最低价(元)';
comment on column HKSHAREEODPRICES.s_dq_close
  is '收盘价(元)';
comment on column HKSHAREEODPRICES.s_dq_volume
  is '成交量(股)';
comment on column HKSHAREEODPRICES.s_dq_amount
  is '成交金额(千元)';
comment on column HKSHAREEODPRICES.s_dq_preclose
  is '前收盘价(元)';
comment on column HKSHAREEODPRICES.s_dq_adjpreclose
  is '复权昨收盘价(元)';
comment on column HKSHAREEODPRICES.s_dq_adjopen
  is '复权开盘价(元)';
comment on column HKSHAREEODPRICES.s_dq_adjhigh
  is '复权最高价(元)';
comment on column HKSHAREEODPRICES.s_dq_adjlow
  is '复权最低价(元)';
comment on column HKSHAREEODPRICES.s_dq_adjclose
  is '复权收盘价(元)';
comment on column HKSHAREEODPRICES.s_dq_adjfactor
  is '复权因子';
comment on column HKSHAREEODPRICES.s_dq_avgprice
  is '均价(VWAP)';
create index IDX_HKSHAREEODPRICES on HKSHAREEODPRICES (OPDATE);
create index IDX_HKSTOCKEOD_1 on HKSHAREEODPRICES (S_INFO_WINDCODE);
create index IDX_HKSTOCKEOD_2 on HKSHAREEODPRICES (S_INFO_WINDCODE, TRADE_DT);
create index IDX_HKSTOCKEOD_3 on HKSHAREEODPRICES (TRADE_DT);
alter table HKSHAREEODPRICES
  add primary key (OBJECT_ID);


create table ASHARETRADINGSUSPENSION
(
  object_id         VARCHAR2(100) not null,
  s_info_windcode   VARCHAR2(40),
  s_dq_suspenddate  VARCHAR2(8),
  s_dq_suspendtype  NUMBER(9),
  s_dq_resumpdate   VARCHAR2(8),
  s_dq_changereason VARCHAR2(400),
  s_dq_time         VARCHAR2(200),
  opdate            DATE,
  opmode            VARCHAR2(1)
)
;
comment on column ASHARETRADINGSUSPENSION.object_id
  is '对象ID';
comment on column ASHARETRADINGSUSPENSION.s_info_windcode
  is 'Wind代码';
comment on column ASHARETRADINGSUSPENSION.s_dq_suspenddate
  is '停牌日期';
comment on column ASHARETRADINGSUSPENSION.s_dq_suspendtype
  is '停牌类型代码';
comment on column ASHARETRADINGSUSPENSION.s_dq_resumpdate
  is '复牌日期';
comment on column ASHARETRADINGSUSPENSION.s_dq_changereason
  is '停牌原因';
comment on column ASHARETRADINGSUSPENSION.s_dq_time
  is '停复牌时间';
create index IDX_ASHARETRADINGSUSPENSION1 on ASHARETRADINGSUSPENSION (S_INFO_WINDCODE);
create index IDX_ASHARETRADINGSUSPENSION2 on ASHARETRADINGSUSPENSION (S_DQ_SUSPENDDATE);
alter table ASHARETRADINGSUSPENSION
  add primary key (OBJECT_ID);


create table CFUTURESCONTRACTMAPPING
(
  object_id           VARCHAR2(100) not null,
  s_info_windcode     VARCHAR2(40),
  fs_mapping_windcode VARCHAR2(20),
  startdate           VARCHAR2(8),
  enddate             VARCHAR2(8),
  contract_id         VARCHAR2(10),
  opdate              DATE,
  opmode              VARCHAR2(1)
)
;
comment on column CFUTURESCONTRACTMAPPING.object_id
  is '对象ID';
comment on column CFUTURESCONTRACTMAPPING.s_info_windcode
  is '连续(主力)合约Wind代码';
comment on column CFUTURESCONTRACTMAPPING.fs_mapping_windcode
  is '映射月合约Wind代码';
comment on column CFUTURESCONTRACTMAPPING.startdate
  is '起始日期';
comment on column CFUTURESCONTRACTMAPPING.enddate
  is '截止日期';
comment on column CFUTURESCONTRACTMAPPING.contract_id
  is '合约ID';
alter table CFUTURESCONTRACTMAPPING
  add primary key (OBJECT_ID);


create table CINDEXFUTURESEODPRICES
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  s_dq_presettle  NUMBER(20,4),
  s_dq_open       NUMBER(20,4),
  s_dq_high       NUMBER(20,4),
  s_dq_low        NUMBER(20,4),
  s_dq_close      NUMBER(20,4),
  s_dq_settle     NUMBER(20,4),
  s_dq_volume     NUMBER(20,4),
  s_dq_amount     NUMBER(20,4),
  s_dq_oi         NUMBER(20,4),
  s_dq_change     NUMBER(20,4),
  opdate          DATE,
  opmode          VARCHAR2(1),
  fs_info_type    VARCHAR2(10)
)
;
comment on column CINDEXFUTURESEODPRICES.object_id
  is '对象ID';
comment on column CINDEXFUTURESEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column CINDEXFUTURESEODPRICES.trade_dt
  is '交易日期';
comment on column CINDEXFUTURESEODPRICES.s_dq_presettle
  is '前结算价(元)';
comment on column CINDEXFUTURESEODPRICES.s_dq_open
  is '开盘价(元)';
comment on column CINDEXFUTURESEODPRICES.s_dq_high
  is '最高价(元)';
comment on column CINDEXFUTURESEODPRICES.s_dq_low
  is '最低价(元)';
comment on column CINDEXFUTURESEODPRICES.s_dq_close
  is '收盘价(元)';
comment on column CINDEXFUTURESEODPRICES.s_dq_settle
  is '结算价(元)';
comment on column CINDEXFUTURESEODPRICES.s_dq_volume
  is '成交量(手)';
comment on column CINDEXFUTURESEODPRICES.s_dq_amount
  is '成交金额(万元)';
comment on column CINDEXFUTURESEODPRICES.s_dq_oi
  is '持仓量(手)';
comment on column CINDEXFUTURESEODPRICES.s_dq_change
  is '涨跌(元)';
comment on column CINDEXFUTURESEODPRICES.fs_info_type
  is '合约类型';
create index PK_CINDEXFUTURESEODPRICES on CINDEXFUTURESEODPRICES (S_INFO_WINDCODE, TRADE_DT);
alter table CINDEXFUTURESEODPRICES
  add primary key (OBJECT_ID);


create table CBONDFUTURESEODPRICES
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  s_dq_presettle  NUMBER(20,4),
  s_dq_open       NUMBER(20,4),
  s_dq_high       NUMBER(20,4),
  s_dq_low        NUMBER(20,4),
  s_dq_close      NUMBER(20,4),
  s_dq_settle     NUMBER(20,4),
  s_dq_volume     NUMBER(20,4),
  s_dq_amount     NUMBER(20,4),
  s_dq_oi         NUMBER(20,4),
  s_dq_change     NUMBER(20,4),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column CBONDFUTURESEODPRICES.object_id
  is '对象ID';
comment on column CBONDFUTURESEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column CBONDFUTURESEODPRICES.trade_dt
  is '交易日期';
comment on column CBONDFUTURESEODPRICES.s_dq_presettle
  is '前结算价(元)';
comment on column CBONDFUTURESEODPRICES.s_dq_open
  is '开盘价(元)';
comment on column CBONDFUTURESEODPRICES.s_dq_high
  is '最高价(元)';
comment on column CBONDFUTURESEODPRICES.s_dq_low
  is '最低价(元)';
comment on column CBONDFUTURESEODPRICES.s_dq_close
  is '收盘价(元)';
comment on column CBONDFUTURESEODPRICES.s_dq_settle
  is '结算价(元)';
comment on column CBONDFUTURESEODPRICES.s_dq_volume
  is '成交量(手)';
comment on column CBONDFUTURESEODPRICES.s_dq_amount
  is '成交金额(万元)';
comment on column CBONDFUTURESEODPRICES.s_dq_oi
  is '持仓量(手)';
comment on column CBONDFUTURESEODPRICES.s_dq_change
  is '涨跌(元)';
create index PK_CBONDFUTURESEODPRICES on CBONDFUTURESEODPRICES (S_INFO_WINDCODE, TRADE_DT);
alter table CBONDFUTURESEODPRICES
  add primary key (OBJECT_ID);


create table CCOMMODITYFUTURESEODPRICES
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  s_dq_presettle  NUMBER(20,4),
  s_dq_open       NUMBER(20,4),
  s_dq_high       NUMBER(20,4),
  s_dq_low        NUMBER(20,4),
  s_dq_close      NUMBER(20,4),
  s_dq_settle     NUMBER(20,4),
  s_dq_volume     NUMBER(20,4),
  s_dq_amount     NUMBER(20,4),
  s_dq_oi         NUMBER(20,4),
  s_dq_change     NUMBER(20,4),
  s_dq_oichange   NUMBER(20,4),
  opdate          DATE,
  opmode          VARCHAR2(1),
  fs_info_type    VARCHAR2(10)
)
;
comment on column CCOMMODITYFUTURESEODPRICES.object_id
  is '对象ID';
comment on column CCOMMODITYFUTURESEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column CCOMMODITYFUTURESEODPRICES.trade_dt
  is '交易日期';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_presettle
  is '前结算价(元)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_open
  is '开盘价(元)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_high
  is '最高价(元)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_low
  is '最低价(元)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_close
  is '收盘价(元)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_settle
  is '结算价(元)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_volume
  is '成交量(手)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_amount
  is '成交金额(万元)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_oi
  is '持仓量(手)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_change
  is '涨跌(元)';
comment on column CCOMMODITYFUTURESEODPRICES.s_dq_oichange
  is '持仓量变化';
comment on column CCOMMODITYFUTURESEODPRICES.fs_info_type
  is '合约类型';
create index IDX_FUTURESEODPRICES1 on CCOMMODITYFUTURESEODPRICES (S_INFO_WINDCODE);
create index IDX_FUTURESEODPRICES2 on CCOMMODITYFUTURESEODPRICES (TRADE_DT);
alter table CCOMMODITYFUTURESEODPRICES
  add primary key (OBJECT_ID);


create table CBONDPRICES
(
  object_id        VARCHAR2(100) not null,
  s_info_windcode  VARCHAR2(40),
  trade_dt         VARCHAR2(8),
  b_dq_open        NUMBER(20,8),
  b_dq_high        NUMBER(20,8),
  b_dq_low         NUMBER(20,8),
  b_dq_originclose NUMBER(20,8),
  b_dq_volume      NUMBER(20,8),
  b_dq_amount      NUMBER(20,8),
  opdate           DATE,
  opmode           VARCHAR2(1)
)
;
comment on column CBONDPRICES.object_id
  is '对象ID';
comment on column CBONDPRICES.s_info_windcode
  is 'Wind代码';
comment on column CBONDPRICES.trade_dt
  is '交易日期';
comment on column CBONDPRICES.b_dq_open
  is '开盘价(元)';
comment on column CBONDPRICES.b_dq_high
  is '最高价(元)';
comment on column CBONDPRICES.b_dq_low
  is '最低价(元)';
comment on column CBONDPRICES.b_dq_originclose
  is '收盘价(元)';
comment on column CBONDPRICES.b_dq_volume
  is '成交量(手)';
comment on column CBONDPRICES.b_dq_amount
  is '成交金额(千元)';
create index IDX_CBONDPRICE_1 on CBONDPRICES (S_INFO_WINDCODE);
create index IDX_CBONDPRICE_2 on CBONDPRICES (S_INFO_WINDCODE, TRADE_DT);
create index IDX_CBONDPRICE_3 on CBONDPRICES (TRADE_DT);
alter table CBONDPRICES
  add primary key (OBJECT_ID);


create table HKSTOCKHSINDEXWEIGHT
(
  object_id             VARCHAR2(100) not null,
  ixdex_windcode        VARCHAR2(40),
  compon_stock_windcode VARCHAR2(40),
  trade_dt              VARCHAR2(8),
  s_weight              NUMBER(20,4),
  opdate                DATE,
  opmode                VARCHAR2(1)
)
;
comment on column HKSTOCKHSINDEXWEIGHT.object_id
  is '对象ID';
comment on column HKSTOCKHSINDEXWEIGHT.ixdex_windcode
  is '指数Wind代码';
comment on column HKSTOCKHSINDEXWEIGHT.compon_stock_windcode
  is '成分股Wind代码';
comment on column HKSTOCKHSINDEXWEIGHT.trade_dt
  is '交易日期';
comment on column HKSTOCKHSINDEXWEIGHT.s_weight
  is '权重';
alter table HKSTOCKHSINDEXWEIGHT
  add primary key (OBJECT_ID);


create table HKINDEXDESCRIPTION
(
  object_id            VARCHAR2(38) not null,
  s_info_windcode      VARCHAR2(40),
  s_info_code          VARCHAR2(40),
  s_info_name          VARCHAR2(50),
  s_info_compname      VARCHAR2(100),
  s_info_exchmarket    VARCHAR2(40),
  s_info_index_baseper VARCHAR2(8),
  s_info_index_basept  NUMBER(20,4),
  s_info_listdate      VARCHAR2(8),
  opdate               DATE,
  opmode               VARCHAR2(1)
)
;
alter table HKINDEXDESCRIPTION
  add primary key (OBJECT_ID);


create table HKINDEXEODPRICES
(
  object_id       VARCHAR2(38) not null,
  s_info_windcode VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  crncy_code      VARCHAR2(10),
  s_dq_preclose   NUMBER(20,4),
  s_dq_open       NUMBER(20,4),
  s_dq_high       NUMBER(20,4),
  s_dq_low        NUMBER(20,4),
  s_dq_close      NUMBER(20,4),
  s_dq_change     NUMBER(20,4),
  s_dq_pctchange  NUMBER(20,4),
  s_dq_volume     NUMBER(20,4),
  s_dq_amount     NUMBER(20,4),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column HKINDEXEODPRICES.object_id
  is '对象ID';
comment on column HKINDEXEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column HKINDEXEODPRICES.trade_dt
  is '交易日期';
comment on column HKINDEXEODPRICES.crncy_code
  is '货币代码';
comment on column HKINDEXEODPRICES.s_dq_preclose
  is '昨收盘价(点)';
comment on column HKINDEXEODPRICES.s_dq_open
  is '开盘价(点)';
comment on column HKINDEXEODPRICES.s_dq_high
  is '最高价(点)';
comment on column HKINDEXEODPRICES.s_dq_low
  is '最低价(点)';
comment on column HKINDEXEODPRICES.s_dq_close
  is '收盘价(点)';
comment on column HKINDEXEODPRICES.s_dq_change
  is '涨跌(点)';
comment on column HKINDEXEODPRICES.s_dq_pctchange
  is '涨跌幅(%)';
comment on column HKINDEXEODPRICES.s_dq_volume
  is '成交量(手)';
comment on column HKINDEXEODPRICES.s_dq_amount
  is '成交金额(千元)';
create index PK_HKINDEXEODPRICES on HKINDEXEODPRICES (S_INFO_WINDCODE, TRADE_DT);
alter table HKINDEXEODPRICES
  add primary key (OBJECT_ID);


create table CBONDISSUERRATING
(
  object_id                  VARCHAR2(100) not null,
  s_info_compname            VARCHAR2(100),
  ann_dt                     VARCHAR2(8),
  b_rate_style               VARCHAR2(100),
  b_info_creditrating        VARCHAR2(40),
  b_rate_ratingoutlook       NUMBER(9),
  b_info_creditratingagency  VARCHAR2(10),
  s_info_compcode            VARCHAR2(10),
  b_info_creditratingexplain VARCHAR2(1000),
  b_info_precreditrating     VARCHAR2(40),
  b_creditrating_change      VARCHAR2(10),
  b_info_issuerratetype      NUMBER(9),
  ann_dt2                    VARCHAR2(8),
  opdate                     DATE,
  opmode                     VARCHAR2(1)
)
;
comment on column CBONDISSUERRATING.object_id
  is '对象ID';
comment on column CBONDISSUERRATING.s_info_compname
  is '公司中文名称';
comment on column CBONDISSUERRATING.ann_dt
  is '评级日期';
comment on column CBONDISSUERRATING.b_rate_style
  is '评级类型';
comment on column CBONDISSUERRATING.b_info_creditrating
  is '信用评级';
comment on column CBONDISSUERRATING.b_rate_ratingoutlook
  is '评级展望';
comment on column CBONDISSUERRATING.b_info_creditratingagency
  is '评级机构代码';
comment on column CBONDISSUERRATING.s_info_compcode
  is '债券主体公司id';
comment on column CBONDISSUERRATING.b_info_creditratingexplain
  is '信用评级说明';
comment on column CBONDISSUERRATING.b_info_precreditrating
  is '前次信用评级';
comment on column CBONDISSUERRATING.b_creditrating_change
  is '评级变动方向';
comment on column CBONDISSUERRATING.b_info_issuerratetype
  is '评级对象类型代码';
comment on column CBONDISSUERRATING.ann_dt2
  is '公告日期';
create index PK_CBONDISSUERRATING on CBONDISSUERRATING (S_INFO_COMPCODE, ANN_DT);
alter table CBONDISSUERRATING
  add primary key (OBJECT_ID);


create table CBONDSPECIALCONDITIONS
(
  object_id                   VARCHAR2(100) not null,
  s_info_windcode             VARCHAR2(40),
  b_info_provisiontype        VARCHAR2(100),
  b_info_callbkorputbkprice   NUMBER(20,4),
  b_info_callbkorputbkdate    VARCHAR2(8),
  b_info_redemporrepurcdate   VARCHAR2(8),
  b_info_maturityembedded     VARCHAR2(40),
  b_info_execmaturityembedded NUMBER(20,4),
  opdate                      DATE,
  opmode                      VARCHAR2(1),
  b_info_couponadj_max        NUMBER(20,4),
  b_info_couponadj_min        NUMBER(20,4),
  b_info_content              VARCHAR2(3000)
)
;
create index IDX_1CF80001 on CBONDSPECIALCONDITIONS (S_INFO_WINDCODE, B_INFO_CALLBKORPUTBKDATE);
create index IDX_1CF80002 on CBONDSPECIALCONDITIONS (S_INFO_WINDCODE, B_INFO_PROVISIONTYPE);
create index IDX_CBONDSPECIALCONDITIONS2 on CBONDSPECIALCONDITIONS (B_INFO_PROVISIONTYPE);
create index IDX_CBONDSPECIALCONDITIONS3 on CBONDSPECIALCONDITIONS (B_INFO_CALLBKORPUTBKDATE);
create index IDX_CBONDSPECIALCONDITIONS_1 on CBONDSPECIALCONDITIONS (S_INFO_WINDCODE);
alter table CBONDSPECIALCONDITIONS
  add primary key (OBJECT_ID);

create table CBONDCF
(
  object_id              VARCHAR2(100) not null,
  s_info_windcode        VARCHAR2(40),
  b_info_carrydate       VARCHAR2(8),
  b_info_enddate         VARCHAR2(8),
  b_info_couponrate      NUMBER(22,6),
  b_info_paymentdate     VARCHAR2(8),
  b_info_paymentinterest NUMBER(22,6),
  b_info_paymentparvalue NUMBER(22,6),
  b_info_paymentsum      NUMBER(22,6),
  opdate                 DATE,
  opmode                 VARCHAR2(1)
)
;
comment on column CBONDCF.object_id
  is '对象ID';
comment on column CBONDCF.s_info_windcode
  is 'Wind代码';
comment on column CBONDCF.b_info_carrydate
  is '计息起始日';
comment on column CBONDCF.b_info_enddate
  is '计息截止日';
comment on column CBONDCF.b_info_couponrate
  is '票面利率(%)';
comment on column CBONDCF.b_info_paymentdate
  is '现金流发放日';
comment on column CBONDCF.b_info_paymentinterest
  is '期末每百元面额应付利息';
comment on column CBONDCF.b_info_paymentparvalue
  is '期末每百元面额应付本金';
comment on column CBONDCF.b_info_paymentsum
  is '期末每百元面额现金流合计';
create index IDX_CBONDCF1 on CBONDCF (S_INFO_WINDCODE);
create index PK_CBONDCF on CBONDCF (S_INFO_WINDCODE, B_INFO_PAYMENTDATE);
alter table CBONDCF
  add primary key (OBJECT_ID);

create table CBINDEXDESCRIPTION
(
  object_id                VARCHAR2(100) not null,
  s_info_windcode          VARCHAR2(40),
  s_info_code              VARCHAR2(40),
  s_info_name              VARCHAR2(50),
  s_info_compname          VARCHAR2(100),
  s_info_exchmarket        VARCHAR2(40),
  s_info_index_baseper     VARCHAR2(8),
  s_info_index_basept      NUMBER(20,4),
  s_info_listdate          VARCHAR2(8),
  s_info_index_weightsrule VARCHAR2(10),
  income_processing_method VARCHAR2(20),
  opdate                   DATE,
  opmode                   VARCHAR2(1)
)
;
comment on column CBINDEXDESCRIPTION.object_id
  is '对象ID';
comment on column CBINDEXDESCRIPTION.s_info_windcode
  is 'Wind代码';
comment on column CBINDEXDESCRIPTION.s_info_code
  is '交易代码';
comment on column CBINDEXDESCRIPTION.s_info_name
  is '证券简称';
comment on column CBINDEXDESCRIPTION.s_info_compname
  is '指数名称';
comment on column CBINDEXDESCRIPTION.s_info_exchmarket
  is '交易所';
comment on column CBINDEXDESCRIPTION.s_info_index_baseper
  is '基期';
comment on column CBINDEXDESCRIPTION.s_info_index_basept
  is '基点';
comment on column CBINDEXDESCRIPTION.s_info_listdate
  is '发布日期';
comment on column CBINDEXDESCRIPTION.s_info_index_weightsrule
  is '加权方式';
comment on column CBINDEXDESCRIPTION.income_processing_method
  is '收益处理方式';
create index IDX_CBINDEXDESCRIPTION1 on CBINDEXDESCRIPTION (S_INFO_WINDCODE);
alter table CBINDEXDESCRIPTION
  add primary key (OBJECT_ID);


create table CBINDEXEODPRICES
(
  object_id       VARCHAR2(100) not null,
  s_info_windcode VARCHAR2(40),
  trade_dt        VARCHAR2(8),
  crncy_code      VARCHAR2(10),
  s_dq_preclose   NUMBER(20,4),
  s_dq_open       NUMBER(20,4),
  s_dq_high       NUMBER(20,4),
  s_dq_low        NUMBER(20,4),
  s_dq_close      NUMBER(20,4),
  s_dq_change     NUMBER(20,4),
  s_dq_pctchange  NUMBER(20,4),
  s_dq_volume     NUMBER(20,4),
  s_dq_amount     NUMBER(20,4),
  sec_id          VARCHAR2(10),
  opdate          DATE,
  opmode          VARCHAR2(1)
)
;
comment on column CBINDEXEODPRICES.object_id
  is '对象ID';
comment on column CBINDEXEODPRICES.s_info_windcode
  is 'Wind代码';
comment on column CBINDEXEODPRICES.trade_dt
  is '交易日期';
comment on column CBINDEXEODPRICES.crncy_code
  is '货币代码';
comment on column CBINDEXEODPRICES.s_dq_preclose
  is '昨收盘价(点)';
comment on column CBINDEXEODPRICES.s_dq_open
  is '开盘价(点)';
comment on column CBINDEXEODPRICES.s_dq_high
  is '最高价(点)';
comment on column CBINDEXEODPRICES.s_dq_low
  is '最低价(点)';
comment on column CBINDEXEODPRICES.s_dq_close
  is '收盘价(点)';
comment on column CBINDEXEODPRICES.s_dq_change
  is '涨跌(点)';
comment on column CBINDEXEODPRICES.s_dq_pctchange
  is '涨跌幅(%)';
comment on column CBINDEXEODPRICES.s_dq_volume
  is '成交量(手)';
comment on column CBINDEXEODPRICES.s_dq_amount
  is '成交金额(千元)';
comment on column CBINDEXEODPRICES.sec_id
  is '证券ID';
create index IDX_CBINDEXEODPRICES1 on CBINDEXEODPRICES (S_INFO_WINDCODE);
create index IDX_CBINDEXEODPRICES2 on CBINDEXEODPRICES (TRADE_DT);
alter table CBINDEXEODPRICES
  add primary key (OBJECT_ID);


create table COPTIONEMBEDDEDBONDVALUATION
(
  object_id                 VARCHAR2(100) not null,
  s_info_windcode           VARCHAR2(40),
  trade_dt                  VARCHAR2(8),
  price_type_code           NUMBER(9),
  price_type                VARCHAR2(20),
  b_anal_nxoptiondate       VARCHAR2(8),
  b_anal_termifexercise     NUMBER(22,4),
  b_anal_ytm_ifexe          NUMBER(24,8),
  b_anal_durationifexercise NUMBER(24,8),
  b_anal_modiduration_ifexe NUMBER(24,8),
  b_anal_convexity_ifexe    NUMBER(24,8),
  b_anal_basevalue_ifexe    NUMBER(24,8),
  b_anal_bduration_ifexe    NUMBER(24,8),
  b_anal_bconvexity_ifexe   NUMBER(24,8),
  b_anal_sduration_ifexe    NUMBER(24,8),
  b_anal_sconvexity_ifexe   NUMBER(24,8),
  opdate                    DATE,
  opmode                    VARCHAR2(1)
)
;
comment on column COPTIONEMBEDDEDBONDVALUATION.object_id
  is '对象ID';
comment on column COPTIONEMBEDDEDBONDVALUATION.s_info_windcode
  is 'Wind代码';
comment on column COPTIONEMBEDDEDBONDVALUATION.trade_dt
  is '日期';
comment on column COPTIONEMBEDDEDBONDVALUATION.price_type_code
  is '价格类型代码';
comment on column COPTIONEMBEDDEDBONDVALUATION.price_type
  is '价格类型';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_nxoptiondate
  is '最近行权日';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_termifexercise
  is '行权剩余期限';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_ytm_ifexe
  is '行权收益率';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_durationifexercise
  is '行权久期';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_modiduration_ifexe
  is '行权修正久期';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_convexity_ifexe
  is '行权凸性';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_basevalue_ifexe
  is '行权基点价值';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_bduration_ifexe
  is '行权基准久期';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_bconvexity_ifexe
  is '行权基准凸性';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_sduration_ifexe
  is '行权利差久期';
comment on column COPTIONEMBEDDEDBONDVALUATION.b_anal_sconvexity_ifexe
  is '行权利差凸性';
create index PK_COPTIONEMBEDDEDBONDV on COPTIONEMBEDDEDBONDVALUATION (S_INFO_WINDCODE, TRADE_DT, PRICE_TYPE);
alter table COPTIONEMBEDDEDBONDVALUATION
  add primary key (OBJECT_ID);

create table CHINAMUTUALFUNDNAV
(
  object_id                 VARCHAR2(100) not null,
  f_info_windcode           VARCHAR2(40),
  ann_date                  VARCHAR2(8),
  price_date                VARCHAR2(8),
  f_nav_unit                NUMBER(20,4),
  f_nav_accumulated         NUMBER(20,4),
  f_nav_divaccumulated      NUMBER(20,4),
  f_nav_adjfactor           NUMBER(20,6),
  crncy_code                VARCHAR2(10),
  f_prt_netasset            NUMBER(20,4),
  f_asset_mergedsharesornot NUMBER(1),
  netasset_total            NUMBER(20,4),
  f_nav_adjusted            NUMBER(18,4),
  opdate                    DATE,
  opmode                    VARCHAR2(1)
)
;
comment on column CHINAMUTUALFUNDNAV.object_id
  is '对象ID';
comment on column CHINAMUTUALFUNDNAV.f_info_windcode
  is 'Wind代码';
comment on column CHINAMUTUALFUNDNAV.ann_date
  is '公告日期';
comment on column CHINAMUTUALFUNDNAV.price_date
  is '截止日期';
comment on column CHINAMUTUALFUNDNAV.f_nav_unit
  is '单位净值';
comment on column CHINAMUTUALFUNDNAV.f_nav_accumulated
  is '累计净值';
comment on column CHINAMUTUALFUNDNAV.f_nav_divaccumulated
  is '累计分红';
comment on column CHINAMUTUALFUNDNAV.f_nav_adjfactor
  is '复权因子';
comment on column CHINAMUTUALFUNDNAV.crncy_code
  is '货币代码';
comment on column CHINAMUTUALFUNDNAV.f_prt_netasset
  is '资产净值';
comment on column CHINAMUTUALFUNDNAV.f_asset_mergedsharesornot
  is '是否合计数据';
comment on column CHINAMUTUALFUNDNAV.netasset_total
  is '合计资产净值';
comment on column CHINAMUTUALFUNDNAV.f_nav_adjusted
  is '复权单位净值';
create index IDX_CHINAMUTUALFUNDNAV1 on CHINAMUTUALFUNDNAV (F_INFO_WINDCODE);
create index IDX_CMFNAV_2 on CHINAMUTUALFUNDNAV (PRICE_DATE);
create index PK_CHINAMUTUALFUNDNAV on CHINAMUTUALFUNDNAV (F_INFO_WINDCODE, PRICE_DATE);
alter table CHINAMUTUALFUNDNAV
  add primary key (OBJECT_ID);


create table CHINAMUTUALFUNDDESCRIPTION
(
  object_id                      VARCHAR2(100) not null,
  f_info_windcode                VARCHAR2(40),
  f_info_front_code              VARCHAR2(40),
  f_info_backend_code            VARCHAR2(40),
  f_info_fullname                VARCHAR2(100),
  f_info_name                    VARCHAR2(100),
  f_info_corp_fundmanagementcomp VARCHAR2(100),
  f_info_custodianbank           VARCHAR2(100),
  f_info_firstinvesttype         VARCHAR2(40),
  f_info_setupdate               VARCHAR2(8),
  f_info_maturitydate            VARCHAR2(8),
  f_issue_totalunit              NUMBER(20,4),
  f_info_managementfeeratio      NUMBER(20,4),
  f_info_custodianfeeratio       NUMBER(20,4),
  crny_code                      VARCHAR2(10),
  f_info_ptmyear                 NUMBER(20,4),
  f_issue_oef_startdateinst      VARCHAR2(8),
  f_issue_oef_dnddateinst        VARCHAR2(8),
  f_info_parvalue                NUMBER(20,4),
  f_info_trusttype               VARCHAR2(40),
  f_info_trustee                 VARCHAR2(100),
  f_pchredm_pchstartdate         VARCHAR2(8),
  f_info_redmstartdate           VARCHAR2(8),
  f_info_minbuyamount            NUMBER(20,4),
  f_info_expectedrateofreturn    NUMBER(20,4),
  f_info_issuingplace            VARCHAR2(100),
  f_info_benchmark               VARCHAR2(500),
  f_info_status                  NUMBER(9),
  f_info_restrictedornot         VARCHAR2(20),
  f_info_structuredornot         NUMBER(1),
  f_info_exchmarket              VARCHAR2(10),
  f_info_firstinveststyle        VARCHAR2(20),
  f_info_issuedate               VARCHAR2(8),
  f_info_type                    VARCHAR2(20),
  f_info_isinitial               NUMBER(5),
  f_info_pinyin                  VARCHAR2(50),
  f_info_investscope             VARCHAR2(2000),
  f_info_investobject            VARCHAR2(500),
  f_info_investconception        VARCHAR2(2000),
  f_info_decision_basis          VARCHAR2(2000),
  is_indexfund                   NUMBER(5),
  f_info_delistdate              VARCHAR2(8),
  f_info_corp_fundmanagementid   VARCHAR2(10),
  f_info_custodianbankid         VARCHAR2(40),
  max_num_holder                 NUMBER(20,4),
  max_num_coltarget              NUMBER(20,4),
  investstrategy                 CLOB,
  risk_return                    CLOB,
  f_pchredm_pchminamt            NUMBER(20,4),
  f_pchredm_pchminamt_ex         NUMBER(20,4),
  f_info_listdate                VARCHAR2(8),
  f_info_anndate                 VARCHAR2(8),
  f_closed_operation_period      NUMBER(20,4),
  f_closed_operation_interval    NUMBER(20,4),
  f_info_registrant              VARCHAR2(10),
  f_personal_startdateind        VARCHAR2(8),
  f_personal_enddateind          VARCHAR2(8),
  f_info_fund_id                 VARCHAR2(100),
  opdate                         DATE,
  opmode                         VARCHAR2(1)
)
;
comment on column CHINAMUTUALFUNDDESCRIPTION.object_id
  is '对象ID';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_windcode
  is 'Wind代码';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_front_code
  is '前端代码';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_backend_code
  is '后端代码';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_fullname
  is '名称';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_name
  is '简称';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_corp_fundmanagementcomp
  is '管理人';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_custodianbank
  is '托管人';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_firstinvesttype
  is '投资类型';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_setupdate
  is '成立日期';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_maturitydate
  is '到期日期';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_issue_totalunit
  is '发行份额';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_managementfeeratio
  is '管理费';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_custodianfeeratio
  is '托管费';
comment on column CHINAMUTUALFUNDDESCRIPTION.crny_code
  is '货币代码';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_ptmyear
  is '存续期';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_issue_oef_startdateinst
  is '机构投资者认购起始日';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_issue_oef_dnddateinst
  is '机构投资者认购终止日';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_parvalue
  is '面值';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_trusttype
  is '信托类别';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_trustee
  is '受托人';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_pchredm_pchstartdate
  is '日常申购起始日';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_redmstartdate
  is '日常赎回起始日';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_minbuyamount
  is '起点金额';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_expectedrateofreturn
  is '预期收益率';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_issuingplace
  is '发行地';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_benchmark
  is '业绩比较基准';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_status
  is '存续状态';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_restrictedornot
  is '限定类型';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_structuredornot
  is '是否结构化产品';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_exchmarket
  is '交易所';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_firstinveststyle
  is '投资风格';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_issuedate
  is '发行日期';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_type
  is '基金类型';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_isinitial
  is '是否为初始基金';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_pinyin
  is '简称拼音';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_investscope
  is '投资范围';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_investobject
  is '投资目标';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_investconception
  is '投资理念';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_decision_basis
  is '决策依据';
comment on column CHINAMUTUALFUNDDESCRIPTION.is_indexfund
  is '是否指数基金';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_delistdate
  is '退市日期';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_corp_fundmanagementid
  is '基金管理人ID';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_custodianbankid
  is '托管人id';
comment on column CHINAMUTUALFUNDDESCRIPTION.max_num_holder
  is '单一投资者持有份额上限(亿份)';
comment on column CHINAMUTUALFUNDDESCRIPTION.max_num_coltarget
  is '封闭期目标募集数量上限(亿份)';
comment on column CHINAMUTUALFUNDDESCRIPTION.investstrategy
  is '投资策略';
comment on column CHINAMUTUALFUNDDESCRIPTION.risk_return
  is '基金风险收益特征';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_pchredm_pchminamt
  is '每次最低申购金额(场外)(万元)';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_pchredm_pchminamt_ex
  is '每次最低申购金额(场内) (万元)';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_listdate
  is '上市时间';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_anndate
  is '公告日期';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_closed_operation_period
  is '封闭运作期';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_closed_operation_interval
  is '封闭运作期满开放日间隔';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_registrant
  is '基金注册与过户登记人ID';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_personal_startdateind
  is '个人投资者认购起始日';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_personal_enddateind
  is '个人投资者认购终止日';
comment on column CHINAMUTUALFUNDDESCRIPTION.f_info_fund_id
  is '基金品种ID';
create index IDX_FUNDDESC_1 on CHINAMUTUALFUNDDESCRIPTION (F_INFO_WINDCODE);
alter table CHINAMUTUALFUNDDESCRIPTION
  add primary key (OBJECT_ID);


create table CHINAOPTIONDESCRIPTION
(
  object_id              VARCHAR2(100) not null,
  s_info_windcode        VARCHAR2(40),
  s_info_code            VARCHAR2(40),
  s_info_name            VARCHAR2(100),
  s_info_sccode          VARCHAR2(50),
  s_info_callput         NUMBER(9),
  s_info_strikeprice     NUMBER(20,4),
  s_info_month           VARCHAR2(6),
  s_info_maturitydate    VARCHAR2(8),
  s_info_ftdate          VARCHAR2(8),
  s_info_lasttradingdate VARCHAR2(8),
  s_info_exercisingend   VARCHAR2(8),
  s_info_lddate          VARCHAR2(8),
  s_info_lprice          NUMBER(20,4),
  s_info_trade           VARCHAR2(1),
  opdate                 DATE,
  opmode                 VARCHAR2(1),
  s_info_excode          VARCHAR2(20),
  s_info_exname          VARCHAR2(100),
  s_info_counit          NUMBER(20,4)
)
;
create index PK_CHINAOPTIONDESCRIPTION on CHINAOPTIONDESCRIPTION (S_INFO_WINDCODE);
create index PK_CHINAOPTIONDESCRIPTION2 on CHINAOPTIONDESCRIPTION (S_INFO_CODE);
alter table CHINAOPTIONDESCRIPTION
  add primary key (OBJECT_ID);

create table CHINAOPTIONVALUATION
(
  object_id                   VARCHAR2(100) not null,
  s_info_windcode             VARCHAR2(40),
  trade_dt                    VARCHAR2(8),
  w_anal_underlyingimpliedvol NUMBER(24,8),
  w_anal_delta                NUMBER(24,8),
  w_anal_theta                NUMBER(24,8),
  w_anal_gamma                NUMBER(24,8),
  w_anal_vega                 NUMBER(24,8),
  w_anal_rho                  NUMBER(24,8),
  surged_limit                NUMBER(24,8),
  decline_limit               NUMBER(24,8),
  opdate                      DATE,
  opmode                      VARCHAR2(1)
)
;
comment on column CHINAOPTIONVALUATION.object_id
  is '对象ID';
comment on column CHINAOPTIONVALUATION.s_info_windcode
  is '月合约Wind代码';
comment on column CHINAOPTIONVALUATION.trade_dt
  is '交易日期';
comment on column CHINAOPTIONVALUATION.w_anal_underlyingimpliedvol
  is '隐含波动率(%)';
comment on column CHINAOPTIONVALUATION.w_anal_delta
  is 'Delta';
comment on column CHINAOPTIONVALUATION.w_anal_theta
  is 'Theta';
comment on column CHINAOPTIONVALUATION.w_anal_gamma
  is 'Gamma';
comment on column CHINAOPTIONVALUATION.w_anal_vega
  is 'Vega';
comment on column CHINAOPTIONVALUATION.w_anal_rho
  is 'Rho';
comment on column CHINAOPTIONVALUATION.surged_limit
  is '涨停价格';
comment on column CHINAOPTIONVALUATION.decline_limit
  is '跌停价格';
create index PK_CHINAOPTIONVALUATION on CHINAOPTIONVALUATION (S_INFO_WINDCODE, TRADE_DT);
alter table CHINAOPTIONVALUATION
  add primary key (OBJECT_ID);

create table CBONDCURVECNBD
(
  object_id          VARCHAR2(100) not null,
  trade_dt           VARCHAR2(8),
  b_anal_curvenumber NUMBER(10),
  b_anal_curvename   VARCHAR2(200),
  b_anal_curvetype   VARCHAR2(80),
  b_anal_curveterm   NUMBER(20,4),
  b_anal_yield       NUMBER(20,4),
  opdate             DATE,
  opmode             VARCHAR2(1),
  b_anal_base_yield  NUMBER(20,4),
  b_anal_yield_total NUMBER(20,4)
)
;
comment on column CBONDCURVECNBD.object_id
  is '对象ID';
comment on column CBONDCURVECNBD.trade_dt
  is '交易日期';
comment on column CBONDCURVECNBD.b_anal_curvenumber
  is '曲线编号';
comment on column CBONDCURVECNBD.b_anal_curvename
  is '曲线名称';
comment on column CBONDCURVECNBD.b_anal_curvetype
  is '曲线类型';
comment on column CBONDCURVECNBD.b_anal_curveterm
  is '标准期限(年)';
comment on column CBONDCURVECNBD.b_anal_yield
  is '收益率(%)';
comment on column CBONDCURVECNBD.b_anal_base_yield
  is '估值日基础利率';
comment on column CBONDCURVECNBD.b_anal_yield_total
  is '收益率曲线数值';
create index CURVEYIELD on CBONDCURVECNBD (B_ANAL_CURVENAME, B_ANAL_CURVETERM);
create index IDX2_CBONDCURVECNBD on CBONDCURVECNBD (B_ANAL_CURVENUMBER);
create index IDX2_CBONDCURVECNBD_CN_TD on CBONDCURVECNBD (B_ANAL_CURVENUMBER, TRADE_DT);
create index IDX4_CBONDCURVECNBD on CBONDCURVECNBD (B_ANAL_CURVENAME, B_ANAL_CURVETERM, B_ANAL_CURVETYPE);
create index IDX_CURVENAME on CBONDCURVECNBD (B_ANAL_CURVENAME);
create index IDX_CURVETERM on CBONDCURVECNBD (B_ANAL_CURVETERM);
create index IDX_FULL on CBONDCURVECNBD (TRADE_DT, B_ANAL_CURVENUMBER, B_ANAL_CURVETYPE, B_ANAL_CURVETERM);
create index IDX_TRADEDT on CBONDCURVECNBD (TRADE_DT);
alter table CBONDCURVECNBD
  add primary key (OBJECT_ID);

create table CBONDANALYSISCNBD
(
  object_id                    VARCHAR2(100) not null,
  s_info_windcode              VARCHAR2(40),
  trade_dt                     VARCHAR2(8),
  b_anal_matu_cnbd             NUMBER(20,4),
  b_anal_dirty_cnbd            NUMBER(20,4),
  b_anal_accrint_cnbd          NUMBER(20,4),
  b_anal_net_cnbd              NUMBER(20,4),
  b_anal_yield_cnbd            NUMBER(20,4),
  b_anal_modidura_cnbd         NUMBER(20,4),
  b_anal_cnvxty_cnbd           NUMBER(20,4),
  b_anal_vobp_cnbd             NUMBER(20,4),
  b_anal_sprdura_cnbd          NUMBER(20,4),
  b_anal_sprcnxt_cnbd          NUMBER(20,4),
  b_anal_accrintclose_cnbd     NUMBER(20,4),
  b_anal_price                 NUMBER(20,4),
  b_anal_netprice              NUMBER(20,4),
  b_anal_yield                 NUMBER(20,4),
  b_anal_modifiedduration      NUMBER(20,4),
  b_anal_convexity             NUMBER(20,4),
  b_anal_bpvalue               NUMBER(20,4),
  b_anal_sduration             NUMBER(20,4),
  b_anal_scnvxty               NUMBER(20,4),
  b_anal_interestduration_cnbd NUMBER(20,4),
  b_anal_interestcnvxty_cnbd   NUMBER(20,4),
  b_anal_interestduration      NUMBER(20,4),
  b_anal_interestcnvxty        NUMBER(20,4),
  b_anal_price_cnbd            NUMBER(20,4),
  b_anal_bpyield               NUMBER(20,4),
  b_anal_exchange              VARCHAR2(40),
  b_anal_credibility           VARCHAR2(40),
  b_anal_residualpri           NUMBER(20,4),
  opdate                       DATE,
  opmode                       VARCHAR2(1)
)
tablespace USERS
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
comment on column CBONDANALYSISCNBD.object_id
  is '对象ID';
comment on column CBONDANALYSISCNBD.s_info_windcode
  is 'Wind代码';
comment on column CBONDANALYSISCNBD.trade_dt
  is '交易日期';
comment on column CBONDANALYSISCNBD.b_anal_matu_cnbd
  is '待偿期(年)';
comment on column CBONDANALYSISCNBD.b_anal_dirty_cnbd
  is '估价全价';
comment on column CBONDANALYSISCNBD.b_anal_accrint_cnbd
  is '应计利息';
comment on column CBONDANALYSISCNBD.b_anal_net_cnbd
  is '估价净价';
comment on column CBONDANALYSISCNBD.b_anal_yield_cnbd
  is '估价收益率(%)';
comment on column CBONDANALYSISCNBD.b_anal_modidura_cnbd
  is '估价修正久期';
comment on column CBONDANALYSISCNBD.b_anal_cnvxty_cnbd
  is '估价凸性';
comment on column CBONDANALYSISCNBD.b_anal_vobp_cnbd
  is '估价基点价值';
comment on column CBONDANALYSISCNBD.b_anal_sprdura_cnbd
  is '估价利差久期';
comment on column CBONDANALYSISCNBD.b_anal_sprcnxt_cnbd
  is '估价利差凸性';
comment on column CBONDANALYSISCNBD.b_anal_accrintclose_cnbd
  is '日终应计利息';
comment on column CBONDANALYSISCNBD.b_anal_price
  is '市场全价';
comment on column CBONDANALYSISCNBD.b_anal_netprice
  is '市场净价';
comment on column CBONDANALYSISCNBD.b_anal_yield
  is '市场收益率(%)';
comment on column CBONDANALYSISCNBD.b_anal_modifiedduration
  is '市场修正久期';
comment on column CBONDANALYSISCNBD.b_anal_convexity
  is '市场凸性';
comment on column CBONDANALYSISCNBD.b_anal_bpvalue
  is '市场基点价值';
comment on column CBONDANALYSISCNBD.b_anal_sduration
  is '市场利差久期';
comment on column CBONDANALYSISCNBD.b_anal_scnvxty
  is '市场利差凸性';
comment on column CBONDANALYSISCNBD.b_anal_interestduration_cnbd
  is '估价利率久期';
comment on column CBONDANALYSISCNBD.b_anal_interestcnvxty_cnbd
  is '估价利率凸性';
comment on column CBONDANALYSISCNBD.b_anal_interestduration
  is '市场利率久期';
comment on column CBONDANALYSISCNBD.b_anal_interestcnvxty
  is '市场利率凸性';
comment on column CBONDANALYSISCNBD.b_anal_price_cnbd
  is '日终估价全价';
comment on column CBONDANALYSISCNBD.b_anal_bpyield
  is '点差收益率(%)';
comment on column CBONDANALYSISCNBD.b_anal_exchange
  is '流通场所';
comment on column CBONDANALYSISCNBD.b_anal_credibility
  is '可信度';
comment on column CBONDANALYSISCNBD.b_anal_residualpri
  is '剩余本金';
-- Create/Recreate primary, unique and foreign key constraints 
alter table CBONDANALYSISCNBD
  add primary key (OBJECT_ID)
  using index 
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
-- Create/Recreate indexes 
create index IDX_CBONDANALYSISCNBD1 on CBONDANALYSISCNBD (S_INFO_WINDCODE)
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
create index IDX_CBONDANALYSISCNBD2 on CBONDANALYSISCNBD (TRADE_DT)
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
create index IDX_CBONDANALYSISCNBD4 on CBONDANALYSISCNBD (S_INFO_WINDCODE, TRADE_DT, B_ANAL_CREDIBILITY)
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
create index IDX_CBONDANALYSISCNBD_QK1 on CBONDANALYSISCNBD (S_INFO_WINDCODE, TRADE_DT)
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

create table CMFFINANCIALINDICATOR
(
  object_id                 VARCHAR2(100) not null,
  s_info_windcode           VARCHAR2(40),
  sec_id                    VARCHAR2(10),
  report_period             VARCHAR2(8),
  ann_dt                    VARCHAR2(8),
  is_list                   NUMBER(5),
  anal_netincome            NUMBER(20,4),
  anal_income               NUMBER(20,4),
  anal_avgnetincomeperunit  NUMBER(20,4),
  anal_avgnavreturn         NUMBER(20,4),
  anal_nav_return           NUMBER(20,4),
  nav_acc_return            NUMBER(20,4),
  anal_distributable        NUMBER(20,4),
  anal_distributableperunit NUMBER(20,4),
  prt_netasset              NUMBER(20,4),
  prt_netassetperunit       NUMBER(20,4),
  prt_totalasset            NUMBER(20,4),
  unit_total                NUMBER(20,4),
  opdate                    DATE,
  opmode                    VARCHAR2(1)
)
;
comment on column CMFFINANCIALINDICATOR.object_id
  is '对象ID';
comment on column CMFFINANCIALINDICATOR.s_info_windcode
  is 'Wind代码';
comment on column CMFFINANCIALINDICATOR.sec_id
  is '证券ID';
comment on column CMFFINANCIALINDICATOR.report_period
  is '报告期';
comment on column CMFFINANCIALINDICATOR.ann_dt
  is '公告日期';
comment on column CMFFINANCIALINDICATOR.is_list
  is '是否上市后数据';
comment on column CMFFINANCIALINDICATOR.anal_netincome
  is '本期利润扣减本期公允价值变动损益后的净额';
comment on column CMFFINANCIALINDICATOR.anal_income
  is '本期利润';
comment on column CMFFINANCIALINDICATOR.anal_avgnetincomeperunit
  is '加权平均基金份额本期利润';
comment on column CMFFINANCIALINDICATOR.anal_avgnavreturn
  is '加权平均净值利润率(%)';
comment on column CMFFINANCIALINDICATOR.anal_nav_return
  is '净值增长率(%)';
comment on column CMFFINANCIALINDICATOR.nav_acc_return
  is '累计净值增长率(%)';
comment on column CMFFINANCIALINDICATOR.anal_distributable
  is '期末可供分配基金收益';
comment on column CMFFINANCIALINDICATOR.anal_distributableperunit
  is '期末可供分配单位基金收益';
comment on column CMFFINANCIALINDICATOR.prt_netasset
  is '资产净值';
comment on column CMFFINANCIALINDICATOR.prt_netassetperunit
  is '单位净值';
comment on column CMFFINANCIALINDICATOR.prt_totalasset
  is '资产总值';
comment on column CMFFINANCIALINDICATOR.unit_total
  is '期末基金总份额';
alter table CMFFINANCIALINDICATOR
  add primary key (OBJECT_ID);


create table CHINAMUTUALFUNDSTOCKPORTFOLIO
(
  object_id            VARCHAR2(100) not null,
  s_info_windcode      VARCHAR2(40),
  f_prt_enddate        VARCHAR2(8),
  crncy_code           VARCHAR2(10),
  s_info_stockwindcode VARCHAR2(10),
  f_prt_stkvalue       NUMBER(20,4),
  f_prt_stkquantity    NUMBER(20,4),
  f_prt_stkvaluetonav  NUMBER(20,4),
  f_prt_posstkvalue    NUMBER(20,4),
  f_prt_posstkquantity NUMBER(20,4),
  f_prt_posstktonav    NUMBER(20,4),
  f_prt_passtkevalue   NUMBER(20,4),
  f_prt_passtkquantity NUMBER(20,4),
  f_prt_passtktonav    NUMBER(20,4),
  ann_date             VARCHAR2(8),
  stock_per            NUMBER(20,2),
  float_shr_per        NUMBER(20,2),
  opdate               DATE,
  opmode               VARCHAR2(1)
)
;
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.object_id
  is '对象ID';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.s_info_windcode
  is '基金Wind代码';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_enddate
  is '截止日期';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.crncy_code
  is '货币代码';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.s_info_stockwindcode
  is '持有股票Wind代码';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_stkvalue
  is '持有股票市值(元)';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_stkquantity
  is '持有股票数量（股）';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_stkvaluetonav
  is '持有股票市值占基金净值比例(%)';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_posstkvalue
  is '积极投资持有股票市值(元)';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_posstkquantity
  is '积极投资持有股数（股）';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_posstktonav
  is '积极投资持有股票市值占净资产比例(%)';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_passtkevalue
  is '指数投资持有股票市值(元)';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_passtkquantity
  is '指数投资持有股数（股）';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.f_prt_passtktonav
  is '指数投资持有股票市值占净资产比例(%)';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.ann_date
  is '公告日期';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.stock_per
  is '占股票市值比';
comment on column CHINAMUTUALFUNDSTOCKPORTFOLIO.float_shr_per
  is '占流通股本比例';
create index PK_CHINAMUTUALFUNDSTOCK on CHINAMUTUALFUNDSTOCKPORTFOLIO (S_INFO_WINDCODE, F_PRT_ENDDATE, S_INFO_STOCKWINDCODE);
alter table CHINAMUTUALFUNDSTOCKPORTFOLIO
  add primary key (OBJECT_ID);


create table CMFOTHERPORTFOLIO
(
  object_id           VARCHAR2(100) not null,
  s_info_windcode     VARCHAR2(40),
  end_dt              VARCHAR2(8),
  ann_dt              VARCHAR2(8),
  crncy_code          VARCHAR2(10),
  s_info_holdwindcode VARCHAR2(40),
  value               NUMBER(20,4),
  quantity            NUMBER(20,4),
  valuetonav          NUMBER(20,4),
  opdate              DATE,
  opmode              VARCHAR2(1)
)
;
comment on column CMFOTHERPORTFOLIO.object_id
  is '对象ID';
comment on column CMFOTHERPORTFOLIO.s_info_windcode
  is 'Wind代码';
comment on column CMFOTHERPORTFOLIO.end_dt
  is '截止日期';
comment on column CMFOTHERPORTFOLIO.ann_dt
  is '公告日期';
comment on column CMFOTHERPORTFOLIO.crncy_code
  is '货币代码';
comment on column CMFOTHERPORTFOLIO.s_info_holdwindcode
  is 'Wind代码';
comment on column CMFOTHERPORTFOLIO.value
  is '持仓市值';
comment on column CMFOTHERPORTFOLIO.quantity
  is '持仓数量(股/张)';
comment on column CMFOTHERPORTFOLIO.valuetonav
  is '持仓市值占基金净值比例(%)';
create index PK_CMFOTHERPORTFOLIO on CMFOTHERPORTFOLIO (S_INFO_WINDCODE, END_DT, S_INFO_HOLDWINDCODE);
alter table CMFOTHERPORTFOLIO
  add primary key (OBJECT_ID);


create table CHINAMUTUALFUNDASSETPORTFOLIO
(
  object_id              VARCHAR2(100) not null,
  s_info_windcode        VARCHAR2(40),
  f_prt_enddate          VARCHAR2(8),
  crncy_code             VARCHAR2(10),
  f_prt_totalasset       NUMBER(20,4),
  f_prt_netasset         NUMBER(20,4),
  f_prt_stockvalue       NUMBER(20,4),
  f_prt_stocktonav       NUMBER(20,4),
  f_prt_pasvstkvalue     NUMBER(15,2),
  f_prt_pasvstktonav     NUMBER(20,4),
  f_prt_posvstkvalue     NUMBER(20,4),
  f_prt_posvstktonav     NUMBER(20,4),
  f_prt_govbond          NUMBER(20,4),
  f_prt_govbondtonav     NUMBER(20,4),
  f_prt_cash             NUMBER(20,4),
  f_prt_cashtonav        NUMBER(20,4),
  f_prt_govcashvalue     NUMBER(20,4),
  f_prt_govcashtonav     NUMBER(20,4),
  f_prt_bdvalue_nogov    NUMBER(20,4),
  f_prt_bdtonav_nogov    NUMBER(20,4),
  f_prt_finanbond        NUMBER(20,4),
  f_prt_finanbondtonav   NUMBER(20,4),
  f_prt_covertbond       NUMBER(15,2),
  f_prt_covertbondtonav  NUMBER(20,4),
  f_prt_corpbond         NUMBER(20,4),
  f_prt_corpbondtonav    NUMBER(20,4),
  f_prt_bondvalue        NUMBER(20,4),
  f_prt_bondtonav        NUMBER(20,4),
  f_prt_ctrbankbill      NUMBER(20,4),
  f_prt_ctrbankbilltonav NUMBER(20,4),
  f_prt_warrantvalue     NUMBER(20,4),
  f_prt_warrantonav      NUMBER(20,4),
  f_prt_absvalue         NUMBER(20,4),
  f_prt_absvaluetonav    NUMBER(20,4),
  f_prt_polifinanbdvalue NUMBER(20,4),
  f_prt_polifinanbdtonav NUMBER(20,4),
  f_prt_fundvalue        NUMBER(20,4),
  f_prt_fundtonav        NUMBER(20,4),
  f_prt_mmvalue          NUMBER(20,4),
  f_prt_mmtonav          NUMBER(20,4),
  f_prt_other            NUMBER(20,4),
  f_prt_othertonav       NUMBER(20,4),
  f_prt_debcrebalance    NUMBER(20,4),
  f_mmf_avgptm           NUMBER(20,4),
  f_mmf_reverserepo      NUMBER(20,4),
  f_mmf_repo             NUMBER(20,4),
  f_prt_stocktotot       NUMBER(20,4),
  f_prt_bondtotot        NUMBER(20,4),
  f_prt_cashtotot        NUMBER(20,4),
  f_prt_othertotot       NUMBER(20,4),
  f_prt_warrantotot      NUMBER(20,4),
  f_prt_fundtotot        NUMBER(20,4),
  f_prt_mmtotot          NUMBER(20,4),
  f_prt_stocktonavchange NUMBER(20,4),
  f_prt_bondtonavchange  NUMBER(20,4),
  f_prt_cashtonavchange  NUMBER(20,4),
  f_prt_othertototchange NUMBER(20,4),
  f_prt_cpvalue          NUMBER(20,4),
  f_prt_mtnvalue         NUMBER(20,4),
  f_prt_cds              NUMBER(20,4),
  f_prt_hkstockvalue     NUMBER(20,4),
  f_prt_hkstocktonav     NUMBER(20,4),
  opdate                 DATE,
  opmode                 VARCHAR2(1)
)
;
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.object_id
  is '对象ID';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.s_info_windcode
  is 'Wind代码';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_enddate
  is '截止日期';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.crncy_code
  is '货币代码';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_totalasset
  is '资产总值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_netasset
  is '资产净值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_stockvalue
  is '持有股票市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_stocktonav
  is '持有股票市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_pasvstkvalue
  is '指数投资持有股票市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_pasvstktonav
  is '指数投资持有股票市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_posvstkvalue
  is '积极投资持有股票市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_posvstktonav
  is '积极投资持有股票市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_govbond
  is '持有国债市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_govbondtonav
  is '持有国债市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_cash
  is '持有现金(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_cashtonav
  is '持有现金占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_govcashvalue
  is '持有国债及现金总值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_govcashtonav
  is '持有国债及现金占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_bdvalue_nogov
  is '持有债券市值(不含国债)(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_bdtonav_nogov
  is '持有债券市值(不含国债)占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_finanbond
  is '持有金融债市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_finanbondtonav
  is '持有金融债市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_covertbond
  is '持有可转债市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_covertbondtonav
  is '持有可转债市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_corpbond
  is '持有企债市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_corpbondtonav
  is '持有企债市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_bondvalue
  is '持有债券市值总计(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_bondtonav
  is '持有债券市值总计占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_ctrbankbill
  is '持有央行票据市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_ctrbankbilltonav
  is '持有央行票据市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_warrantvalue
  is '持有权证市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_warrantonav
  is '持有权证市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_absvalue
  is '持有资产支持证券市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_absvaluetonav
  is '持有资产支持证券占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_polifinanbdvalue
  is '持有政策性金融债市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_polifinanbdtonav
  is '持有政策性金融债市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_fundvalue
  is '持有基金市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_fundtonav
  is '持有基金市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_mmvalue
  is '持有货币市场工具市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_mmtonav
  is '持有货币市场工具市值占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_other
  is '持有其他资产(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_othertonav
  is '持有其他资产占资产净值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_debcrebalance
  is '借贷方差额(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_mmf_avgptm
  is '投资组合平均剩余期限(天)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_mmf_reverserepo
  is '买入返售证券(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_mmf_repo
  is '卖出回购证券(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_stocktotot
  is '持有股票市值占资产总值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_bondtotot
  is '持有债券市值占资产总值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_cashtotot
  is '持有现金占资产总值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_othertotot
  is '持有其他资产占资产总值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_warrantotot
  is '持有权证市值占资产总值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_fundtotot
  is '持有基金市值占资产总值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_mmtotot
  is '持有货币市场工具市值占资产总值比例(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_stocktonavchange
  is '持有股票比例较上期变化(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_bondtonavchange
  is '持有债券比例较上期变化(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_cashtonavchange
  is '持有现金比例较上期变化(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_othertototchange
  is '持有其他资产比例较上期变化(%)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_cpvalue
  is '持有短期融资券市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_mtnvalue
  is '持有中期票据市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_cds
  is '持有同业存单市值(元)';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_hkstockvalue
  is '港股通投资港股市值';
comment on column CHINAMUTUALFUNDASSETPORTFOLIO.f_prt_hkstocktonav
  is '港股通投资港股市值占资产净值比';
create index PK2_CHINAMUTUALPORTFOLIO on CHINAMUTUALFUNDASSETPORTFOLIO (S_INFO_WINDCODE);
create index PK3_CHINAMUTUALPORTFOLIO on CHINAMUTUALFUNDASSETPORTFOLIO (F_PRT_ENDDATE);
create index PK_CHINAMUTUALPORTFOLIO on CHINAMUTUALFUNDASSETPORTFOLIO (S_INFO_WINDCODE, F_PRT_ENDDATE);
alter table CHINAMUTUALFUNDASSETPORTFOLIO
  add primary key (OBJECT_ID);


create table CHINAMUTUALFUNDBONDPORTFOLIO
(
  object_id           VARCHAR2(100) not null,
  s_info_windcode     VARCHAR2(40),
  f_prt_enddate       VARCHAR2(8),
  crncy_code          VARCHAR2(10),
  s_info_bondwindcode VARCHAR2(40),
  f_prt_bdvalue       NUMBER(20,4),
  f_prt_bdquantity    NUMBER(20,4),
  f_prt_bdvaluetonav  NUMBER(20,4),
  opdate              DATE,
  opmode              VARCHAR2(1)
)
;
comment on column CHINAMUTUALFUNDBONDPORTFOLIO.object_id
  is '对象ID';
comment on column CHINAMUTUALFUNDBONDPORTFOLIO.s_info_windcode
  is '基金Wind代码';
comment on column CHINAMUTUALFUNDBONDPORTFOLIO.f_prt_enddate
  is '截止日期';
comment on column CHINAMUTUALFUNDBONDPORTFOLIO.crncy_code
  is '货币代码';
comment on column CHINAMUTUALFUNDBONDPORTFOLIO.s_info_bondwindcode
  is '持有债券Wind代码';
comment on column CHINAMUTUALFUNDBONDPORTFOLIO.f_prt_bdvalue
  is '持有债券市值(元)';
comment on column CHINAMUTUALFUNDBONDPORTFOLIO.f_prt_bdquantity
  is '持有债券数量（张）';
comment on column CHINAMUTUALFUNDBONDPORTFOLIO.f_prt_bdvaluetonav
  is '持有债券市值占基金净值比例(%)';
create index PK_CHINAMUTUALFUNDBOND on CHINAMUTUALFUNDBONDPORTFOLIO (S_INFO_WINDCODE, F_PRT_ENDDATE, S_INFO_BONDWINDCODE);
alter table CHINAMUTUALFUNDBONDPORTFOLIO
  add primary key (OBJECT_ID);


create table CHINAMUTUALFUNDMANAGER
(
  object_id                  VARCHAR2(100) not null,
  f_info_windcode            VARCHAR2(40),
  ann_date                   VARCHAR2(8),
  f_info_fundmanager         VARCHAR2(20),
  f_info_manager_gender      VARCHAR2(10),
  f_info_manager_birthyear   VARCHAR2(10),
  f_info_manager_education   VARCHAR2(20),
  f_info_manager_nationality VARCHAR2(10),
  f_info_manager_startdate   VARCHAR2(8),
  f_info_manager_leavedate   VARCHAR2(8),
  f_info_manager_resume      CLOB,
  f_info_fundmanager_id      VARCHAR2(10),
  opdate                     DATE,
  opmode                     VARCHAR2(1)
)
;
comment on column CHINAMUTUALFUNDMANAGER.object_id
  is '对象ID';
comment on column CHINAMUTUALFUNDMANAGER.f_info_windcode
  is 'Wind代码';
comment on column CHINAMUTUALFUNDMANAGER.ann_date
  is '公告日期';
comment on column CHINAMUTUALFUNDMANAGER.f_info_fundmanager
  is '姓名';
comment on column CHINAMUTUALFUNDMANAGER.f_info_manager_gender
  is '性别';
comment on column CHINAMUTUALFUNDMANAGER.f_info_manager_birthyear
  is '出身年份';
comment on column CHINAMUTUALFUNDMANAGER.f_info_manager_education
  is '学历';
comment on column CHINAMUTUALFUNDMANAGER.f_info_manager_nationality
  is '国籍';
comment on column CHINAMUTUALFUNDMANAGER.f_info_manager_startdate
  is '任职日期';
comment on column CHINAMUTUALFUNDMANAGER.f_info_manager_leavedate
  is '离职日期';
comment on column CHINAMUTUALFUNDMANAGER.f_info_manager_resume
  is '简历';
comment on column CHINAMUTUALFUNDMANAGER.f_info_fundmanager_id
  is '基金经理ID';
alter table CHINAMUTUALFUNDMANAGER
  add primary key (OBJECT_ID);