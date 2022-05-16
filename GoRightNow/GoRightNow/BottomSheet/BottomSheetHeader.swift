//
// Created by jeonggyunyun on 2022/05/15.
//

import SwiftUI
import BottomSheetSwiftUI

struct BottomSheetHeader: View {
    @State private var searchText: String = ""
    @ObservedObject var bottomSheetView: BottomSheetModelView
    @ObservedObject var modelView: GoRightNowModelView

    var body: some View {
        SearchBar(text: $modelView.model.textInput)
                .onTapGesture {
                    bottomSheetView.position = .middle
                }
    }
}
