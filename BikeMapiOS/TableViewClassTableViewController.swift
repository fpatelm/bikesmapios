//
//  TableViewClassTableViewController.swift
//  BikeMapiOS
//
//  Created by Faizal Patel on 6/12/17.
//  Copyright © 2017 fpatel. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class TableViewClassTableViewController: UITableViewController {
    var items:[String] = []
    let cellReuseIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: "https://feeds.citibikenyc.com/stations/stations.json") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            
            // urlRequest.addValue("apiKey", forHTTPHeaderField: "38440d36615d46c21c37e5e4cfb487f6a17c9e3c")
            
            //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
         
            
            Alamofire.request(urlRequest).responseArray( keyPath: "stationBeanList",completionHandler: { (response: DataResponse<[ContractResponse]>) in
                let forecastArray = response.result.value
                
     
                
                if let forecastArray = forecastArray {
                    for forecast in forecastArray {
                        print(forecast.name ?? "")
                        self.items.append(forecast.name!)
                        
                    }
                    
                    for uu in self.items {
                        print(uu, "")
                    }
                    //reload the data
                    self.tableView.reloadData()
                   
                    
                }
            })
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        // Configure the cell...
        if(items.count > 0){
            cell.textLabel?.text = self.items[indexPath.row]
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
