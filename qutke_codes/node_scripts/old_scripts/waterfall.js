const async = require('async')


 
// async.waterfall([
//     function(callback){
//         console.log(1);
//         callback(null,1); //如果有error异常处理，否则向下一个函数传递参数 1
//     },
//     function(n, callback){ //接受参数1
//         console.log(n);  //n=1
//         callback(null,2);
//     },
//     function(n, callback){ //接受参数2
//         console.log(n);n=2
//     }
// ], function(err, results){
//     //如果有error则执行此处函数
//    console.log('异常处理');
// });






function1 = function(callback){
    console.log(1)
    callback(null,'first')
}

function2 = function(arg2,callback){
    console.log(arg2)
    callback(null,'second')
}

function3 = function(arg3,callback){
    console.log('asdfasf'+arg3.toString())
}


async.waterfall([
    function1,
    function2,
    function3,

],function(err,result){
    if(err){
        console.log(err)
        return(err)
    }
    else{
        console.log(result)
        return(result)
    }

}
)