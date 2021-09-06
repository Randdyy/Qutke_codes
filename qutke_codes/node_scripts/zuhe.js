const User = require('../models').User
const Fund = require('../models').Fund
const moment = require('moment')
const _ = require('lodash')
const xlsx = require('node-xlsx')
const fs = require('fs')
const path = require('path')

async function exportData() {
  const records = await Fund.find({ visibility: 'private', isPortfolio: true }).lean().exec()
  const users = await User.find({}, '_id nickname username').lean().exec()
  console.log(instanceof(records))
  const userMap = users.reduce((out, item) => {
    out[item._id] = item
    return out
  }, {})
  const data = records.map(record => {
    const user = userMap[record.surveyAuthorId]
    if (!user) {
      return false
    }
    return [
      moment(record.created_at).format('YYYYMMDD'),
      user.username,
      user.nickname,
    ]
  })
    .filter(Boolean)
    .sort((fst, snd) => snd[0] - fst[0])
  const dataMap = _.countBy(data, item => `${item[1]}`)
  const summaryData = _.map(dataMap, (value, key) => {
    return [key, value]
  })
  const buffer = xlsx.build([{
    name: '用户统计',
    data: summaryData
  }])
  fs.writeFileSync(path.join(__dirname, 'stats-data.xlsx'), buffer)
}

async function run() {
  try {
    await exportData()
  } catch (error) {
    console.log(error)
  }
  console.log('Done!')
  process.exit()
}

setTimeout(run, 2000)