//
//  GoRightNowModel.swift
//  GoRightNow
//
//  Created by WOO on 2022/04/12.
//

import Foundation
import SwiftUI

struct Country {
    var name : String // 국가명
    // var iso_alp2 : String // ISO 국가 코드명
    var immigInfo: String // 입국정보, immigration Info
    var immigInfoForKor: String // 한국발 입국자정보, immigration Info For Korean
}


struct GoRightNowModel {
    var textInput: String = "";
}
