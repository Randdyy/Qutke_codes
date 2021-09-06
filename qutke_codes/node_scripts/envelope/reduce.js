// 求和
// let r= [1,2,3,4,5].reduce(function (previousValue, currentValue, currentIndex, arr){
//     return previousValue + currentValue
// },1)

// let rr = [
//     {score:100},
//     {score:200},
//     {score:300},
//     {score:500},
// ].reduce((previousValue, currentValue, currentIndex, arr)=>{
//     if(arr.length-1 == currentIndex){
//         return (previousValue + currentValue.score) /arr.length
//     }
//     return previousValue + currentValue.score
// },0)
// console.log(rr)

function flatten(arr){
    return arr.reduce((previousValue, currentValue, currentIndex, arr)=>{
        if (Array.isArray(previousValue)){
            return previousValue.concat(flatten(currentValue))
        }else{
            previousValue.push(currentValue)
        }
        return previousValue

    },[])
}
console.log(flatten([1,[2,[3,[4,[5]]]]]))