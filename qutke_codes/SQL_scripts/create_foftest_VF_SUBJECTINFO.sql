create table ftuser.VF_SUBJECTINFO(
N_ID	varchar(30)	not null,
N_YEAR	Number(4)	not null,
C_PLAN_CODE	varchar(20)	not null,
C_PORT_CODE	varchar(20)	not null,
C_ASSET_CODE	varchar(20)	not null,
C_Subj_CODE	varchar(50)	not null,
C_Subj_Name	varchar(100) not null,
C_SUBJ_TYPE	varchar(20)	not null,
C_PA_CODE	varchar(20)	not null,
C_CURY_CODE	varchar(20)	not null,
C_Subj_CODE_P	varchar(50)	,
C_MKT_CODE	varchar(20)	not null,
C_SEC_VAR	varchar(20)	,
C_SEC_VAR_MX	varchar(20)	,
C_IVT_CLSS	varchar(20)	not null,
C_HLD_ATTR	varchar(20)	not null,
C_TD_ATTR	varchar(20)	not null,
C_ML_ATTR	varchar(20)	not null,
C_SEC_CODE	varchar(50)	,
C_CA_CODE	varchar(20)	,
C_PI_CODE	varchar(20)	,
N_SUBJ_DETAIL	Number(1)	,
C_DV_BOOL_TYPE_AM	varchar(20)	,
C_DV_JD_WAY	varchar(20)	not null,
C_SUBJ_LEVEL	varchar(10)	not null,
C_DS_CODE	varchar(20)	not null,
C_ORG_CODE	varchar(20)	,
C_DV_INVEST_MODE	varchar(20)	,
C_DV_SEC_DUR	varchar(20)	,
C_WART_TYPE	varchar(20)	,
C_EXER_MODE	varchar(20)	,
C_UPDATE_TIME	varchar(20)	not null,
C_TIMESTAMP	varchar(20)	not null,
constraint PK_VF_SUBJECTINFO  primary key(N_ID)
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

comment on column ftuser.VF_SUBJECTINFO.N_ID is '唯一，SEQ';
-- comment on column ftuser.VF_SUBJECTINFO.N_YEAR is '';
-- comment on column ftuser.VF_SUBJECTINFO.C_PLAN_CODE is '';
comment on column ftuser.VF_SUBJECTINFO.C_PORT_CODE is '见基础参数：组合基本信息';
comment on column ftuser.VF_SUBJECTINFO.C_ASSET_CODE is '资产代码';
-- comment on column ftuser.VF_SUBJECTINFO.C_Subj_CODE is '';
-- comment on column ftuser.VF_SUBJECTINFO.C_Subj_Name is '';
comment on column ftuser.VF_SUBJECTINFO.C_SUBJ_TYPE is '见词汇字典：[词汇类型]=‘KM_CLS’(科目类别)的[词汇代码]';
comment on column ftuser.VF_SUBJECTINFO.C_PA_CODE is '见核算项目字典：核算项目代码分类';
comment on column ftuser.VF_SUBJECTINFO.C_CURY_CODE is '货币符号字典：币种代码';
comment on column ftuser.VF_SUBJECTINFO.C_Subj_CODE_P is '以及科目时，默认[root]';
comment on column ftuser.VF_SUBJECTINFO.C_MKT_CODE is '交易市场信息：市场代码';
comment on column ftuser.VF_SUBJECTINFO.C_SEC_VAR is '见证券属性字典';
comment on column ftuser.VF_SUBJECTINFO.C_SEC_VAR_MX is '见证券属性字典：证券属性代码';
comment on column ftuser.VF_SUBJECTINFO.C_IVT_CLSS is '见词汇字典：[词汇类型]=‘IVT_CLS’的[词汇代码]';
comment on column ftuser.VF_SUBJECTINFO.C_HLD_ATTR is '见词汇字典：持有属性分类';
comment on column ftuser.VF_SUBJECTINFO.C_TD_ATTR is '见交易属性字典：属性代码';
comment on column ftuser.VF_SUBJECTINFO.C_ML_ATTR is '见词汇字典：[词汇类型]=‘ISSUE_MODE’的[词汇代码]';
comment on column ftuser.VF_SUBJECTINFO.C_SEC_CODE is '见基础信息：证券基本信息';
comment on column ftuser.VF_SUBJECTINFO.C_CA_CODE is '见现金账户主表：现金账户内码';
comment on column ftuser.VF_SUBJECTINFO.C_PI_CODE is '见收支项目:收支代码';
comment on column ftuser.VF_SUBJECTINFO.N_SUBJ_DETAIL is '0-非明细；1-明细科目';
comment on column ftuser.VF_SUBJECTINFO.C_DV_BOOL_TYPE_AM is '0-不核算；1-核算';
comment on column ftuser.VF_SUBJECTINFO.C_DV_JD_WAY is '见词汇字典：借贷方向';
comment on column ftuser.VF_SUBJECTINFO. is 'JD_J:借    JD_D:贷     JD_P:平';
comment on column ftuser.VF_SUBJECTINFO.C_SUBJ_LEVEL is '1-1级科目；2-2级科目；3-3级科目；4-4级科目';
comment on column ftuser.VF_SUBJECTINFO.C_DS_CODE is '见交易方式字典表：交易方式代码';
comment on column ftuser.VF_SUBJECTINFO.C_ORG_CODE is '见机构基本信息：机构代码';
comment on column ftuser.VF_SUBJECTINFO.C_DV_INVEST_MODE is '见词汇字典：[词汇类型]=‘INV’(投资对象)的[词汇代码]';
comment on column ftuser.VF_SUBJECTINFO.C_DV_SEC_DUR is '见词汇字典：[词汇类型]=‘SEC_DUR’(品种期限)的[词汇代码]';
comment on column ftuser.VF_SUBJECTINFO.C_WART_TYPE is '见词汇字典：[词汇类型]=‘QQ_QZ_TYPE’(类型（期权、权证）)的[词汇代码]';
comment on column ftuser.VF_SUBJECTINFO.C_EXER_MODE is '见词汇字典：[词汇类型]=‘EXE_STYLE’(行权方式)的[词汇代码]';
comment on column ftuser.VF_SUBJECTINFO.C_UPDATE_TIME is '格式YYYYMMDD HH:MM:SS';
comment on column ftuser.VF_SUBJECTINFO.C_TIMESTAMP is '格式YYYYMMDD HH:MM:SS';


create unique index IDX_VF_SUBJECTINFO on ftuser.VF_SUBJECTINFO (N_YEAR,C_PORT_CODE,C_Subj_CODE)
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


  create index IDX_VF_SUBJECTINFO1 on ftuser.VF_SUBJECTINFO (N_YEAR, C_PORT_CODE, C_Subj_CODE)
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

  create index IDX_VF_SUBJECTINFO2 on ftuser.VF_SUBJECTINFO (C_PA_CODE)
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