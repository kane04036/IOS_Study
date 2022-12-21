//
//  CreditCard.swift
//  CreditCardRecommandApp
//
//  Created by 제임스 on 2022/11/25.
//

import Foundation

struct CreditCard:Codable{
    let id:Int
    let rank:Int
    let name:String
    let cardImageURL:String
    let promotionDetail:PromotionDetail
    let isSelected:Bool? //개발전까지는 nil일거라
    
}

struct PromotionDetail:Codable{
    let companyName:String
    let period:String
    let amount:Int
    let condition:String
    let benefitCondition:String
    let benefitDetail:String
    let benefitDate:String
}
