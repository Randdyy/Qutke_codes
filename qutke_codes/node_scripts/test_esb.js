const axios = require('axios')
const moment = require('moment')

const url = 'http://32.114.82.100' // todo
    const day = moment()
    const msgDate = day.format('YYYYMMDD')
    const msgTime = day.format('HHmmssSSS')
    const params = {
      Transaction: {
        Header: {
          sysHeader: {
            msgId: '', // todo
            serviceCd: 'P00001005466', // todo
            operation: 'MBT052', // todo
            clientCd: '', // todo
            serverCd: '', // todo
            bizId: '', // todo
            bizType: '',
            orgCode: '',
            resCode: '',
            resText: '',
            bizResCode: '',
            bizResText: '',
            ver: '',
            authId: '248', // todo
            authPara: '',
            authContext: '',
            pinIndex: '',
            pinValue: '',
          },
        },
        Body: {
          request: {
            bizHeader: {
              tran_code: '30003',
            },
            bizBody: {
              capital_account: '', // todo
              account_code: '', // todo
              asset_no: '', // todo
              combi_no: '', // todo
            },
          },
        },
      },
    }

console.log(msgDate,msgTime)
console.log(Math.floor(Math.random()*10000))