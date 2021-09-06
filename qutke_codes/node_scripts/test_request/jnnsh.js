const axios = require("axios");
const path = require("path");
const fs = require("fs");
// const filePath = "/Users/chentianbo/Des ktop"  //希望把文件下载到哪里
 
　
async function testGET(){
// 　　if (!fs.existsSync(filePath)) {
// 　　　　fs.mkdirSync(filepath)
// 　　}
　　/* name是生成的文件的文件名，自定义，比如，我希望产生的文件名为test.pdf,那么name='test.pdf' */
    //  name = 'test.txt'
//   　 const mypath = path.resolve(filePath, name)
//    　const writer = fs.createWriteStream(mypath)

   　let { data } = await axios({
     　　url: 'https://www.baidu.com/', //需要访问的资源链接
     　　method: "GET",
     timeout: 10000,
    //  　　responseType: "stream",
    //  　　params: param //需要传的参数
 　 })
 .catch(error => {
    console.error(error)
 })
    console.log(data)
}　

testGET()