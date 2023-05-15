//
//  BookingViewModel.swift
//  Testigmbi
//
//  Created by EZAZ AHAMD on 09/02/23.
//

import UIKit

class BookingViewModel {
    
    var data = [Listed](){
        didSet{
            eventHandler?(.dataLoaded)
        }
    }
    
    var eventHandler: ((_ event: Event)->Void)?
    
    
    
    
 func Api(param: [String:String]){
        NetworkService.shared.request(type: BookingEndPoint.getResult(param: param), modelType: RootClass.self) { response in
            switch response{
            case .success(let resData):
                self.data = resData.listed ?? [Listed]()
            case .failure(let error):
                // handel Error
                print(error)
                self.eventHandler?(.error)
            }
        }
    }
    
       
}


extension BookingViewModel {
    
    enum Event {
        case dataLoaded
        case error
    }
}
