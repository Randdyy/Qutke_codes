create table ftuser.libra_subject_info(
    id varchar(64),
    value_setID varchar(20),
    value_id varchar(20),
    subject_code varchar(20),
    subject_level varchar(2),  
    on_sign varchar(1),  
    detail_subject_sign varchar(2),
    on_date varchar(20),
    Expir_Date varchar(20),
    subject_desc varchar(100),
    father_node varchar(20),
    data_status varchar(2),
    created_by varchar(30),
    created_date varchar(10),
    UPDATED_BY varchar(30),
    UPDATED_DATE varchar(20),  
    check_subject varchar(20),
    check_subject_desc varchar(120),
    default_subject varchar(2),
    FDBname varchar(5)

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