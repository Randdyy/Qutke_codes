const moment = require('moment')
const tables = require('./oracle-history-tables')
const dataModel = require('./data-model')

async function sync(startDate, endDate) {
  const tableList = tables.filter(item => {
    //return true
    return ['ASHAREINCOME'].includes(item.table)
    //return ['ASHAREEODPRICES','ASHAREEODDERIVATIVEINDICATOR','AINDEXEODPRICES','AINDEXCSI500WEIGHTAINDEXCSI500WEIGHT','AINDEXCSI500WEIGHT','AINDEXCSI500WEIGHT','AINDEXHS300WEIGHT','CFUTURESMARGINRATIO','HS300IEODPRICES','CBONDNEGATIVECREDITEVENT','CBONDVALUATION','HKSHAREEODPRICES','ASHARETRADINGSUSPENSION','CINDEXFUTURESEODPRICES','CBONDFUTURESEODPRICES','CCOMMODITYFUTURESEODPRICES','CBONDPRICES','HKSTOCKHSINDEXWEIGHT','CBINDEXEODPRICES','CHINAMUTUALFUNDNAV','CHINAOPTIONVALUATION','CBONDCURVECNBD','HKSHAREEODDERIVATIVEINDEX','COPTIONEMBEDDEDBONDVALUATION','HKINDEXEODPRICES'].includes(item.table)
    //return ['ASHAREEODPRICES', 'ASHAREEODDERIVATIVEINDICATOR', 'ASHAREBALANCESHEET', 'ASHAREINCOME', 'ASHARECASHFLOW', 'ASHAREFINANCIALINDICATOR', 'AINDEXEODPRICES', 'ASHARETTMHIS', 'AINDEXCSI500WEIGHT', 'AINDEXHS300WEIGHT', 'CFUTURESMARGINRATIO', 'HS300IEODPRICES', 'HKBALANCESHEETSIMPLE', 'HKINCOMESIMPLE', 'HKCASHFLOWSIMPLE', 'HKFINANCIALINDICATOR', 'HKSHAREEODDERIVATIVEINDEX', 'CBONDNEGATIVECREDITEVENT', 'CBONDRATING', 'CBONDVALUATION', 'HKSHAREEODPRICES', 'ASHARETRADINGSUSPENSION', 'CFUTURESCONTRACTMAPPING', 'CINDEXFUTURESEODPRICES', 'CBONDFUTURESEODPRICES', 'CCOMMODITYFUTURESEODPRICES', 'CBONDPRICES', 'HKSTOCKHSINDEXWEIGHT', 'HKINDEXEODPRICES', 'CBONDISSUERRATING', 'CBINDEXEODPRICES', 'COPTIONEMBEDDEDBONDVALUATION', 'CHINAMUTUALFUNDNAV', 'CHINAOPTIONVALUATION', 'CBONDCURVECNBD'].includes(item.table)
  })
  for (const tableInfo of tableList) {
    try {
      const { table } = tableInfo
      const taskName = `Update ${table}`
      console.time(taskName)
      await dataModel.exportData({
        ...tableInfo,
        startDate,
        endDate,
        whiteList: ['chinareapp'],
      })
      console.timeEnd(taskName)
    } catch (error) {
      console.log(error)
      console.log(`Update ${tableInfo.table} got error`)
    }
  }
}

async function run() {
  const endDateStr = moment().format('YYYY-MM-DD')
  const endDate = moment(new Date('2020-02-09'))
  // let startDate = moment(new Date(endDateStr)).subtract(10, 'day')
  let startDate = moment(new Date('2020-02-01'))
  while (startDate < endDate) {
    const start = startDate.format('YYYYMMDD')
    const end = startDate.add(10, 'day').format('YYYYMMDD')
    await sync(start, end)
  }
  process.exit()
}

setTimeout(run, 2000)