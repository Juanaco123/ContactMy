//
//  TagSelectorView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import SwiftUI
import Foundation

struct TagSelectorView: View {
  @State private var viewModel: ContactFormViewModel = ContactFormViewModel()
  @Binding var tag: Tags
  
  var body: some View {
    Menu {
      Picker("Tags", selection: $tag) {
        ForEach(Tags.allCases) { tag in
          Text(tag.rawValue)
            .tag(tag.id)
        }
      }
    } label: {
      HStack(spacing: .zero) {
        Text(tag.rawValue)
          .foregroundStyle(.azure)
        CMIcon(.systemChevronRight)
      }
    }
  }
}

#Preview {
  TagSelectorView(tag: .constant(.personal))
}
