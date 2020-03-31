import UIKit

var ages = [12,2,3,4]
print(ages)

var name = "Victor"
name.count
"12".count


func findEvenNumbers(_ nums: [Int]) -> Int {
    
    var counter = 0

    for age in ages {
        
        let string = String(age)
        let count = string.count
        if count % 2 == 0 {
            counter += 1
        }
    
    }
    
    return counter
}

print(findEvenNumbers([12,2,3,4]))
