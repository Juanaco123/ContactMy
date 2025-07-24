//
//  Field.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import SwiftUI

struct Field: View {
  @Binding var text: String
  
  var action: () -> Void = {}
  
  init(
    text: Binding<String>,
    action: @escaping () -> Void = {},
  ) {
    self._text = text
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
        
        TextField(
          Constants.AddContact.addNumberPlaceholder.rawValue,
          text: $text
        )
      }
      .padding(.leading, .space2x)
      .padding(.vertical, .space2x)
      .background(.milk)
      .clipShape(.rect(cornerRadius: .radius10))
    }
  }
}

#Preview {
  Field(text: .constant("")) {}
}
