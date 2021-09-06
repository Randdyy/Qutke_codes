function say(who){
    console.log(who+'say')
}

Function.prototype.before = function(callback){
    return (...args)=>{
        callback();
        this(...args);
    }
}

let fn = say.before(function(){
    console.log('before say')
})
// fn();


function speak(who){
    console.log(who+'speak')
}

let fn2 = speak.before(function(){
    console.log('before speak')
})
// fn2('phoenix')



let arr= [1,3,2]
let oldPush = Array.prototype.push;

// push = function(arr,...args){
//     console.log('调用 push 方法')
//     oldPush.call(arr,...args)
// }

Array.prototype.push = function(...args){
    console.log('调用 push 方法')
    oldPush.call(this,...args)
}

arr.push(4)
console.log(arr)

// let arr = [1, 2, 3]
// let oldPush = Array.prototype.push
// Array.prototype.push = function(...args) {
//   console.log('push push push')
//   oldPush.call(this, ...args)
// }
// arr.push(4,4,5)