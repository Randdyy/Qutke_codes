let fs = require("fs");
let EventEmitter = require("events");
class ReadStream extends EventEmitter {
  constructor(path, options = {}) {
    super();
    this.path = path;
    this.flags = options.flags || "r";
    this.highWaterMark = options.highWaterMark || 64 * 1024;
    this.start = options.start || 0;
    this.end = options.end || undefined;
    this.autoClose = options.autoClose || true;
    this.offset = this.start;

    // 状态 是否需要继续读取 flowing
    this.flowing = false;
    // 1.默认会先打开文件 触发 open 事件
    this.open();
    // 2.监控用户有没有监听 data 事件 如果有开始读取 emit('data')
    this.on("newListener", (type) => {
      if (type === "data") {
        this.flowing = true;
        this.read();
      }

      //   console.log(type);
    });
    // 3.如果当前 flowing 为 true 继续读取

    // 4.如果读取不到内容 触发 end 和 close
  }
  destroy(err) {
    if (err) {
      this.emit("error", err);
    }
    if (this.autoClose) {
      if (typeof this.fd == "number") {
        fs.close(this.fd, () => {
          this.emit("close");
        });
      }
    }
  }
  open() {
    fs.open(this.path, this.flags, (err, fd) => {
      if (err) {
        //   console.log(this)

        return this.destroy(err);
      }
      this.fd = fd;
      this.emit("open", this.fd);
    });
  }
  read() {
    if (typeof this.fd !== "number") {
      return this.once("open", this.read);
    }
    // console.log(this.fd);
    let buffer = Buffer.alloc(this.highWaterMark);
    fs.read(this.fd,buffer,0,this.highWaterMark,this.offset,(err, byteRead) => {
        if (err) {
          return this.destroy();
        }
        this.offset += byteRead;
        if (!byteRead) {
            // this.emit('data',buffer.slice(0,byteRead))
          return this.emit("end");
        }else{
            this.emit('data',buffer.slice(0,byteRead))
        }
        if (this.flowing) {
          this.read();
        }
      }
    );
  }
  pause(){
    this.flowing = false
  }
  resume(){
      if(!this.flowing){
        this.flowing = true
        this.read()
      }
      
  }
}

module.exports = ReadStream;
