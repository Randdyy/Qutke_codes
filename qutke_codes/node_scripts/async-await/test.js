const fs = require('fs').promises
var readFile = async function (path) {
    console.log(path)
    try {
        let new_path = await fs.readFile(path, 'utf8', (err, data) => {
            if (err) throw err;
            console.log("file1:", data)
            return data.toString()
        });
        console.log("new_path", new_path)
        let content = await fs.readFile(new_path, 'utf8', (err, data) => {
            if (err) throw (err)
            console.log(data)
        });
        return content
    } catch (e) {
        console.log(e)
    }
}

// readFile("/Users/chentianbo/Public/learn_node/node_scripts/async-await/file1.txt").then(data=>{
//     console.log(1,data)
// })


// async function read(){
//     try {
//         let content = await fs.readFile('file1.txt',data=>{
//             console.log(data)
//             return data
//         });
//         let content2 = await fs.readFile(content,data=>{
//             console.log(data)
//             return data
//         });
//         return content2
//     } catch (error) {

//         console.log(error)
//     }
// }

// read().then(data=>{
//     console.log(data.toString())
// })



for (var i = 1; i < 5; i++) {
    setTimeout(() => {
        console.log(i)
    }, 0)
}