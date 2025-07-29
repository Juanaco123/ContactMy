//
//  ContactCard.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 17/07/25.
//

import SwiftUI

struct ContactCard: View {
  var name: String
  var phone: String
  var photo: Image?
  var action: () -> Void
  
  private let size: CGFloat = 40.0
  
  init(
    name: String,
    phone: String,
    photo: Image? = nil,
    action: @escaping () -> Void,
  ) {
    self.name = name
    self.phone = phone
    self.photo = photo
    self.action = action
  }
  
  var body: some View {
    Button {
      action()
    }
    label: {
      HStack {
        // Photo
        ZStack {
          if let photo = photo {
            photo
              .resizable()
              .scaledToFill()
              .clipShape(.circle)
              .frame(width: size * 1.5, height: size)
          }
          
          if photo == Image(uiImage: UIImage()) {
            Circle()
              .fill(.metal)
              .frame(width: size, height: size)
              .padding(.trailing, .space1x)
          }
        }
        VStack(alignment: .leading, spacing: .space1x) {
          Text(name)
            .font(.title3)
          Text(phone)
        }
        Spacer()
        CMIcon(.systemInfo)
      }
      .contentShape(Rectangle())
      
    }
    .buttonStyle(.plain)
    .frame(maxWidth: .infinity)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ContactCard(
    name: "Juan Camilo Victoria",
    phone: "+1 (123)4678967",
    photo: Image(.systemCamera))
  {}
}
