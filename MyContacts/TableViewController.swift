//
//  TableViewController.swift
//  MyContacts
//
//  Created by Yuliya Masalkina on 24.08.2025.
//

import UIKit

class TableViewController: UITableViewController {
    
    var arrayContacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
                    if let data = UserDefaults.standard.data(forKey: "contactArray") {
                        
                        let array = try JSONDecoder().decode([Contact].self, from: data)
                        
                        arrayContacts = array
                        
                        tableView.reloadData()
                    }
                } catch {
                    print("unable to encode \(error)")
                }
    }
    
    func saveContacts() {
           do {
               
               let encodedata = try JSONEncoder().encode(arrayContacts)
               
               UserDefaults.standard.set(encodedata, forKey: "contactsArray")
               
           } catch {
               print("unable to encode \(error)")
           }
       
           
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayContacts.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        // Configure the cell...
        
        cell.textLabel?.text = arrayContacts[indexPath.row].name + " " + arrayContacts[indexPath.row].surname
        
        cell.detailTextLabel?.text = arrayContacts[indexPath.row].phoneNumber

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as! ViewController
        
        detailVC.newContact = arrayContacts[indexPath.row]
        
        navigationController?.show(detailVC, sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayContacts.remove(at: indexPath.row)
            
            saveContacts()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
