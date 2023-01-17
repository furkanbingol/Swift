import UIKit

func myFunct() {
    print("my function")
}

myFunct()

/*--------------------------------------------------------------------*/

func sum(x: Int, y: Int) {                 //void function
    print(x+y)
}

sum(x: 5, y: 6)

/*--------------------------------------------------------------------*/

func sum2(a: Int, b: Int) -> Int {         //returns Int function
    return a+b
}

var result = sum2(a: 10, b: 40)
print(result)

/*--------------------------------------------------------------------*/

func logicFun(a: Int, b: Int) -> Bool {    //returns Bool function
    if(a == b){
        return true
    }
    else{
        return false
    }
}

var isTrue = logicFun(a: 10, b: 20)
print(isTrue)
