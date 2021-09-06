let fs = require('fs')

fs.readFile('./1.txt',function(err,data){
    if(err){
        console.log(err)
    }
    fs.writeFile('./2.txt',data,function(err){
        console.log(err)
    })

})