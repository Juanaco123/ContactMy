//
//  ImageToData.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 18/07/25.
//

import SwiftUI

extension Image {
  func transformAsData() -> Data {
    let image: Image = self
    let uiImage: UIImage = image.asUIImage()
    return uiImage.jpegData(compressionQuality: 1.0)!
  }
}

extension View {
  func asUIImage() -> UIImage {
    let controller = UIHostingController(rootView: self)
    
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    
    controller.view.backgroundColor = .clear
    
    controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
    windowScene?.keyWindow?.rootViewController?.view.addSubview(controller.view)
    
    let size = controller.sizeThatFits(in: UIScreen().bounds.size)
    controller.view.bounds = CGRect(origin: .zero, size: size)
    controller.view.sizeToFit()
    
    let image = controller.view.asUIImage()
    controller.view.removeFromSuperview()
    return image
  }
}

extension UIView {
  func asUIImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image { rendererContext in
      layer.render(in: rendererContext.cgContext)
    }
  }
}
