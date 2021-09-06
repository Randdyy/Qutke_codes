let fs = require('fs')
// let iconv = require('iconv-lite')


// let buffer = fs.readFileSync('./1.txt')

// let str = iconv.decode(buffer,'gbk')

// console.log(typeof buffer)
// console.log(typeof(str))
// console.log(typeof(str*10))

//去 BOm 头 转码的时候会出现 Mac 好像没有
function stripBom(buffer){
    if(buffer[0] === 0xef &&  buffer[1]=== 0xbb &&  buffer[3] === 0xbf){
        return buffer.slice(3)
    }else{
        return buffer
    }
}

let buffer = fs.readFileSync('./1.txt');
console.log(stripBom(buffer),buffer.length)