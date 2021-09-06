
create table ftuser.vf_report_val(
    N_ID            varchar(30),
    D_BIZ           DATE,
    C_PORT_CODE     varchar(20),
    C_ASSET_CODE    varchar(20),
    C_PORT_CLASS    varchar(20),
    C_SUBJ_CODE     varchar(50),
    C_SUBJ_NAME     varchar(100),
    C_KEY_CODE      varchar(50),
    C_KEY_NAME      varchar(200),
    C_CURY_CODE     varchar(3),
    C_PA_CODE       varchar(20),
    C_MKT_CODE      varchar(20),
    C_TD_ATTR       varchar(20),
    C_IVT_CLSS      varchar(20),
    C_HLD_ATTR      varchar(20),
    C_ML_ATTR       varchar(20),
    C_TDCHAN_CODE   varchar(20),
    C_SEC_CODE      varchar(50),
    C_CA_CODE       varchar(20),
    C_DV_FEE_TYPE   varchar(20),
    C_FEE_CODE      varchar(20),
    C_DS_CODE       varchar(20),
    N_HLDAMT        NUMBER(18),
    N_HLDCST        NUMBER(18),
    N_HLDCST_LOCL   NUMBER(18),
    N_HLDMKV        NUMBER(18),
    N_HLDMKV_LOCL   NUMBER(18),
    N_HLDVVA        NUMBER(18),
    N_HLDVVA_L      NUMBER(18),
    C_SUBPEND       varchar(100),
    C_RIGHTS        varchar(100),
    N_VALPRICE      NUMBER(18),
    N_VALRATE       NUMBER(18),
    N_WAY           NUMBER(3),
    C_SUBJ_CODE_T   varchar(50),
    C_NAV_TYPE      varchar(20),
    C_DV_KM_CLS     varchar(20),
    N_LEVEL         NUMBER(3),
    N_ORDER1        NUMBER(3),
    C_SEC_VAR_MX    varchar(20),
    N_NH_DAYS       NUMBER(18),
    N_CB_JZ_BL      NUMBER(18),
    N_SZ_JZ_BL      NUMBER(18),
    N_AMDCST        NUMBER(18),
    N_AMDCST_LOCL   NUMBER(18),
    C_NON_PUB       varchar(10),
    C_CIRCULATE     varchar(10),
    C_SUBPEND_DATE  DATE,
    C_CA_TYPE       varchar(20),
    N_PRICE_COST    NUMBER(18),
    C_UPDATE_TIME   varchar(20),
    C_TIMESTAMP     varchar(20),
    constraint PK_VF_REPORTDATA  primary key(N_ID)
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
-- Add comments to the columns 
comment on column ftuser.vf_report_val.N_ID is '唯一，SEQ';
comment on column ftuser.vf_report_val.D_BIZ is '见数据规则说明，估值日期';
comment on column ftuser.vf_report_val.C_PORT_CODE is '见基础参数：组合基本信息';
comment on column ftuser.vf_report_val.C_ASSET_CODE is '资产代码';
comment on column ftuser.vf_report_val.C_PORT_CLASS is '见分级组合基本：分级组合代码';
comment on column ftuser.vf_report_val.C_SUBJ_CODE is '见财务科目信息：科目代码';
comment on column ftuser.vf_report_val.C_SUBJ_NAME is '见财务科目信息：科目名称';
-- comment on column ftuser.vf_report_val.C_KEY_CODE is '';
-- comment on column ftuser.vf_report_val.C_KEY_NAME is '';
comment on column ftuser.vf_report_val.C_CURY_CODE is '货币符号字典：币种代码';
comment on column ftuser.vf_report_val.C_PA_CODE is '见核算项目字典：核算项目代码分类';
comment on column ftuser.vf_report_val.C_MKT_CODE is '见交易市场信息：市场代码';
comment on column ftuser.vf_report_val.C_TD_ATTR is '见交易属性字典：属性代码';
comment on column ftuser.vf_report_val.C_IVT_CLSS is '见词汇字典：[词汇类型]=‘IVT_CLS’的[词汇代码]';
comment on column ftuser.vf_report_val.C_HLD_ATTR is '见词汇字典：持有属性分类';
comment on column ftuser.vf_report_val.C_ML_ATTR is '见词汇字典：[词汇类型]=‘ISSUE_MODE’的[词汇代码]';
comment on column ftuser.vf_report_val.C_TDCHAN_CODE is '见交易渠道信息：交易渠道代码';
comment on column ftuser.vf_report_val.C_SEC_CODE is '见基础信息：证券基本信息';
comment on column ftuser.vf_report_val.C_CA_CODE is '见现金账户主表：现金账户内码';
comment on column ftuser.vf_report_val.C_DV_FEE_TYPE is '见词汇字典：[词汇类型]=‘FEE_TYPE’(费用类型)的[词汇代码]';
comment on column ftuser.vf_report_val.C_FEE_CODE is '见收支项目:收支代码';
comment on column ftuser.vf_report_val.C_DS_CODE is '见交易方式字典:交易方式代码';
comment on column ftuser.vf_report_val.N_HLDAMT is '见数据规则说明';
comment on column ftuser.vf_report_val.N_HLDCST is '见数据规则说明';
comment on column ftuser.vf_report_val.N_HLDCST_LOCL is '见数据规则说明';
comment on column ftuser.vf_report_val.N_HLDMKV is '见数据规则说明';
comment on column ftuser.vf_report_val.N_HLDMKV_LOCL is '见数据规则说明';
comment on column ftuser.vf_report_val.N_HLDVVA is '见数据规则说明';
comment on column ftuser.vf_report_val.N_HLDVVA_L is '见数据规则说明';
-- comment on column ftuser.vf_report_val.C_SUBPEND is '';
comment on column ftuser.vf_report_val.C_RIGHTS is '百元债券利息';
comment on column ftuser.vf_report_val.N_VALPRICE is '见数据规则说明';
comment on column ftuser.vf_report_val.N_VALRATE is '见数据规则说明';
-- comment on column ftuser.vf_report_val.N_WAY is '';
-- comment on column ftuser.vf_report_val.C_SUBJ_CODE_T is '';
comment on column ftuser.vf_report_val.C_NAV_TYPE is 'SEC:证券类 CACH:现金类 FEE:运营类 OT:其他类 TOTAL:汇总项类 TOTAL_ALL:汇总项_指标类;';
comment on column ftuser.vf_report_val.C_DV_KM_CLS is '见词汇字典：[词汇类型]=‘KM_CLS’(科目类别)的[词汇代码]';
-- comment on column ftuser.vf_report_val.N_LEVEL is '';
-- comment on column ftuser.vf_report_val.N_ORDER1 is '';
comment on column ftuser.vf_report_val.C_SEC_VAR_MX is '见证券属性字典：证券属性代码';
-- comment on column ftuser.vf_report_val.N_NH_DAYS is '';
comment on column ftuser.vf_report_val.N_CB_JZ_BL is '本币成本占净值比';
comment on column ftuser.vf_report_val.N_SZ_JZ_BL is '本币市值占净值比';
-- comment on column ftuser.vf_report_val.N_AMDCST is '';
-- comment on column ftuser.vf_report_val.N_AMDCST_LOCL is '';
comment on column ftuser.vf_report_val.C_NON_PUB is '公开：0，非公开：1';
comment on column ftuser.vf_report_val.C_CIRCULATE is '流通：1，非流通：0';
-- comment on column ftuser.vf_report_val.C_SUBPEND_DATE is '';
comment on column ftuser.vf_report_val.C_CA_TYPE is '见词汇字典：[词汇类型]=‘ACC_TYPE’(账户类型)的[词汇代码]';
-- comment on column ftuser.vf_report_val.N_PRICE_COST is '';
comment on column ftuser.vf_report_val.C_UPDATE_TIME is '格式YYYYMMDD HH:MM:SS';
comment on column ftuser.vf_report_val.C_TIMESTAMP is '格式YYYYMMDD HH:MM:SS';


-- create index
create index IDX_VF_REPORT_VAL on ftuser.vf_report_val (D_BIZ,C_PORT_CODE,C_SUBJ_CODE,C_PA_CODE,C_SEC_CODE，C_CA_CODE，C_FEE_CODE,C_KEY_CODE,C_MKT_CODE,C_TDCHAN_CODE)
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






/* 估值表  ORIG_VALUATION */
create table ORIG_VALUATION
(
  FILE_ID         VARCHAR2(64),
  F_CODE          VARCHAR2(64),
  VERSION_ID      VARCHAR2(64),
  BIZ_DATE        VARCHAR2(8),
  SUBJECT_CODE    VARCHAR2(128),
  SUBJECT_NAME    VARCHAR2(128),
  AMOUNT          VARCHAR2(128),
  UNIT_COST       VARCHAR2(128),
  COST            VARCHAR2(128),
  COST_RATIO      VARCHAR2(128),
  PRICE           VARCHAR2(128),
  BALANCE         VARCHAR2(128),
  BALANCE_RATIO   VARCHAR2(128),
  PROFIT          VARCHAR2(128),
  SUSPENSION_INFO VARCHAR2(128),
  UPDATETIME      DATE default sysdate
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
-- Add comments to the columns 
comment on column ORIG_VALUATION.FILE_ID
  is '每个csv文件，有唯一的标识';
comment on column ORIG_VALUATION.F_CODE
  is '每只产品在系统中唯一的内部标识';
comment on column ORIG_VALUATION.UPDATETIME
  is '更新时间';
-- Create/Recreate indexes 
create index PK_ORIG_VALUATION on ORIG_VALUATION (FILE_ID, F_CODE, VERSION_ID, BIZ_DATE, SUBJECT_CODE, SUBJECT_NAME)
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
