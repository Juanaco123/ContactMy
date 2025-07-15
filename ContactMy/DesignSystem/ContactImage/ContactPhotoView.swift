//
//  ContactPhotoView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import PhotosUI

struct ContactPhotoView: View {
  @StateObject private var photoSelector: PhotoSelector = PhotoSelector()
  
  // MARK: - Constant
  private let size: CGFloat = 142.0
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      if let photo = photoSelector.selectedImage {
        Image(uiImage: photo)
          .resizable()
          .scaledToFill()
          .clipShape(.circle)
          .frame(width: size, height: size)
      } else {
        Circle()
          .fill(.metal)
          .frame(width: size, height: size)
      }
      
      PhotosPicker(
        selection: $photoSelector.imageStorage,
        matching: .images,
        photoLibrary: .shared()
      ) {
        CMIcon(.systemCamera)
          .padding(.space2x)
          .background {
            Circle()
              .fill(.platinum)
          }
      }
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ContactPhotoView()
}
