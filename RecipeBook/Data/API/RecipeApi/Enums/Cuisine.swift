//
//  Cusine.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

enum Cuisine: String, CaseIterable, Codable, DisplayNamable {
    case african = "African"
    case asian = "Asian"
    case american = "American"
    case british = "British"
    case cajun = "Cajun"
    case caribbean = "Caribbean"
    case chinese = "Chinese"
    case easternEuropean = "Eastern European"
    case european = "European"
    case french = "French"
    case ferman = "German"
    case freek = "Greek"
    case indian = "Indian"
    case irish = "Irish"
    case italian = "Italian"
    case japanese = "Japanese"
    case jewish = "Jewish"
    case korean = "Korean"
    case latinAmerican = "Latin American"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case middleEastern = "Middle Eastern"
    case nordic = "Nordic"
    case southern = "Southern"
    case spanish = "Spanish"
    case thai = "Thai"
    case vietnamese = "Vietnamese"
    
    var displayName: String {
        switch self {
        case .african:  String(localized: "African", table: "Cuisines")
        case .asian:  String(localized: "Asian", table: "Cuisines")
        case .american:  String(localized: "American", table: "Cuisines")
        case .british:  String(localized: "British", table: "Cuisines")
        case .cajun:  String(localized: "Cajun", table: "Cuisines")
        case .caribbean:  String(localized: "Caribbean", table: "Cuisines")
        case .chinese:  String(localized: "Chinese", table: "Cuisines")
        case .easternEuropean:  String(localized: "Eastern European", table: "Cuisines")
        case .european:  String(localized: "European", table: "Cuisines")
        case .french:  String(localized: "French", table: "Cuisines")
        case .ferman:  String(localized: "German", table: "Cuisines")
        case .freek:  String(localized: "Greek", table: "Cuisines")
        case .indian:  String(localized: "Indian", table: "Cuisines")
        case .irish:  String(localized: "Irish", table: "Cuisines")
        case .italian:  String(localized: "Italian", table: "Cuisines")
        case .japanese:  String(localized: "Japanese", table: "Cuisines")
        case .jewish:  String(localized: "Jewish", table: "Cuisines")
        case .korean:  String(localized: "Korean", table: "Cuisines")
        case .latinAmerican:  String(localized: "Latin American", table: "Cuisines")
        case .mediterranean:  String(localized: "Mediterranean", table: "Cuisines")
        case .mexican:  String(localized: "Mexican", table: "Cuisines")
        case .middleEastern:  String(localized: "Middle Eastern", table: "Cuisines")
        case .nordic:  String(localized: "Nordic", table: "Cuisines")
        case .southern:  String(localized: "Southern", table: "Cuisines")
        case .spanish:  String(localized: "Spanish", table: "Cuisines")
        case .thai:  String(localized: "Thai", table: "Cuisines")
        case .vietnamese:  String(localized: "Vietnamese", table: "Cuisines")
        }
    }
}
