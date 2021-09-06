alter maa_ftuser.FUND_EQ_POSITION modify(concept VARCHAR2(3000));
alter maa_ftuser.fund_eq_concept modify(concept_name VARCHAR2(100));
alter maa_ftuser.FUND_BOND_POSITION modify(issuer VARCHAR2(200));
alter maa_ftuser.FUND_BOND_POSITION modify(full_name VARCHAR2(400));
alter maa_ftuser.FUND_BOND_POSITION modify(city VARCHAR2(100));
alter maa_ftuser.FUND_BOND_CONCEPT modify(concept_name VARCHAR2(100));

alter table maa_refdatauser.stock_concept modify(concept_name VARCHAR2(3000));