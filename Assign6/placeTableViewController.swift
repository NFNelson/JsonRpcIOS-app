//  Assign4
//
//  Created by Nathan Nelson on 2/12/19.
//Copyright 2018 Nathan Nelson
//I give permision to Dr.Lindquist and any of his assistants to review and test this code as per the syllabus agreement
//@author Nathan Nelson, Mailto:nnelson9@asu.edu
//@version Jan-16-2019
//

import UIKit

class placeTableViewController: UITableViewController {
    //places names array will be used to populate list.
     var placeDescription:[String:PlaceDescription] = [String:PlaceDescription]()
    var names:[String] = [String]()

     var urlString:String = "http://127.0.0.1:8080"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        //self.navigationItem.rightBarButtonItem = self.addStudent()
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(placeTableViewController.addWaypoint))
        self.navigationItem.rightBarButtonItem = addButton
        
        
        //gets places from local file
        //if let path = Bundle.main.path(forResource: "places", ofType: "json"){
            //do {
              //  let jsonStr:String = try String(contentsOfFile:path)
              //  let data:Data = jsonStr.data(using: String.Encoding.utf8)!
              //  let dict:[String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
               // for aPlaceName:String in dict.keys {
                    
                    //make new constructor
                //    let aPlace:PlaceDescription = PlaceDescription(dict: dict[aPlaceName] as! [String:Any])
                //    self.placeDescription[aPlaceName] = aPlace
                //}
   
            //}catch {
            //    print("places.json could not be loaded")
            //}
        //}
        // sorts alphabetically like example, I liked this functionality so I added it in.
        self.urlString = self.setURL()
        self.callGetNamesNUpdatePlacesTable()
        self.names = Array(placeDescription.keys).sorted()
        self.title = "Place List"
        
        //update list

        
    }
    
    
    
    //add a new place to the list of places
    @objc func addWaypoint() {
        print("add Places button clicked")
        

        let promptND = UIAlertController(title: "New Waypoint", message: "Enter place title and category: ", preferredStyle: UIAlertController.Style.alert)

        promptND.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))

        promptND.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) -> Void in
  
            let newPlaceTitle:String = (promptND.textFields?[0].text == "") ?
                "unknown" : (promptND.textFields?[0].text)!
            let newPlaceStreet:String = (promptND.textFields?[1].text == "") ?
                "unknown" : (promptND.textFields?[1].text)!
            
            let newPlaceElevation = Double((promptND.textFields?[2].text == "") ?
                "unknown" : (promptND.textFields?[2].text)!)
            let newPlaceLatitude = Double((promptND.textFields?[3].text == "") ?
                "unknown" : (promptND.textFields?[3].text)!)
            let newPlaceLongitude = Double((promptND.textFields?[4].text == "") ?
                "unknown" : (promptND.textFields?[4].text)!)
            
            let newPlaceName:String = (promptND.textFields?[5].text == "") ?
                "unknown" : (promptND.textFields?[5].text)!
            
            let newPlaceDescription:String = (promptND.textFields?[6].text == "") ?
                "unknown" : (promptND.textFields?[6].text)!
            let newPlaceCategory:String = (promptND.textFields?[7].text == "") ?
                "unknown" : (promptND.textFields?[7].text)!
            //add evertying here
            

            
            //takes in input from the user to create a new waypoint, will only have the new place title and category, on the next view the user will enter in the remaining information
            
            // put them into the thing here
            let aPlace:PlaceDescription = PlaceDescription(addresstitle: newPlaceTitle, addressStreet: newPlaceStreet, elevation: newPlaceElevation ?? 0.0, latitude: newPlaceLatitude ?? 0.0, longitude: newPlaceLongitude ?? 0.0, name: newPlaceName, description: newPlaceDescription, Category: newPlaceCategory)
            
            self.placeDescription[newPlaceName] = aPlace
            self.names = Array(self.placeDescription.keys).sorted()
            
            let aConnect:PlaceCollectionStub = PlaceCollectionStub(urlString: self.urlString)
            let _:Bool = aConnect.add(Place: aPlace,callback: { _,_  in
                print("\(aPlace.name) added as: \(aPlace.toJsonString())")
                self.callGetNamesNUpdatePlacesTable()})
           
            
            
            
        }))
        /*
         "address-title" : "",
         "address-street" : "",
         "elevation" : 4500.0,
         "latitude" : 33.422212,
         "longitude" : -111.173393,
         "name" : "Rogers-Trailhead",
         "image" : "rogerstrough",
         "description" : "Trailhead for hiking to Rogers Canyon Ruins and Reavis Ranch",
         "category" : "Hike"
 */
        
        
        
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "New Place Title"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "New Place Address"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Elevation (numbers only)"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Latitude (numbers only)"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Longitude (numbers only)"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Name"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Description"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Category"
        })
        //add everything here
        present(promptND, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
  
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)

        // Configure the cell...
        //let aPlace = placeDescription[names[indexPath.row]]! as PlaceDescription
        let aPlace = names[indexPath.row]
        let Des = self.placeDescription[aPlace]?.category
        cell.textLabel?.text = aPlace
        cell.detailTextLabel?.text = Des
        

        return cell
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
            // Delete the row from the data source
            let selectedPlace:String = names[indexPath.row]
            print("deleting the Place \(selectedPlace)")
            placeDescription.removeValue(forKey: selectedPlace)
            names = Array(placeDescription.keys)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let aConnect:PlaceCollectionStub = PlaceCollectionStub(urlString: urlString)
            let _:Bool = aConnect.remove(PlaceName: selectedPlace,callback: { _,_  in
                self.callGetNamesNUpdatePlacesTable()
            })
            
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

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "PlaceDetail" {
            let viewController:ViewController = segue.destination as! ViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            viewController.placeDescription = self.placeDescription
            viewController.selectedPlace = self.names[indexPath.row]
            viewController.namesArray = names
            //pass over place descriptions
        }
 
    }
    
    
    
    
    //this goes to the other view controller
    func setURL () -> String {
        var serverhost:String = "localhost"
        var jsonrpcport:String = "8080"
        var serverprotocol:String = "http"
        // access and log all of the app settings from the settings bundle resource
        if let path = Bundle.main.path(forResource: "ServerInfo", ofType: "plist"){
            // defaults
            if let dict = NSDictionary(contentsOfFile: path) as? [String:AnyObject] {
                serverhost = (dict["server_host"] as? String)!
                jsonrpcport = (dict["jsonrpc_port"] as? String)!
                serverprotocol = (dict["server_protocol"] as? String)!
            }
        }
        print("setURL returning: \(serverprotocol)://\(serverhost):\(jsonrpcport)")
        return "\(serverprotocol)://\(serverhost):\(jsonrpcport)"
    }
    
    //populates the inital list
    func callGetNamesNUpdatePlacesTable() {
        let aConnect:PlaceCollectionStub = PlaceCollectionStub(urlString: urlString)
        let _:Bool = aConnect.getNames(callback: { (res: String, err: String?) -> Void in
            if err != nil {
                NSLog(err!)
            }else{
                NSLog(res)
                if let data: Data = res.data(using: String.Encoding.utf8){
                    do{
                        let dict = try JSONSerialization.jsonObject(with: data,options:.mutableContainers) as?[String:AnyObject]
                        self.names = (dict!["result"] as? [String])!
                        //names is now an array of sorted json objects
                        self.names = Array(self.names).sorted()
                    
                        
                        //refresh list
                        self.tableView.reloadData()
                        var i:Int = 0
                        for aPlaceName in self.names{
                            self.callGetNPopulatUIFields(aPlaceName)
                            i=i+1
                        }
                        
                        
                        
                    } catch {
                        print("unable to convert to dictionary")
                    }
                }
                
            }
        })
    }

    func callGetNPopulatUIFields(_ name: String){
        let aConnect:PlaceCollectionStub = PlaceCollectionStub(urlString: urlString)
        let _:Bool = aConnect.get(name: name, callback: { (res: String, err: String?) -> Void in
            if err != nil {
                NSLog(err!)
            }else{
                NSLog(res)
                if let data: Data = res.data(using: String.Encoding.utf8){
                    do{
                        let dict = try JSONSerialization.jsonObject(with: data,options:.mutableContainers) as?[String:AnyObject]
                        let aDict:[String:AnyObject] = (dict!["result"] as? [String:AnyObject])!
                        let aPlace:PlaceDescription = PlaceDescription(dict: aDict)
                        
                        self.placeDescription[name] = aPlace
                
                    } catch {
                        NSLog("unable to convert to dictionary")
                    }
                }
            }
        })
    }
    
    

}
