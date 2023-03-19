import UIKit
import Foundation

// OperationQueue, DispatchQueue(GCD) ile benzer iş yapmakta diyebiliriz.
// Ekstra fonksiyonları da var. addDependency() ile operasyonlar arası bağımlılık ekleme gibi.

let mainQueue = OperationQueue.main
let customQueue = OperationQueue()

mainQueue.addOperation {
    let label = UILabel()
    label.backgroundColor = .systemBlue
}

// ------------------------------------------------------------------------------------------------------------------------ //

// Adding dependencies to Operation
let fetchIdOperation = Operation()
let fetchUserPhotoWithIdOperation = Operation()

fetchUserPhotoWithIdOperation.addDependency(fetchIdOperation)    // Dependency-bağımlılık- ekler.
// Önce ID'leri çekeceğiz. ID'ler çekildikten sonra UserPhoto bilgilerini, çekmiş olduğumuz id'ler ile çekeceğiz.
// Don't executed fetchUserPhotoWithIdOperation UNTIL fetchIdOperation completed.

customQueue.addOperation(fetchUserPhotoWithIdOperation)

// ------------------------------------------------------------------------------------------------------------------------ //

// Operation State'lerini checkleyebiliriz.
fetchIdOperation.isReady
fetchIdOperation.isCancelled
fetchIdOperation.isFinished
fetchIdOperation.isExecuting

fetchIdOperation.start()
fetchIdOperation.cancel()

// ------------------------------------------------------------------------------------------------------------------------ //

// Çalışabilecek maximum concurrent operation sayısını verebiliriz.
// Diyelim 40 operations var. 30'u concurrent çalışır. Diğer 10'u, diğerlerinin execute'u bittikten sonra sıra ile çalışır.
customQueue.maxConcurrentOperationCount = 30

customQueue.addOperation {
    // do stuff here
}

// ------------------------------------------------------------------------------------------------------------------------ //

// ### USEFUL NOTE ###
// The most apps are going to be using DispatchQueue. The reason is most logic does not have intricate-karmaşık- dependencies
// that really warrant the use of OperationQueue. OperationQueue is considered to be a bit heavier and actually under the hood
// OperationQueue in fact is IMPLEMENTED in GCD (aka DispatchQueue).
// We can think of OperationQueue as an 'abstraction' on top of DispatchQueue.
