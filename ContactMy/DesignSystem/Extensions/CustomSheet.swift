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
  func adaptativeSheet<Content: View>(
    isPresented: Binding<Bool>,
    noBackground: Bool = false,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder sheetContent: @escaping () -> Content
  ) -> some View {
    sheet(isPresented: isPresented, onDismiss: { onDismiss?() }) {
      AdaptativeSheet(
        noBackground: noBackground,
        onDismiss: { onDismiss?() },
        sheetContent: sheetContent
      )
    }
  }
}

struct AdaptativeSheet<SheetContent: View>: View {
  @Environment(\.dismiss) private var dismiss
  @State private var contentHeight: CGFloat = .zero
  @State private var noBackground: Bool = false
  
  private let onDismiss: () -> Void
  private let sheetContent: SheetContent
  
  init(
    noBackground: Bool = false,
    onDismiss: @escaping () -> Void,
    @ViewBuilder sheetContent: () -> SheetContent,
  ) {
    self.noBackground = noBackground
    self.onDismiss = onDismiss
    self.sheetContent = sheetContent()
  }
  
  var body: some View {
    VStack {
      sheetContent
        .background {
          if noBackground {
            RemoveBackgroundColor()
          } else {
            Color.clear
          }
        }
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

fileprivate struct RemoveBackgroundColor: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return UIView()
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
    DispatchQueue.main.async {
      uiView.superview?.superview?.backgroundColor = .clear
    }
  }
}
