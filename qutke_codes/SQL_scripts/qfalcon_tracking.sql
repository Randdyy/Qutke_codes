-- Create table
create table QFALCON_TRACKING
(
  object_id  varchar2(100),
  ts         NUMBER,
  updatetime DATE default sysdate
)
tablespace mom
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