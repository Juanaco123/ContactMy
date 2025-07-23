//
//  Field.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import SwiftUI

struct Field: View {
  @Binding var text: String
  
  var placeholder: String
  var action: () -> Void = {}
  
  init(
    text: Binding<String>,
    placeholder: String,
    action: @escaping () -> Void = {},
  ) {
    self._text = text
    self.placeholder = placeholder
    self.action = action
  }
  
  var body: some View {
    VStack {
      HStack {
        Button {
          action()
        } label: {
          HStack {
            CMIcon(.systemErase, color: .scarlet)
          }
        }
        
        TagSelectorView()
        
        TextField(placeholder, text: $text)
      }
      .padding(.leading, .space2x)
      .padding(.vertical, .space2x)
      .background(.milk)
      .clipShape(.rect(cornerRadius: .radius10))
    }
  }
}

#Preview {
  Field(text: .constant(""), placeholder: Constants.AddContact.addNumberPlaceholder.rawValue) {}
}
