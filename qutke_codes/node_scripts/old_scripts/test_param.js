function isType(type){
    return function (content){

        return Object.prototype.toString.call(content) === `[object ${type}]`
    }
}

let util = {};


['String','Boolean','Undefined'].forEach((type)=>{
 util['is'+type] = isType(type)
})

console.log(util.isString('hello'))
console.log(util.isBoolean(true))
console.log(util.isUndefined())



// var s = new Set(['A', 'B', 'C']);
// s.forEach(function (element, sameElement, set) {
//     console.log(element);
// });
