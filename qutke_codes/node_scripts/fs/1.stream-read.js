let fs = require("fs");

let path = require("path");

let ReadStream = require('./ReadStream')
let filepath = path.resolve(__dirname, "1.txt");

// let rs = fs.createReadStream(filepath, {
//   flags: "r",
//   highWaterMark: 2,
//   start: 0,
//   end: 100,
//   autoCLose: true,
// });

let rs = new ReadStream(filepath, {
    flags: "r",
    highWaterMark: 2,
    start: 0,
    end: 100,
    autoCLose: true,
  });
  

let arr = [];

rs.on("open", function (fd) {
  console.log("open", fd);
});

rs.on("data", function (data) {
  arr.push(data);
  console.log("----data");
  rs.pause();
});

setInterval(() => {
  rs.resume();
}, 100);
rs.on("end", function () {
  console.log(Buffer.concat(arr).toString());
});

rs.on("close", function () {
  console.log("file closed");
});

rs.on("error", function (error) {
  console.log(error);
});
// rs.close()
