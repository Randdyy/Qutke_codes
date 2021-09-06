const fs = require("fs");

let events = {
  arr: [],
  dataSource: [],
  on(callback) {
    this.arr.push(callback);
  },
  emit(data) {
    this.dataSource.push(data);
    this.arr.forEach((fn) => fn(this.dataSource));
  },
};

events.on(function (result) {
  if (result.length === 2) {
    console.log("订阅", result);
  }
});

fs.readFile("./aaa.txt", "utf8", function (err, data) {
  events.emit(data);
});

fs.readFile("./bbb.txt", "utf8", function (err, data) {
  events.emit(data);
});
