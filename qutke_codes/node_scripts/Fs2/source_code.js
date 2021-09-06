let fs = require('fs')
let path = require('path')

// function rmdir(url,callback){
//     fs.stat(url,function(err,statObj){
//         if(err){
//             console.log('err:'+err)
//         }
//         if(statObj.isDirectory()){
//             fs.readdir(url,function(err,dirs){
//                 dirs = dirs.map(dir=>path.join(url,dir));
//                 let index = 0
//                 if(dirs.length === 0){
//                     return fs.rmdir(url,callback)
//                 }
//                 function done(){
//                     if(++index == dirs.length){
//                         fs.rmdir(url,callback)
//                     }
//                 }
//                 dirs.forEach(dir=>{
//                     rmdir(dir,done)
//                 });
//             })
//         }else{
//             fs.unlink(url,callback)

//         }
//     });
// }
// rmdir('/Users/chentianbo/Documents/Git_projects/my_own_codes/node_scripts/Fs2/a',function(){
//     console.log('remove completed!')
// })

// rmdir('a',function(){
//     console.log('remove completed!')
// })



//promise 版本
// function rmdir(url){
//     return new Promise((resolve,reject)=>{
//         fs.stat(url,function(err,statObj){
//             if(statObj.isFile()){
//                 fs.unlink(url,resolve)
//             }else{
//                 fs.readdir(url,function(err,dirs){
//                     dirs = dirs.map(dir=>path.join(url,dir));
//                     Promise.all(dirs.map(dir=>rmdir(dir))).then(()=>{
//                         fs.rmdir(url,resolve);
//                     })
//                 })
//             }
//         })
//     })
// }


let fs = require('fs').promises

async function rmdir(url){
    let statObj = await fs.stat(url)
        if(statObj.isFile()){
            await fs.unlink(url)
        }else{
            dirs = await fs.readdir(url);
            dirs = dirs.map(dir=>path.join(url,dir));
            await Promise.all(dirs.map(dir=>rmdir(dir)))
            await fs.rmdir(url);
        }

}
rmdir('/Users/chentianbo/Documents/Git_projects/my_own_codes/node_scripts/Fs2/a').then(function(){
    console.log('remove completed!')
})

let king_is_sb = True


if(king_is_sb){
    console.log(1)
}else{
    console.log(2)
}
