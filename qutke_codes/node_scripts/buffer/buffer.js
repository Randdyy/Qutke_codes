
let sum = 0
for (let i=0;i<8;i++){

    sum+=Math.pow(2,i)
}
console.log(sum)


console.log(parseInt('1111',2))

console.log((0x16).toString(10))

let buffer = Buffer.alloc(10)
console.log(buffer)
let buffer1 = Buffer.from('敌法')
console.log(buffer1)



let buffer2 = Buffer.from([0xe6,0x95,0x8c,0xe6,0xb3,0x95])
console.log(buffer2.toString('utf8'))

let buf = Buffer.from('猫')
console.log(buf)
// console.log(1.1.toString())

console.log(0xe7.toString(2))
console.log(0x8c.toString(2))
console.log(0xab.toString(2))
// 00111001 00111000 00110010 00101011

console.log(parseInt('00111001',2))
console.log(parseInt('00111000',2))
console.log(parseInt('00110010',2))
console.log(parseInt('00101011',2))
//57 56 50 43

//base64 编码公开 
let str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
str += str.toLocaleLowerCase()
str += '0123456789+/'

console.log(str[57]+str[56]+str[50]+str[43])


let buffer = Buffer.from([11,12,13])

buffer.forEach(item=>console.log(item))

let newBuffer = buffer.slice(0,3)
console.log(newBuffer)
newBuffer[0] = 100

console.log(newBuffer)