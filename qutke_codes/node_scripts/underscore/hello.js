const _ = require('underscore')

var obj = {a:1,b:2,c:3}
var result = _.map(obj, (v,k) => 100 + v + k)
console.log(result)


var Say_hello = function(name){

    console.log("hello"+ name)
}

var Say_no = function(name){


    console.log("NO!"+name)
}

var Hello ={
    hello :Say_hello,
    No : Say_no
}

module.exports = Hello
