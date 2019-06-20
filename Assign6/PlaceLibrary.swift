//  Assign6
//
//  Created by Nathan Nelson
//Copyright 2018 Nathan Nelson
//I give permision to Dr.Lindquist and any of his assistants to review and test this code as per the syllabus agreement
//@author Nathan Nelson, Mailto:nnelson9@asu.edu
//@version
//
import Foundation
public class PlaceLibrary{
    var library = [PlaceDescription]()
    

    public init(place: PlaceDescription){
        library.append(place)
        
    }
    public func getplace( num: Int)->PlaceDescription{
        return library[num]
    }

}
