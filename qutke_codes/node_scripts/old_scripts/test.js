let oracle = require('oracle')

let oraconfig = {

    hostname: "foftest.cltv2qruve9e.rds.cn-north-1.amazonaws.com.cn",

    port: 1521,
  
    database: "orcl",    // oracle的SID
  
    user: "ftuser",    // 登录oracle的用户名
  
    password: "ftuser#jinsapr" // 请换为实际密码
    
}

oracle.connect(oraconfig, function(err, connection) {

    if (err) {
  
      console.log("Fail to connect oracle:", err);
  
      return;
  
    }
    connection.execute("SELECT * FROM ftuser.stock_style", [5], function(err, results) {

        if (err) {
    
          console.log("Fail to query table:", err);
    
          return;
    
        }
        console.log(results)
        console.log(JSON.parse(results));
    
        connection.close();
    
      });
    
    });