let fs = require("fs");

fs.open("/Users/chentianbo/Public/learn_node/node_scripts/fs/1.txt", "r", function (err, fd) {
    if(err){
        console.log(err)
    }
  console.log('fd'+fd);
  let buffer = Buffer.alloc(3);
  // fd 是文件描述
  fs.read(fd, buffer, 0, 3, 0, function (err, bytesRead) {
    console.log('bytesRead:'+bytesRead);
  });
});


fs.open('/Users/chentianbo/Public/learn_node/node_scripts/fs/3.txt','w',function(err,fd){
    let buffer = Buffer.from('幽鬼');

    fs.write(fd,buffer,0,6,0,function(err,written){

    })
})