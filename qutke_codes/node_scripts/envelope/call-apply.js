function fn() {
    console.log('fn1');
}

// function fn2(){
//     console.log('fn2')
// }

// fn.call.call.call(fn2)
// Function.prototype.call = function(thisValue,...args){

//     if(typeof this.thisValue !== 'object'){
//         thisValue = new Object(thisValue)
//     }
//     let context = this;
//     // Object.defineProperty(thisValue,'f',{

//     //     get(){
//     //         return context
//     //     }
//     // })
//     thisValue.f = context
//     thisValue.f(...args);
//     delete thisValue.f

// }

// call
Function.prototype.call = function (thisValue, ...args) {

    if (typeof this.thisValue !== 'object') {
        thisValue = new Object(thisValue)
    }
    let context = this;
    thisValue.f = context
    Object.defineProperty(thisValue, 'f', {
        enumerable: false,
        get() {
            return context
        }
    })
    thisValue.f(...args);
    delete thisValue.f

}
// apply 和 call 的区别主要在参数上年
Function.prototype.apply = function (thisValue, args) {

    if (typeof this.thisValue !== 'object') {
        thisValue = new Object(thisValue)
    }
    let context = this;
    thisValue.f = context
    Object.defineProperty(thisValue, 'f', {
        enumerable: false,
        get() {
            return context
        }
    })
    thisValue.f(...args);
    delete thisValue.f

}