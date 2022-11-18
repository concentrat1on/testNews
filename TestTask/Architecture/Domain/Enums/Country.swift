//
//  Country.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import Foundation

enum Country: String, CaseIterable {
    
    case notSelected = "Not Selected"
    case ae = "United Arab Emirates"
    case ar = "Argentina"
    case at = "Austria"
    case au = "Australia"
    case be = "Belgium"
    case bg = "Bulgaria"
    case br = "Brazil"
    case ca = "Canada"
    case ch = "Switzerland"
    case cn = "China"
    case co = "Colombia"
    case cu = "Cuba"
    case cz = "Czechia"
    case de = "Germany"
    case eg = "Egypt"
    case fr = "France"
    case _gb = "United Kingdom"
    case gr = "Greece"
    case hk = "Hong Kong"
    case hu = "Hungary"
    case _id = "Indonesia"
    case ie = "Ireland"
    case il = "Israel"
    case _in = "India"
    case it = "Italy"
    case jp = "Japan"
    case kr = "South Korea"
    case lt = "Lithuania"
    case lv = "Latvia"
    case ma = "Morocco"
    case mx = "Mexico"
    case my = "Malaysia"
    case ng = "Nigeria"
    case nl = "Netherlands"
    case no = "Norway"
    case nz = "New Zealand"
    case ph = "Philippines"
    case pl = "Poland"
    case pt = "Portugal"
    case ro = "Romania"
    case rs = "Serbia"
    case ru = "Russia"
    case sa = "South Africa"
    case se = "Sweden"
    case sg = "Singapore"
    case si = "Slovenia"
    case sk = "Slovakia"
    case th = "Thailand"
    case tr = "Turkey"
    case tw = "Taiwan"
    case ua = "Ukraine"
    case _us = "United States"
    case ve = "Venezuela"
    
    var shorten: String {
        switch self {
        case .notSelected:
            return ""
        case .ae:
            return "ae"
        case .ar:
            return "ar"
        case .at:
            return "at"
        case .au:
            return "au"
        case .be:
            return "be"
        case .bg:
            return "bg"
        case .br:
            return "br"
        case .ca:
            return "ca"
        case .ch:
            return "ch"
        case .cn:
            return "cn"
        case .co:
            return "co"
        case .cu:
            return "cu"
        case .cz:
            return "cz"
        case .de:
            return "de"
        case .eg:
            return "eg"
        case .fr:
            return "fr"
        case ._gb:
            return "gb"
        case .gr:
            return "gr"
        case .hk:
            return "hk"
        case .hu:
            return "hu"
        case ._id:
            return "id"
        case .ie:
            return "ie"
        case .il:
            return "il"
        case ._in:
            return "in"
        case .it:
            return "it"
        case .jp:
            return "jp"
        case .kr:
            return "kr"
        case .lt:
            return "lt"
        case .lv:
            return "lv"
        case .ma:
            return "ma"
        case .mx:
            return "mx"
        case .my:
            return "my"
        case .ng:
            return "ng"
        case .nl:
            return "nl"
        case .no:
            return "no"
        case .nz:
            return "nz"
        case .ph:
            return "ph"
        case .pl:
            return "pl"
        case .pt:
            return "pt"
        case .ro:
            return "ro"
        case .rs:
            return "rs"
        case .ru:
            return "ru"
        case .sa:
            return "sa"
        case .se:
            return "se"
        case .sg:
            return "sg"
        case .si:
            return "si"
        case .sk:
            return "sk"
        case .th:
            return "th"
        case .tr:
            return "tr"
        case .tw:
            return "tw"
        case .ua:
            return "ua"
        case ._us:
            return "us"
        case .ve:
            return "ve"
        }
    }
}
