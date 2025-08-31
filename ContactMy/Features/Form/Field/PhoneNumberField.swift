//
//  PhoneNumberField.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import SwiftUI

struct PhoneNumberField: View {
  @Binding var text: String
  @Binding var tag: Tags
  
  var action: () -> Void = {}
  
  init(
    tag: Binding<Tags>,
    text: Binding<String>,
    action: @escaping () -> Void = {},
  ) {
    self._tag = tag
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
        
        TagSelectorView(tag: $tag)
        
        TextField(
          Constants.AddContact.addNumberPlaceholder,
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
  PhoneNumberField(
    tag: .constant(.personal),
    text: .constant("")
  ) {
  }
}
