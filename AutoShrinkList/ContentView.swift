//
//  ContentView.swift
//  AutoShrinkList
//
//  Created by ogaoga on 2020/05/04.
//  Copyright © 2020 ogaoga.org. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var viewModel = ViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Search number", text: self.$viewModel.searchText)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        List {
          ForEach(self.viewModel.items, id: \.self) {
            Text($0)
          }
        }
        Spacer(minLength: self.viewModel.keyboardHeight)
      }
      .navigationBarTitle(Text("Search"))
    }
    .onAppear() {
      self.viewModel.onAppear()
    }
    .onDisappear() {
      self.viewModel.onDisappear()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
