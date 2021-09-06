const Fund = require('../models').Fund


async function run() {
  await Fund.remove({ _id: { $in: ['5af516b56cb986003fb7cf3d',
  '5bd02d9ddbce8c14416b20d0',
  '5bd182b601ff781527d7825c',
  '5bd1820af7305e151b00208e',
  '5bd02d9ddbce8c14416b20cf',
  '5bd02d9ddbce8c14416b20d1'] }})
  console.log('Remove Done!')

  process.exit()
}

setTimeout(run, 2000)
