const moment = require('moment')

// var day = moment(1318781876406).format('YYYY/MM/DD');
// console.log(day)



// const backDays = 7
// const startDate = +moment().subtract(backDays, 'day').startOf('date')
// const endDate = +moment().startOf('date')


fund=  { _id:'5fc2f61c6ab0e421b40ace76',
    _qutkeId: '9734',
    name: '财再-外委景顺长城',
    scale:
     [ { injection: 675243890.59,
         value: 675243890.59,
         date: 1609171200000 },
       { value: 695253319.61, date: 1609257600000 },
       { value: 659728635.55, date: 1609344000000 } ] }
  
const startDate = +moment('2020-12-15').startOf('day')
const endDate = +moment('2020-12-17').startOf('day')
const scale = (fund.scale || []).filter(item => item.date >= startDate && item.date <= endDate)

console.log(scale)
const backDays = 7

const startDate1 = +moment().subtract(backDays, 'day').startOf('date')
const endDate1 = +moment().startOf('date')
console.log(startDate1,endDate1)
