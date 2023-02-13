import UIKit

/*
 func dogumGunuMuziginiCal() {
    if dogumGunuBugunMu {
        if !davetliListesi.isEmpty {
            if pastaUzerindekiMumHazırMı {
                call(dogumGunuMuzigiCaldır)
            }
        }
    }
 }
 
 
 // 'guard' ile  --> başarısızsa bloğa girer (if let'in tam tersi)
 
 func dogumGunuMuziginiCal() {
    guard dogumGunuBugunMu else {
        //Bugün kimsenin doğum günü değil.
        return
    }
    
    guard !davetliListesi.isEmpty else {
        //Kimse partide yok
        return
    }
 
    guard pastaUzerindekiMumHazırMı else {
        //Mumlar hazır değil
        return
    }
    
    call(dogumGunuMuzigiCaldır)
 }
 */


func divide(_ number: Double, by divisor: Double) {
    if divisor != 0 {
        let result = number / divisor
        print(result)
    }
}

func divideWithGuard(_ number: Double, by divisor: Double) {
    
    guard divisor != 0 else { return }    //divisor 0 ise
    let result = number / divisor
    print(result)
}


//Guard with Optionals
struct Book {
    var title: String
    var price: Double
    var pages: Int
}

func addBookToLibrary(title: String?, price: Double?, pages: Int?) {
    if let theTitle = title, let thePrice = price, let thePages = pages {
        let book = Book(title: theTitle, price: thePrice, pages: thePages)
    }
}

func addBookToLibraryWithGuard(title: String?, price: Double?, pages: Int?) {
    guard let theTitle = title, let thePrice = price, let thePages = pages else { return }
    
    //guard'da koyduğumuz theTitle, thePrice, thePages'a FONKSIYON ICINDE HER YERDEN ulaşabiliriz. if let'te böyle değildi!
    let book = Book(title: theTitle, price: thePrice, pages: thePages)
}
