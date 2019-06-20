//
//  ViewController.swift
//  Assign6
//
//  Created by Nathan Nelson
//Copyright 2018 Nathan Nelson
//I give permision to Dr.Lindquist and any of his assistants to review and test this code as per the syllabus agreement
//@author Nathan Nelson, Mailto:nnelson9@asu.edu
//
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate, UIPickerViewDelegate,
    UITableViewDelegate,UINavigationControllerDelegate,UIPickerViewDataSource {

    
    var placeDescription:[String:PlaceDescription] = [String:PlaceDescription]()
    var selectedPlace:String = "unknown"
    var namesArray:[String] = [String]()
    var el1:Double = 0.0,lon1:Double = 0.0, lat1:Double = 0.0, el2:Double = 0.0, lon2:Double = 0.0, lat2:Double = 0.0
    
    
    
    @IBOutlet weak var TitleVal: UILabel!
    @IBOutlet weak var AddressVal: UILabel!
    @IBOutlet weak var ElevationVal: UILabel!
    @IBOutlet weak var LatitudeVal: UILabel!
    @IBOutlet weak var LongitudeVal: UILabel!
    @IBOutlet weak var DescriptionVal: UILabel!
    @IBOutlet weak var CategoryVal: UILabel!
    
    @IBOutlet weak var DistanceVal: UILabel!
    @IBOutlet weak var BearingVal: UILabel!
    @IBOutlet weak var PlacesPicker: UIPickerView!
    @IBOutlet weak var calcPickerTextField: UITextField!
    
    @IBOutlet weak var calcbutt: UIButton!
    
    
    
    
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
            
        print(placeDescription[selectedPlace]!.addressTitle)
        print(placeDescription.count)
        for stuff in namesArray{
        print(stuff)
        }
            
        TitleVal.text = "\(placeDescription[selectedPlace]!.addressTitle)"
        AddressVal.text = "\(placeDescription[selectedPlace]!.addressStreet)"
        ElevationVal.text = "\(placeDescription[selectedPlace]!.elevation)"
        LatitudeVal.text = "\(placeDescription[selectedPlace]!.latitude)"
        LongitudeVal.text = "\(placeDescription[selectedPlace]!.longitude)"
        DescriptionVal.text = "\(placeDescription[selectedPlace]!.description)"
        CategoryVal.text = "\(placeDescription[selectedPlace]!.category)"
        
        el1 = placeDescription[selectedPlace]!.elevation
        lat1 = placeDescription[selectedPlace]!.latitude
        lon1 = placeDescription[selectedPlace]!.longitude
        
        
        
        
        
        
        
  
        
        PlacesPicker.delegate = self 
        PlacesPicker.removeFromSuperview()
        PlacesPicker.dataSource = self
        
        
        calcPickerTextField.inputView = PlacesPicker
        
        
        selectedPlace =  (namesArray.count > 0) ? namesArray[0] : "unknown unknown"
        let pickedplace:[String] = selectedPlace.components(separatedBy: " ")
        calcPickerTextField.text = pickedplace[0]
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.calcPickerTextField.resignFirstResponder()
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.calcPickerTextField.resignFirstResponder()
        return true
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedPlace = namesArray[row]
        let tokens:[String] = selectedPlace.components(separatedBy: " ")
        self.calcPickerTextField.text = tokens[0]
        self.calcPickerTextField.resignFirstResponder()
    }
    
    func pickerView (_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return namesArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return namesArray.count
    }
   
    
    
        
        @IBAction func calcButtonClicked(_ sender: Any) {
            el2 = placeDescription[selectedPlace]!.elevation
            lat2 = placeDescription[selectedPlace]!.latitude
            lon2 = placeDescription[selectedPlace]!.longitude
            let toRad:Double = 0.017453292519943295769236907684886
            let toDeg:Double = 57.2957795131
            let theta:Double = lon1-lon2
            var Distance:Double = sin(lat1 * toRad) * sin(lat2 * toRad) + cos(lat1 * toRad) * cos(lat2 * toRad) * cos(theta * toRad)
            Distance = acos(Distance)
            Distance = Distance * toDeg
            Distance = Distance*60*1.1515
            Distance = Distance * 1.609344
 
            DistanceVal.text = String(Distance)
           
            let longDiff:Double = (lat1 * toRad - lat2 * toRad)
            let y = sin(longDiff) * cos(lat2*toRad)
            let x = cos(lat1*toRad) * sin(lat2*toRad) - sin(lat1 * toRad) * cos(lat2 * toRad) * cos(longDiff)
            
            BearingVal.text = String(remainder((atan2(y,x) + 360) * toRad, 360.0))
          
            
          
        
    }

    
  

    


}

