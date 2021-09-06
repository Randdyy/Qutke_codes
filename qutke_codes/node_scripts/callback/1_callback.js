function isType(type){
    return function(content){
        console.log(Object.prototype.toString.call(content))
        return Object.prototype.toString.call(content) === `[object ${type}]`

    }
}

// let isString = isType('String')
// let isBoolean = isType('Boolean')



let util = {};
['String','Boolean','Undefined','Number'].forEach((type)=>{
    util[`is${type}`] = isType(type)
})

console.log(util.isString('123'))
console.log(util.isBoolean(false))