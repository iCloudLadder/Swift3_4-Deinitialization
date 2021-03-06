//: Playground - noun: a place where people can play

import UIKit

// >> 析构过程
// 析构器只适用于类类型,当一个类的实例被释放之前,析构器会被立即调用。析构器用关键字 deinit 来标示,类似于构造器要用 init 来标示。



// >> 析构过程原理
/*
    Swift 会自动释放不再需要的实例以释放资源。
    Swift 通过 自动引用计数(ARC) 处理实例的内存管理。
    通常当你的实例被释放时不需要手动地去清理。
    但是,当使用自己的资源时,你可能 需要进行一些额外的清理。例如,如果创建了一个自定义的类来打开一个文件,并写入一些数据,你可能需要在类实例被释放之前手动去关闭该文件。
*/

// **每个类最多只能有一个析构器,而且析构器不带任何参数,语法如下
// deinit { // 执行析构过程 }


/*
    析构器是在实例释放发生前被自动调用。
    析构器是不允许被主动调用的。
    子类继承了父类的析构器,并且在子类析构器实现的最后,父类的析构器会被自动调用。
    即使子类没有提供自己的析构器,父类的析构器也同样会被调用。
*/

// 因为直到实例的析构器被调用时,实例才会被释放,所以析构器可以访问所有请求实例的属性,并且根据那些属性可以修改它的行为





// >> 析构器操作

struct Bank {
    static var  coinsInBank = 10_000  // 拥有的硬币数量
    
    
    // 分发硬币
    static func vendCoins (numberOfCoinsRequested: Int) -> Int {
        // 分发硬币之前检查是否有足够的硬币
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    // 收集硬币
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
    
}


class Player {
    var coinsInPurse: Int
    
    init(coins: Int){
        coinsInPurse = Bank.vendCoins(numberOfCoinsRequested: coins)
    }
    
    func winCoins(coins: Int){
        coinsInPurse += Bank.vendCoins(numberOfCoinsRequested: coins)
    }
    
    deinit {
        Bank.receiveCoins(coins: coinsInPurse)

    }
}

var playerOne: Player? = Player(coins: 100)
print(playerOne!.coinsInPurse)

print("There are now \(Bank.coinsInBank) coins left in the bank")


playerOne?.winCoins(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne?.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne = nil
print("Player has left the game")

print("There are now \(Bank.coinsInBank) coins left in the bank")








