//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Berkay Kuzu on 31.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1) Request & Session // Uygulamanın içinden URL adresine gidip istek yollamak.
        // 2) Response & Data // Response veya datayı almak.
        // 3) Parsing & Json Serialization // Aldığımız datayı işlemek.
        
        
        //1) Request & Session
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        
        let session = URLSession.shared
        
        //Closures
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil { // "eğer error boş değilse" bunları yap: hata var mı yok mu kontrol ediyorum, kullanıcıya alert (hata) mesajı oluşturuyorum.
                let alert = UIAlertController(title: "Error!" , message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                //2) Response & Data
                if data != nil { // "eğer data boş değilse" bunları yap:
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        
                        DispatchQueue.main.async {
                         
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                               // print(rates)
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text =  "CAD: \(String(cad))"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(String(gbp))" /* aslında tekrar string yazmana gerek yok, string içine aldığın için otomatik string oluyor. */
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(String(jpy))"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(String(usd))"
                                }
                                
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(String(turkish))" 
                                }
                            }
                            
                        }
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }
     
        
        task.resume()
    }
    
    
}

