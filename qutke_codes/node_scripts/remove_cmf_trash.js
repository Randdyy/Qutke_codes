const Fund = require('../models').Fund


async function run() {
  await Fund.remove({ _id: { $in: [
      'f_code',
      'f_code'
  ] }})
  console.log('Remove Done!')

  process.exit()
}

setTimeout(run, 2000)