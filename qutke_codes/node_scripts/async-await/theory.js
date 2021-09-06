
// console.log('1');

// setTimeout(function() {
//     console.log('2');
//     process.nextTick(function() {
//         console.log('3');
//     })
//     new Promise(function(resolve) {
//         console.log('4');
//         resolve();
//     }).then(function() {
//         console.log('5')
//     })
// })
// process.nextTick(function() {
//     console.log('6');
// })
// new Promise(function(resolve) {
//     console.log('7');
//     resolve();
// }).then(function() {
//     console.log('8')
// })

// setTimeout(function() {
//     console.log('9');
//     process.nextTick(function() {
//         console.log('10');
//     })
//     new Promise(function(resolve) {
//         console.log('11');
//         resolve();
//     }).then(function() {
//         console.log('12')
//     })
// })



// setTimeout(function() {
//     console.log('setTimeout');
// })

// new Promise(function(resolve,reject) {
//     console.log('promise');
//     resolve()
// }).then(function() {
//     console.log('then');
// })

// console.log('console');

function fn(){
    return new Promise((resolve,reject)=>{
        console.log(1)
        // reject('就不想成功')
        resolve(1231)
    }).then((data)=>{
        console.log('succeed!'+data.toString())
    },(err)=>{
        console.log('err:'+err)
    })
}

async function f1(){
    try{
        x = await fn()
        console.log('xxx',x)
    }catch{
        console.log('error')
    }
    
}


f1()
console.log('3')





