let oracledb = require('oracledb')

let query = function(sql,callback){
    oracledb.getConnection(
        {
            user:'ftuser',
            password:'ftuser#jinsapr',
            connectString:'foftest.cltv2qruve9e.rds.cn-north-1.amazonaws.com.cn:1521/orcl'
        },
        function (err, connection)
        {
            if (err)
            {
                console.error(err.message);
                return;
            }else{
                console.log("连接成功");
            }
            connection.execute(sql, [], function (err, result)
            {
                if (err)
                {
                    console.error(err.message);
                    doRelease(connection);
                    return;
                }
                console.log(result.metaData);
                callback(result.rows.map((v)=>
                    {
                        return result.metaData.reduce((p, key, i)=>
                        {
                            p[key.name] = v[i];
                            return p;
                        }, {})
                    }));
                doRelease(connection);
            });
        }
    );
}

function doRelease(connection) {
    connection.close(
        function(err) {
            if (err)
                console.error(err.message);
        });
}
 
exports.query = query;
