var http = require('http');

var server = http.createServer(function(request,response){

    console.log(request.method + ':' + request.url);

    response.writeHead(200,{'Content_type': 'text/html'});

    response.end('<h1>Hello world!</h1>');
    
});


server.listen(8888)

console.log('server of Phoenix is running at http://127.0.0.1:8888')