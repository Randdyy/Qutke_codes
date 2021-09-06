-- Create table
create table wind.ASHARECASHFLOW
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
tablespace WIND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 524
    next 4
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column wind.ASHARECASHFLOW.object_id
  is '对象ID';
comment on column wind.ASHARECASHFLOW.s_info_windcode
  is 'Wind代码';
comment on column wind.ASHARECASHFLOW.wind_code
  is 'Wind代码';
comment on column wind.ASHARECASHFLOW.ann_dt
  is '公告日期';
comment on column wind.ASHARECASHFLOW.report_period
  is '报告期';
comment on column wind.ASHARECASHFLOW.statement_type
  is '报表类型';
comment on column wind.ASHARECASHFLOW.crncy_code
  is '货币代码';
comment on column wind.ASHARECASHFLOW.cash_recp_sg_and_rs
  is '销售商品、提供劳务收到的现金';
comment on column wind.ASHARECASHFLOW.recp_tax_rends
  is '收到的税费返还';
comment on column wind.ASHARECASHFLOW.net_incr_dep_cob
  is '客户存款和同业存放款项净增加额';
comment on column wind.ASHARECASHFLOW.net_incr_loans_central_bank
  is '向中央银行借款净增加额';
comment on column wind.ASHARECASHFLOW.net_incr_fund_borr_ofi
  is '向其他金融机构拆入资金净增加额';
comment on column wind.ASHARECASHFLOW.cash_recp_prem_orig_inco
  is '收到原保险合同保费取得的现金';
comment on column wind.ASHARECASHFLOW.net_incr_insured_dep
  is '保户储金净增加额';
comment on column wind.ASHARECASHFLOW.net_cash_received_reinsu_bus
  is '收到再保业务现金净额';
comment on column wind.ASHARECASHFLOW.net_incr_disp_tfa
  is '处置交易性金融资产净增加额';
comment on column wind.ASHARECASHFLOW.net_incr_int_handling_chrg
  is '收取利息和手续费净增加额';
comment on column wind.ASHARECASHFLOW.net_incr_disp_faas
  is '处置可供出售金融资产净增加额';
comment on column wind.ASHARECASHFLOW.net_incr_loans_other_bank
  is '拆入资金净增加额';
comment on column wind.ASHARECASHFLOW.net_incr_repurch_bus_fund
  is '回购业务资金净增加额';
comment on column wind.ASHARECASHFLOW.other_cash_recp_ral_oper_act
  is '收到其他与经营活动有关的现金';
comment on column wind.ASHARECASHFLOW.stot_cash_inflows_oper_act
  is '经营活动现金流入小计';
comment on column wind.ASHARECASHFLOW.cash_pay_goods_purch_serv_rec
  is '购买商品、接受劳务支付的现金';
comment on column wind.ASHARECASHFLOW.cash_pay_beh_empl
  is '支付给职工以及为职工支付的现金';
comment on column wind.ASHARECASHFLOW.pay_all_typ_tax
  is '支付的各项税费';
comment on column wind.ASHARECASHFLOW.net_incr_clients_loan_adv
  is '客户贷款及垫款净增加额';
comment on column wind.ASHARECASHFLOW.net_incr_dep_cbob
  is '存放央行和同业款项净增加额';
comment on column wind.ASHARECASHFLOW.cash_pay_claims_orig_inco
  is '支付原保险合同赔付款项的现金';
comment on column wind.ASHARECASHFLOW.handling_chrg_paid
  is '支付手续费的现金';
comment on column wind.ASHARECASHFLOW.comm_insur_plcy_paid
  is '支付保单红利的现金';
comment on column wind.ASHARECASHFLOW.other_cash_pay_ral_oper_act
  is '支付其他与经营活动有关的现金';
comment on column wind.ASHARECASHFLOW.stot_cash_outflows_oper_act
  is '经营活动现金流出小计';
comment on column wind.ASHARECASHFLOW.net_cash_flows_oper_act
  is '经营活动产生的现金流量净额';
comment on column wind.ASHARECASHFLOW.cash_recp_disp_withdrwl_invest
  is '收回投资收到的现金';
comment on column wind.ASHARECASHFLOW.cash_recp_return_invest
  is '取得投资收益收到的现金';
comment on column wind.ASHARECASHFLOW.net_cash_recp_disp_fiolta
  is '处置固定资产、无形资产和其他长期资产收回的现金净额';
comment on column wind.ASHARECASHFLOW.net_cash_recp_disp_sobu
  is '处置子公司及其他营业单位收到的现金净额';
comment on column wind.ASHARECASHFLOW.other_cash_recp_ral_inv_act
  is '收到其他与投资活动有关的现金';
comment on column wind.ASHARECASHFLOW.stot_cash_inflows_inv_act
  is '投资活动现金流入小计';
comment on column wind.ASHARECASHFLOW.cash_pay_acq_const_fiolta
  is '购建固定资产、无形资产和其他长期资产支付的现金';
comment on column wind.ASHARECASHFLOW.cash_paid_invest
  is '投资支付的现金';
comment on column wind.ASHARECASHFLOW.net_cash_pay_aquis_sobu
  is '取得子公司及其他营业单位支付的现金净额';
comment on column wind.ASHARECASHFLOW.other_cash_pay_ral_inv_act
  is '支付其他与投资活动有关的现金';
comment on column wind.ASHARECASHFLOW.net_incr_pledge_loan
  is '质押贷款净增加额';
comment on column wind.ASHARECASHFLOW.stot_cash_outflows_inv_act
  is '投资活动现金流出小计';
comment on column wind.ASHARECASHFLOW.net_cash_flows_inv_act
  is '投资活动产生的现金流量净额';
comment on column wind.ASHARECASHFLOW.cash_recp_cap_contrib
  is '吸收投资收到的现金';
comment on column wind.ASHARECASHFLOW.incl_cash_rec_saims
  is '其中:子公司吸收少数股东投资收到的现金';
comment on column wind.ASHARECASHFLOW.cash_recp_borrow
  is '取得借款收到的现金';
comment on column wind.ASHARECASHFLOW.proc_issue_bonds
  is '发行债券收到的现金';
comment on column wind.ASHARECASHFLOW.other_cash_recp_ral_fnc_act
  is '收到其他与筹资活动有关的现金';
comment on column wind.ASHARECASHFLOW.stot_cash_inflows_fnc_act
  is '筹资活动现金流入小计';
comment on column wind.ASHARECASHFLOW.cash_prepay_amt_borr
  is '偿还债务支付的现金';
comment on column wind.ASHARECASHFLOW.cash_pay_dist_dpcp_int_exp
  is '分配股利、利润或偿付利息支付的现金';
comment on column wind.ASHARECASHFLOW.incl_dvd_profit_paid_sc_ms
  is '其中:子公司支付给少数股东的股利、利润';
comment on column wind.ASHARECASHFLOW.other_cash_pay_ral_fnc_act
  is '支付其他与筹资活动有关的现金';
comment on column wind.ASHARECASHFLOW.stot_cash_outflows_fnc_act
  is '筹资活动现金流出小计';
comment on column wind.ASHARECASHFLOW.net_cash_flows_fnc_act
  is '筹资活动产生的现金流量净额';
comment on column wind.ASHARECASHFLOW.eff_fx_flu_cash
  is '汇率变动对现金的影响';
comment on column wind.ASHARECASHFLOW.net_incr_cash_cash_equ
  is '现金及现金等价物净增加额';
comment on column wind.ASHARECASHFLOW.cash_cash_equ_beg_period
  is '期初现金及现金等价物余额';
comment on column wind.ASHARECASHFLOW.cash_cash_equ_end_period
  is '期末现金及现金等价物余额';
comment on column wind.ASHARECASHFLOW.net_profit
  is '净利润';
comment on column wind.ASHARECASHFLOW.unconfirmed_invest_loss
  is '未确认投资损失';
comment on column wind.ASHARECASHFLOW.plus_prov_depr_assets
  is '加:资产减值准备';
comment on column wind.ASHARECASHFLOW.depr_fa_coga_dpba
  is '固定资产折旧、油气资产折耗、生产性生物资产折旧';
comment on column wind.ASHARECASHFLOW.amort_intang_assets
  is '无形资产摊销';
comment on column wind.ASHARECASHFLOW.amort_lt_deferred_exp
  is '长期待摊费用摊销';
comment on column wind.ASHARECASHFLOW.decr_deferred_exp
  is '待摊费用减少';
comment on column wind.ASHARECASHFLOW.incr_acc_exp
  is '预提费用增加';
comment on column wind.ASHARECASHFLOW.loss_disp_fiolta
  is '处置固定、无形资产和其他长期资产的损失';
comment on column wind.ASHARECASHFLOW.loss_scr_fa
  is '固定资产报废损失';
comment on column wind.ASHARECASHFLOW.loss_fv_chg
  is '公允价值变动损失';
comment on column wind.ASHARECASHFLOW.fin_exp
  is '财务费用';
comment on column wind.ASHARECASHFLOW.invest_loss
  is '投资损失';
comment on column wind.ASHARECASHFLOW.decr_deferred_inc_tax_assets
  is '递延所得税资产减少';
comment on column wind.ASHARECASHFLOW.incr_deferred_inc_tax_liab
  is '递延所得税负债增加';
comment on column wind.ASHARECASHFLOW.decr_inventories
  is '存货的减少';
comment on column wind.ASHARECASHFLOW.decr_oper_payable
  is '经营性应收项目的减少';
comment on column wind.ASHARECASHFLOW.incr_oper_payable
  is '经营性应付项目的增加';
comment on column wind.ASHARECASHFLOW.others
  is '其他';
comment on column wind.ASHARECASHFLOW.im_net_cash_flows_oper_act
  is '间接法-经营活动产生的现金流量净额';
comment on column wind.ASHARECASHFLOW.conv_debt_into_cap
  is '债务转为资本';
comment on column wind.ASHARECASHFLOW.conv_corp_bonds_due_within_1y
  is '一年内到期的可转换公司债券';
comment on column wind.ASHARECASHFLOW.fa_fnc_leases
  is '融资租入固定资产';
comment on column wind.ASHARECASHFLOW.end_bal_cash
  is '现金的期末余额';
comment on column wind.ASHARECASHFLOW.less_beg_bal_cash
  is '减:现金的期初余额';
comment on column wind.ASHARECASHFLOW.plus_end_bal_cash_equ
  is '加:现金等价物的期末余额';
comment on column wind.ASHARECASHFLOW.less_beg_bal_cash_equ
  is '减:现金等价物的期初余额';
comment on column wind.ASHARECASHFLOW.im_net_incr_cash_cash_equ
  is '间接法-现金及现金等价物净增加额';
comment on column wind.ASHARECASHFLOW.free_cash_flow
  is '企业自由现金流量(FCFF)';
comment on column wind.ASHARECASHFLOW.comp_type_code
  is '公司类型代码';
comment on column wind.ASHARECASHFLOW.actual_ann_dt
  is '实际公告日期';
comment on column wind.ASHARECASHFLOW.spe_bal_cash_inflows_oper
  is '经营活动现金流入差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_cash_inflows_oper
  is '经营活动现金流入差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.spe_bal_cash_outflows_oper
  is '经营活动现金流出差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_cash_outflows_oper
  is '经营活动现金流出差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.tot_bal_netcash_outflows_oper
  is '经营活动产生的现金流量净额差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.spe_bal_cash_inflows_inv
  is '投资活动现金流入差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_cash_inflows_inv
  is '投资活动现金流入差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.spe_bal_cash_outflows_inv
  is '投资活动现金流出差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_cash_outflows_inv
  is '投资活动现金流出差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.tot_bal_netcash_outflows_inv
  is '投资活动产生的现金流量净额差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.spe_bal_cash_inflows_fnc
  is '筹资活动现金流入差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_cash_inflows_fnc
  is '筹资活动现金流入差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.spe_bal_cash_outflows_fnc
  is '筹资活动现金流出差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_cash_outflows_fnc
  is '筹资活动现金流出差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.tot_bal_netcash_outflows_fnc
  is '筹资活动产生的现金流量净额差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.spe_bal_netcash_inc
  is '现金净增加额差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_netcash_inc
  is '现金净增加额差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.spe_bal_netcash_equ_undir
  is '间接法-经营活动现金流量净额差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_netcash_equ_undir
  is '间接法-经营活动现金流量净额差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.spe_bal_netcash_inc_undir
  is '间接法-现金净增加额差额(特殊报表科目)';
comment on column wind.ASHARECASHFLOW.tot_bal_netcash_inc_undir
  is '间接法-现金净增加额差额(合计平衡项目)';
comment on column wind.ASHARECASHFLOW.s_info_compcode
  is '公司ID';
comment on column wind.ASHARECASHFLOW.s_dismantle_capital_add_net
  is '拆出资金净增加额';
comment on column wind.ASHARECASHFLOW.is_calculation
  is '是否计算报表';
-- Create/Recreate primary, unique and foreign key constraints 
alter table wind.ASHARECASHFLOW
  add primary key (OBJECT_ID)
  using index 
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 84M
    next 4M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index wind.IDX_ACF_5 on wind.ASHARECASHFLOW (S_INFO_WINDCODE, ANN_DT, REPORT_PERIOD)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 52M
    next 4M
    minextents 1
    maxextents unlimited
  );
create index wind.IDX_ACF_ANNDT on wind.ASHARECASHFLOW (ANN_DT)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 28M
    next 4M
    minextents 1
    maxextents unlimited
  );
create index wind.IDX_ACF_RPT_PRD on wind.ASHARECASHFLOW (REPORT_PERIOD)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 28M
    next 4M
    minextents 1
    maxextents unlimited
  );
create index wind.IDX_ACF_WINDCD on wind.ASHARECASHFLOW (S_INFO_WINDCODE)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 28M
    next 4M
    minextents 1
    maxextents unlimited
  );
create index wind.I_ASHARECASHFLOW2 on wind.ASHARECASHFLOW (STATEMENT_TYPE, S_INFO_WINDCODE, REPORT_PERIOD)
  tablespace WIND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 56M
    next 4M
    minextents 1
    maxextents unlimited
  );


