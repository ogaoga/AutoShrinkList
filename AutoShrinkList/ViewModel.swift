//
//  ViewModel.swift
//  AutoShrinkList
//
//  Created by ogaoga on 2020/05/04.
//  Copyright © 2020 ogaoga.org. All rights reserved.
//

import UIKit

class ViewModel: ObservableObject {
  
  @Published var searchText = ""
  @Published var keyboardHeight: CGFloat = 0.0

  // Sample data
  var items: [String] {
    get {
      (0..<100)
        .map { "\($0)" }
        .filter { searchText.isEmpty ? true : $0.contains(searchText) }
    }
  }

  // Register notification
  func onAppear() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow(_:)),
                                           name: UIResponder.keyboardDidShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide(_:)),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }

  // Unregister notification
  func onDisappear() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    if let userInfo = notification.userInfo as? [String: Any],
      let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      self.keyboardHeight = keyboardInfo.cgRectValue.size.height
    }
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    self.keyboardHeight = .zero
  }
}
