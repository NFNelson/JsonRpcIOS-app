//  Assign6
//
//  Created by Nathan Nelson
//Copyright 2019 Nathan Nelson
//I give permision to Dr.Lindquist and any of his assistants to review and test this code as per the syllabus agreement
//@author Nathan Nelson, Mailto:nnelson9@asu.edu
//
//

import Foundation

public class PlaceDescription{
    var addressTitle: String
    var addressStreet: String
    var elevation: Double
    var latitude: Double
    var longitude: Double
    var name: String
    var description: String
    var category: String
    
    //constructor for creating a new point. only address title and category are going to be use at first, the user will have to input the remaining data by editing them
    public init(addresstitle: String,addressStreet: String,elevation: Double,latitude:Double,longitude:Double,name:String,description: String,Category:String ){
        self.addressTitle = addresstitle
        self.addressStreet = addressStreet
        self.elevation = elevation
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.description = description
        self.category = Category
    }

    
    init (jsonStr: String){
        self.addressTitle = ""
        self.addressStreet = ""
        self.elevation = 0.0
        self.latitude = 0.0
        self.longitude = 0.0
        self.name = ""
        self.description = ""
        self.category = ""
        //constructor for straight json data
        if let data:Data = jsonStr.data(using: String.Encoding.utf8) as Data?{
            do{
                let dict = try JSONSerialization.jsonObject(with: data, options:.mutableContainers) as? [String:Any]
                self.addressTitle = (dict!["address-title"] as? String)!
                self.addressStreet = (dict!["address-street"] as? String)!
                self.elevation = (dict!["elevation"] as? Double)!
                self.latitude = (dict!["latitude"] as? Double)!
                self.longitude = (dict!["longitude"] as? Double)!
                self.name = (dict!["name"] as? String)!
                self.description = (dict!["description"] as? String)!
                self.category = (dict!["category"] as? String)!
               
            } catch {
                print("unable to convert Json to a dictionary")
                
            }
        }
        
    }
    
    //constructor for dict
    public init(dict:[String:Any]){
        
        self.addressTitle = dict["address-title"] == nil ? "unknown" : dict["address-title"] as! String
        self.addressStreet = dict["address-street"] == nil ? "unknown" : dict["address-street"] as! String
        self.elevation = dict["elevation"] == nil ? 0.0 :dict["elevation"] as! Double
        self.latitude = dict["latitude"] == nil ? 0.0 :dict["latitude"] as! Double
        self.longitude = dict["longitude"] == nil ? 0.0 :dict["longitude"] as! Double
        self.name = dict["name"] == nil ? "unknown" : dict["name"] as! String
        self.description = dict["description"] == nil ? "unknown" : dict["description"] as! String
        self.category = dict["category"] == nil ? "unknown" : dict["category"] as! String
        
    }
    //call this to output the json to a readable string
    public func toJsonString() -> String {
        var jsonstring = "";
        let dict:[String : Any] = ["address-title": addressTitle,"address-street": addressStreet,"elevation": elevation,"latitude": latitude,"longitude": longitude,"name": name,"description": description,"category": category ] as [String : Any]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            jsonstring = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        } catch let error as NSError {
            print("unable to convert dictionary to a Json Object with error: \(error)")
        }
        return jsonstring;
        
    }
    public func toDict()-> [String:Any] {
        let dict:[String:Any] = ["address-title": addressTitle,"address-street": addressStreet,"elevation": elevation,"latitude": latitude,"longitude": longitude,"name": name,"description": description,"category": category ] as [String : Any]
        return dict
        
    }
    
    
    
    
    
    
    
    
    
    
}
