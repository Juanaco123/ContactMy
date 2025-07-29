//
//  SheetView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 29/07/25.
//

import SwiftUI

private struct SheetHeighPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = 0.0
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = max(value, nextValue())
  }
}

struct SheetScreenConfiguration {
  var leadingText: String
  var trailingText: String
  var leadingAction: () -> Void
  var trailingAction: () -> Void
  
  init(
    leadingText: String,
    trailingText: String,
    leadingAction: @escaping () -> Void = {},
    trailingAction: @escaping () -> Void = {},
  ) {
    self.leadingText = leadingText
    self.trailingText = trailingText
    self.leadingAction = leadingAction
    self.trailingAction = trailingAction
  }
}

protocol SheetView: View {
  associatedtype Content: View
  
  var sheetScreenConfiguration: SheetScreenConfiguration { get }
  var content: Content { get }
}

extension SheetView {
  var body: some View {
    SheetViewContent(sheetScreenConfiguration: sheetScreenConfiguration) {
      content
    }
  }
}

struct SheetViewContent<Content: View>: View {
  var sheetScreenConfiguration: SheetScreenConfiguration
  var content: () -> Content
  
  @State private var navBarHeight: CGFloat = 0.0
  
  var body: some View {
    VStack {
      NavBar(
        leadingText: sheetScreenConfiguration.leadingText,
        trailingText: sheetScreenConfiguration.trailingText,
        leadingAction: { sheetScreenConfiguration.leadingAction() },
        trailingAction: { sheetScreenConfiguration.leadingAction() }
      )
      .zIndex(1)
      
      content()
        .frame(maxWidth: .infinity)
    }
  }
}

private struct NavBar: View {
  var leadingText: String
  var trailingText: String
  var leadingAction: () -> Void
  var trailingAction: () -> Void
  
  init(
    leadingText: String,
    trailingText: String,
    leadingAction: @escaping () -> Void = {},
    trailingAction: @escaping () -> Void = {},
  ) {
    self.leadingText = leadingText
    self.trailingText = trailingText
    self.leadingAction = leadingAction
    self.trailingAction = trailingAction
  }
  
  var body: some View {
    HStack {
      Button {
        leadingAction()
      } label: {
        Text(leadingText)
          .foregroundStyle(.azure)
      }
      
      Spacer()
      
      Button {
        trailingAction()
      } label: {
        Text(trailingText)
          .foregroundStyle(.azure)
      }
    }
    .applyDefaultPadding()
  }
}
