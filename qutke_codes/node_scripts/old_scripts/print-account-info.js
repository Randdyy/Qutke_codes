const _ = require('lodash')
const managerNameCodeMap = [
  '刁玥',
  '付李艳',
  '高鹏飞',
  '胡永燕',
  '康海荣',
  '沈寅峰',
  '隋华震',
  '姚学康',
  '岳欣颖',
  '朱萌',
  '白岩',
  '曹柳',
  '单佩韦',
  '宫永建',
  '胡朝凤',
  '李树培',
  '李晓杰',
  '刘强',
  '桑永亮',
  '王东川',
  '魏玉波',
  '谢达成',
  '袁作栋',
  '张剑',
  '赵丽明',
  '赵鑫鑫',
  '周武',
  '王志芳',
  '刘诗薇',
  '欧阳政',
  '朱年军',
  '李骊',
  '程威',
  '尚德禹',
  '姜微',
  '胡攸乔',
  '肖桂东',
  '孟德鹏',
  '田鹤',
  '高鹏飞（转债）',
  '非主动管理-SW HK IPO',
  '非主动管理',
  '战略',
  '定增',
  '深圳',
  '深圳-基金',
  '久盈股票',
  '久盈债券'
].reduce((out, name, index) => {
  const qutkeId = _.padStart(`${index + 1}`, 9, 'QK2000000')
  out[name] = qutkeId
  return out
}, {})

Object.keys(managerNameCodeMap).forEach(key => {
  console.log(key, managerNameCodeMap[key])
})