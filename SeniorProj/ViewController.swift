//
//  ViewController.swift
//  SeniorProj
//
//  Created by 2ndGen on 1/12/21.
//











// NOTE:



// AFTER AN UPDATE WE WILL NO LONGER BE USING THIS FILE, BUT WE WILL KEEP IT FOR REFERENCE
// AS THIS CODE IS FOR A WORKING NFC IMPLEMENTATION. WE NOW USE FIRSTVIEWCONTROLLER


















import UIKit
import CoreNFC
import NFCReaderWriter
import Eureka

class ViewController: UIViewController, NFCReaderDelegate {
    @IBOutlet weak var msg: UITextField!
    
    
    func reader(_ session: NFCReader, didInvalidateWithError error: Error) {
        //
    }
    
    let readerWriter = NFCReaderWriter.sharedInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print("Attempting to call...")
        DispatchQueue.main.async {
          
            /*
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "X") as! MyFormViewController
            self.present(nextViewController, animated:true, completion:nil)*/
            
            
        }
       
    }

    @IBAction func ClickedButton(_ sender: Any) {
        
        readerWriter.newWriterSession(with: self, isLegacy: true, invalidateAfterFirstRead: true, alertMessage: "Please go near the Raspberry Pi")
        readerWriter.begin()
        
    }
    
    // implement NFCReaderDelegate to write data to NFC chip
    func reader(_ session: NFCReader, didDetect tags: [NFCNDEFTag]) {
          // here for write test data
        
        DispatchQueue.main.async {

        var payloadData = Data([0x02])
        print(self.msg.text!)
        let myData = "X%"+self.msg.text!+"%X";
        let urls = [myData]
        payloadData.append(urls[Int.random(in: 0..<urls.count)].data(using: .utf8)!)

        let payload = NFCNDEFPayload.init(
          format: NFCTypeNameFormat.nfcWellKnown,
          type: "U".data(using: .utf8)!,
          identifier: Data.init(count: 0),
          payload: payloadData,
          chunkSize: 0)

        let message = NFCNDEFMessage(records: [payload])

            self.readerWriter.write(message, to: tags.first!) { (error) in
            if let err = error {
                print("ERR:\(err)")
            } else {
                print("write success")
            }
            self.readerWriter.end()
         }
    }
    }
    
}

