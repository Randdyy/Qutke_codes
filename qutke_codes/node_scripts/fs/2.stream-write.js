let  fs = require('fs')


let path  = require('path')

let ws = fs.createWriteStream(path.resolve(__dirname,'22.txt'))


ws.write('hhelo')

ws.write('world')

ws.write('安替妹纸')

ws.end('spector')