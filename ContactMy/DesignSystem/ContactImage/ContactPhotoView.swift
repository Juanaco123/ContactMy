//
//  ContactPhotoView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import PhotosUI

struct ContactPhotoView: View {
  @Binding var selectedImage: UIImage?
  @StateObject private var photoSelector: PhotoSelector = PhotoSelector()
  
  private var initialImage: UIImage?
  
  private var photo: UIImage? {
    photoSelector.selectedImage ?? initialImage
  }
  
  // MARK: - Constant
  private let size: CGFloat = 142.0
  
  init(selectedImage: Binding<UIImage?>, initialImage: UIImage? = nil) {
    self._selectedImage = selectedImage
    self.initialImage = initialImage
  }
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      
      photoView(photo)
      
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
    .onChange(of: photo) { _, newValue in
      selectedImage = newValue
    }
  }
  
  @ViewBuilder
  private func photoView(_ uiPhoto: UIImage?) -> some View {
    if let photo = uiPhoto {
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
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ContactPhotoView(selectedImage: .constant(UIImage()))
}
