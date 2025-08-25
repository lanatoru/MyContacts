//
//  ContactViewController.swift
//  MyContacts
//
//  Created by Yuliya Masalkina on 24.08.2025.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneTexField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        let contactName = nameTextField.text!
        let contactSurname = surnameTextField.text!
        let contactPhone = phoneTexField.text!
        
        let newContact = Contact(name: contactName, surname: contactSurname, phoneNumber: contactPhone)
        
        do { if let data = UserDefaults.standard.data(forKey: "contactArray") {
            
            var array = try JSONDecoder().decode([Contact].self, from: data)
            
            array.append(newContact)
            
            let encodedData = try JSONEncoder().encode(array)
            
            UserDefaults.standard.set(encodedData, forKey: "contactArray")
        } else {
            
            let encodedData = try JSONEncoder().encode([contactName])
            
            UserDefaults.standard.set(encodedData, forKey: "contactArray")
        }
            
        } catch {
            print("unable to encode \(error)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
