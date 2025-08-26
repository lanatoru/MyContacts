//
//  ViewController.swift
//  MyContacts
//
//  Created by Yuliya Masalkina on 24.08.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var newContact = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveButton(_ sender: Any) {
        let contactName = nameTextField.text!
        let contactSurname = surnameTextField.text!
        let contactPhone = phoneTextField.text!
        
         newContact = Contact(name: contactName, surname: contactSurname, phoneNumber: contactPhone)
        
        do { if let data = UserDefaults.standard.data(forKey: "contactArray") {
            
            var array = try JSONDecoder().decode([Contact].self, from: data)
            
            array.append(newContact)
            
            let encodedData = try JSONEncoder().encode(array)
            
            UserDefaults.standard.set(encodedData, forKey: "contactArray")
            
            //print("contact was saved")
        } else {
            
            let encodedData = try JSONEncoder().encode([newContact])
            
            UserDefaults.standard.set(encodedData, forKey: "contactArray")
        }
            
        } catch {
            print("Unable to encode \(error)")
        }
        
        nameTextField.text = " "
        surnameTextField.text = " "
        phoneTextField.text = " "
    }
    
    
    
}

