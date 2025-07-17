//
//  CustomSheet.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 17/07/25.
//

import SwiftUI

extension View {
  func adaptiveSheet<Content: View>(isPresent: Binding<Bool>, @ViewBuilder sheetContent: () -> Content) -> some View {
    modifier(AdaptativeSheetModifier(isPresent: isPresent, sheetContent))
  }
}

struct AdaptativeSheetModifier<SheetContent: View>: ViewModifier {
  @Binding var isPresent: Bool
  @State private var subHeight: CGFloat = .zero
  var sheetContent: SheetContent
  
  init(isPresent: Binding<Bool>, @ViewBuilder _ content: () -> SheetContent) {
    _isPresent = isPresent
    sheetContent = content()
  }
  
  func body(content: Content) -> some View {
    content
      .background {
        sheetContent
          .background {
            GeometryReader { proxy in
              Color.clear
                .task(id: proxy.size.height) {
                  subHeight = proxy.size.height
                }
            }
          }
          .hidden()
      }
      .sheet(isPresented: $isPresent) {
        sheetContent
          .presentationDetents([.height(subHeight)])
      }
      .id(subHeight)
  }
}
