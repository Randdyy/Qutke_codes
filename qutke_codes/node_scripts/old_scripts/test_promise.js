// const promise = new Promise((resolve, reject) => {
//     console.log(1);
//     resolve('adfsafasdf');
//     console.log(2);
// });
// promise.then((x) => {
//     console.log(3);
//     console.log(x)
    
// });
// console.log(4);




Promise.resolve('12312312313')
  .then(Promise.resolve(3))
  .then(console.log)




setTimeout(()=>{
    console.log('setTimeout')
  })




  let p1 = new Promise((resolve)=>{
    console.log('Promise1')
    resolve('Promise2')
  })


  p1.then((res)=>{
    console.log(res)
  })


  console.log(1)
  
