/**
 * @param {number[]} tree
 * @return {number}
 */
var totalFruit = function(tree) {

    var Trees = tree;
    var TotalFruit = []
    
    for(i=0;i<Trees.length;i++){

        var type_arr = []
        var total = 0

        for(j=i;j<Trees.length;j++){

            if(type_arr.length<2 && !type_arr.includes(Trees[j])){
                console.log("Trees[j]:"+Trees[j])
                type_arr.push(Trees[j]);
                total += 1;
                continue;
                
            }else if(type_arr.includes(Trees[j])){
            
                    total += 1;
                    continue;
            }else{
                    break ;
            }
            }
            TotalFruit.push(total)
            console.log('type_1: '+type_arr[0]+'  '+'type_2: '+type_arr[1]+'   total: ' +total)
            continue;
        }
        console.log('总数:'+Math.max(...TotalFruit))
        console.log(TotalFruit)
    };

totalFruit([3,3,3,1,2,1,1,2,3,3,4])

    
