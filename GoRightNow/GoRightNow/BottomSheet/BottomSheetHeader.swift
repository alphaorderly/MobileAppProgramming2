//
// Created by jeonggyunyun on 2022/05/15.
//

import SwiftUI
import BottomSheetSwiftUI

struct BottomSheetHeader: View {
    @ObservedObject var bottomSheetView: BottomSheetModelView
    @ObservedObject var modelView: GoRightNowModelView

    var body: some View {
        SearchBar(text: $modelView.model.textInput, menu:$modelView.model.sideMenu, isEditText: modelView.model.isEditMode)
                .onTapGesture {
                    bottomSheetView.position = .middle
                }
    }
}
