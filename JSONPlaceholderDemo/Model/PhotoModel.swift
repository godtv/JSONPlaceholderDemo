 //  PhotoModel.swift
//  JSONPlaceholderDemo
//
//  Created by ko on 2021/1/23.
//

import Foundation
import ObjectMapper

struct PhotoModel: Mappable {
    var albumId: Int!
    var id: Int!
    var title: String!
    var url: String!
    var thumbnailUrl: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        albumId <- map["albumId"]
        id <- map["id"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <-  map["thumbnailUrl"]
    }
}
