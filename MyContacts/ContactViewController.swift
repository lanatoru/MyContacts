//
//  ContactViewController.swift
//  MyContacts
//
//  Created by Yuliya Masalkina on 24.08.2025.
//

import UIKit

protocol ContactViewControllerDelegate: AnyObject {
    func didUpdateContact(_ contact: Contact, at index: Int)
}

class ContactViewController: ViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var surnameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    var contact = Contact(name: "", surname: "", phoneNumber: "")// контакт который будем редактировать
    var contactIndex: Int? // его индекс в массиве
    
    weak var delegate: ContactViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //отображаем информацию о контакте сразу при загрузке экрана
        nameText.text = contact.name
        surnameText.text = contact.surname
        phoneText.text = contact.phoneNumber
        
        print("nameText:", nameText ?? "nil")
        print("surnameText:", surnameText ?? "nil")
        print("phoneText:", phoneText ?? "nil")
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        
     // guard var updated = contact, let index = contactIndex else { return }
        
        contact.name = nameText.text ?? ""
        contact.surname = surnameText.text ?? ""
        contact.phoneNumber  = phoneText.text ?? ""
    
        if let index = contactIndex {
                    delegate?.didUpdateContact(contact, at: index)
                }
        navigationController?.popViewController(animated: true)
        
    
        do { if let data = UserDefaults.standard.data(forKey: "contactArray") {
            
            var array = try JSONDecoder().decode([Contact].self, from: data)
            
            array.append(contact)
            
            let encodedData = try JSONEncoder().encode(array)
            
            UserDefaults.standard.set(encodedData, forKey: "contactArray")
        } else {
            
            let encodedData = try JSONEncoder().encode([contact])
            
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
