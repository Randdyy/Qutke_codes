'use strict';

var fs = require('fs'),
    url = require('url'),
    path = require('path'),
    http = require('http');

// 从命令行参数获取root目录，默认是当前目录
var root = path.resolve(process.argv[2] || '.');
console.log('Static root directory: ' + root);

// 创建服务器
var server = http.createServer(function(request, response){
    // 获得URL的path，类似 /css/bootstrap.css
    var pathname = url.parse(request.url).pathname;
    // 获得对应的本地文件路径，类似 /srv/www/css/bootstrap.css
    var filepath = path.join(root, pathname);
    // 获取文件状态
    // 如果HTTP请求的是目录，则自动在此路径下依次搜索index.html和default.html，
    // 若找到，就返回HTML文件的内容
    var defaultPages = ['index.html', 'default.html'];

    var pageCount = 0;
    function getDefaultPage(){
        if(pageCount === defaultPages.length){
            get404Page();
            return;
        }
        var page = path.join(filepath, defaultPages[pageCount]);
        fs.stat(page, function(err, stats){
            if(err || !stats.isFile()){
                pageCount++;
                getDefaultPage();
            }else{
                get200Page(page);
            }
        });
    };

    function get404Page(){
        // 出错或者文件不存在
        console.log('404 ' + request.url);
        // 发送404响应
        response.writeHead(404);
        response.end('404 Not Found');
    };

    function get200Page(filepath){
        console.log('200 ' + request.url);
        response.writeHead(200);
        fs.createReadStream(filepath).pipe(response);
    }

    fs.stat(filepath, function(err, stats){
        if(err){
            get404Page();
        }else if(stats.isFile()){
            get200Page(filepath);
        }else if(stats.isDirectory()){
            getDefaultPage();
        }
    });
}); 

server.listen(8989);
console.log('Server is running at http://127.0.0.1:8989/');