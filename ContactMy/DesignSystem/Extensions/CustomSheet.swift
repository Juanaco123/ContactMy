//
//  CustomSheet.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 17/07/25.
//

import SwiftUI


private struct HeighPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = 0.0
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = max(value, nextValue())
  }
}

extension View {
  func adaptiveSheet<Content: View>(
    isPresented: Binding<Bool>,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder sheetContent: @escaping () -> Content
  ) -> some View {
    sheet(isPresented: isPresented, onDismiss: { onDismiss?() }) {
      AdaptativeSheet(
        onDismiss: { onDismiss?() },
        sheetContent: sheetContent
      )
    }
  }
}

struct AdaptativeSheet<SheetContent: View>: View {
  @Environment(\.dismiss) private var dismiss
  @State private var contentHeight: CGFloat = .zero
  
  private let onDismiss: () -> Void
  private let sheetContent: SheetContent
  
  init(
    onDismiss: @escaping () -> Void,
    @ViewBuilder sheetContent: () -> SheetContent,
  ) {
    self.onDismiss = onDismiss
    self.sheetContent = sheetContent()
  }
  
  var body: some View {
    VStack {
      sheetContent
    }
    .background {
      GeometryReader { proxy in
        Color.clear
          .preference(key: HeighPreferenceKey.self, value: proxy.size.height)
      }
    }
    .onPreferenceChange(HeighPreferenceKey.self) { newHeight in
      contentHeight = newHeight
    }
    .presentationDetents([.height(contentHeight)])
    .onDisappear(perform: onDismiss)
  }
}
