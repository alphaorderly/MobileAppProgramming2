//
//  ContentView.swift
//  PublicAPITest
//
//  Created by 권동영 on 2022/05/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(getRoutineList())
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
