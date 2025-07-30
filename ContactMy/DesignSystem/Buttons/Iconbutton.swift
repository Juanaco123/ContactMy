//
//  Iconbutton.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 29/07/25.
//

import SwiftUI

struct IconButton: View {
  var icon: ImageResource
  var action: () -> Void
  
  var body: some View {
    VStack {
      Button {
        action()
      } label: {
        CMIcon(icon)
          .padding(.horizontal, .space4x)
          .padding(.vertical, .space1x)
          .background(Color.platinum)
          .clipShape(.rect(cornerRadius: .radius10))
      }
    }
  }
}

#Preview {
  IconButton(icon: .systemMessage) {}
}
