//
//  PhotoView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 31/08/25.
//

import SwiftUI

struct PhotoView: View {
  let initialPhoto: UIImage?
  @Binding var selectedPhoto: UIImage?
  
  private let size: CGFloat = 142.0
  
  init(
    initialPhoto: UIImage? = nil,
    selectedPhoto: Binding<UIImage?>) {
      self.initialPhoto = initialPhoto
      self._selectedPhoto = selectedPhoto
    }
  
  var body: some View {
    if let photo = selectedPhoto ?? initialPhoto {
      Image(uiImage: photo)
        .resizable()
        .scaledToFill()
        .frame(width: size, height: size)
        .clipShape(.circle)
    } else {
      Circle()
        .fill(.metal)
        .frame(width: size, height: size)
    }
  }
}
