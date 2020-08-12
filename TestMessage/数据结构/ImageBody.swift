//
//  ImageBody.swift
//  TestMessage
//
//  Created by rolodestar on 2020/8/9.
//  Copyright © 2020 Rolodestar Studio. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class ImageBody:NSObject, MessageBodyProtocol{
    var bodyType: MessageBodyType
    
    var senderUuid: String
    
    var reciverUuid: String
    
    var bagType: BagType
    
    var json: JSON
    
    var uuid: String
    
    var image: UIImage
    
    override var description: String{
        return "[image]-\(image.size)"
    }
    
    func setJsonFromValue() {
        json = JSON()
         json["bagType"].stringValue = bagType.description
        json["uuid"].stringValue = uuid
        json["bodyType"].stringValue = bodyType.description
        
        json["senderUuid"].stringValue = senderUuid
        json["reciverUuid"].stringValue = reciverUuid
        json["image"].stringValue = image.pngData()?.base64EncodedString() ?? ""
        
    }
    
    func setValueFromJson() {
        bagType = BagType(from: json["bagType"].stringValue)
        uuid = json["uuid"].stringValue
        bodyType = MessageBodyType(from: json["bodyType"].stringValue)
        senderUuid = json["senderUuid"].stringValue
        reciverUuid = json["reciverUuid"].stringValue
        let imageD = Data(base64Encoded:  json["image"].stringValue) ?? Data()
        image = UIImage(data: imageD) ?? UIImage()
        
    }
    override init(){
        
        bagType = .body
        bodyType = .image
        senderUuid = ""
        reciverUuid = ""
        uuid = ""
        image = UIImage()
        json = JSON()
        super.init()
        initUUID()
        setJsonFromValue()
        
    }
    init(from senderUUID: String, to reciverUUID: String,image img: UIImage ){
        json = JSON()
        bagType = .body
        bodyType = .image
        senderUuid = senderUUID
        reciverUuid = reciverUUID
        uuid = ""
        image = img
        super.init()
        initUUID()
        setJsonFromValue()
    }
    
    
}
