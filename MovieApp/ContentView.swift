//
//  ContentView.swift
//  MovieApp
//
//  Created by v.zhokhov on 09.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            Home()
                .navigationBarHidden(true)
        }
//        BookingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
