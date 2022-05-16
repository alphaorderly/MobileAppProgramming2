//
// Created by jeonggyunyun on 2022/05/15.
//

import SwiftUI
import BottomSheetSwiftUI

struct BottomSheetHeader: View {
    @State private var searchText: String = ""
    @ObservedObject private var bottomSheetView: BottomSheetModelView;

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: self.$searchText)
        }
//                .foregroundColor(Color(UIColor.secondaryLabel))
//                .padding(.vertical, 8)
//                .padding(.horizontal, 5)
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternaryLabel)))
//                .padding(.bottom)
//                // 검색 시 sheet가 중앙까지 올라옴
//                .onTapGesture {
//                    $bottomSheetView.model.bottomSheetPosition = .middle
//                }

        //TODO 오류수정
    }
}
