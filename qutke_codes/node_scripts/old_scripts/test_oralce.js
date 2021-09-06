let db = require('./test1')
let _ = require('lodash')

db.query("SELECT stock_code,biz_date,value FROM ftuser.stock_style where rownum < 101",function(result){
  // console.log(result)
  let funds = _.map(_.groupBy(result, 'BIZ_DATE'), (value, key) => {
    return {
      _qutkeId: key,
      portfolios: value.map(item => item.STOCK_CODE).concat(value.map(item => item.VALUE)),
      //name: fatherNameMap[fatherId]
    }
  })
  console.log(funds)
})
