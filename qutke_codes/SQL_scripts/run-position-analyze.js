//放入 bin 下
const oracle = require('../db/oracle')

function run() {
  const sql = `
  declare

   o_code number;
   o_note VARCHAR2(4000);
  BEGIN
  
    FOR x IN (
        select distinct f_code, biz_date
        from
        ftuser.fund_analysis_info a
        where a.biz_date >= 20190918 and a.biz_date <= 20190928
    ) LOOP
    pro_fund_position_analysis(o_code, o_note, x.f_code, x.biz_date);
    commit;
    END LOOP;
  END;
  `
  console.time('fund-position-analysis')
  oracle.query(sql, err => {
    if (err) {
      console.log('run fund position analysis', err)
    } else {
      console.log('run fund position analysis done')
    }
    console.timeEnd('fund-position-analysis')
    process.exit()
  })
}

setTimeout(run, 3000)
