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
  
  init(selectedImage: Binding<UIImage?>, initialImage: UIImage? = nil) {
    self._selectedImage = selectedImage
    self.initialImage = initialImage
  }
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      
      PhotoView(
        initialPhoto: initialImage,
        selectedPhoto: $photoSelector.selectedImage
      )
      
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
    .onChange(of: photoSelector.selectedImage) { _, newValue in
      selectedImage = newValue
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ContactPhotoView(selectedImage: .constant(UIImage()))
}
