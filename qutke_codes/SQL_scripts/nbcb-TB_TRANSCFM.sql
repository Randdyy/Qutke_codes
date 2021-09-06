create table ftuser.tb_transcfm

(
    client_no VARCHAR2(24) default ' ' not null,
    client_name VARCHAR2(250) default ' ' not null,
    trans_code VARCHAR2(6) default ' ' not null,
    prd_code VARCHAR2(20) default ' ' not null,
    prd_type VARCHAR2(1) default ' ' not null,
    amt number(18,2) default 0.0 not null,
    cfm_date integer default 0 not null
)






comment on column tb_transcfm.client_no
    is '客户号';
comment on column tb_transcfm.client_name
    is '客户名称';
comment on column tb_transcfm.trans_code
    is '交易代码';
comment on column tb_transcfm.prd_code
    is '基金代码';
comment on column tb_transcfm.prd_type
    is '基金类型';
comment on column tb_transcfm.amt
    is '申购量';
comment on column tb_transcfm.cfm_date
    is '确认日期';



