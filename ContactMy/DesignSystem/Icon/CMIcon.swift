//
//  CMIcon.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 14/07/25.
//

import SwiftUI

struct CMIcon: View {
  let image: ImageResource
  var imageColor: Color
  let width: CGFloat
  let height: CGFloat
  
  init(
    _ image: ImageResource,
    color: Color = .azure,
    width: CGFloat = .space6x,
    height: CGFloat = .space6x,
  ) {
    self.image = image
    self.imageColor = color
    self.width = width
    self.height = height
  }
  
  var body: some View {
    VStack {
      Image(image)
        .renderingMode(.template)
        .resizable()
        .foregroundColor(imageColor)
        .scaledToFit()
    }
    .frame(width: width, height: height)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  CMIcon(.systemAdd)
}
