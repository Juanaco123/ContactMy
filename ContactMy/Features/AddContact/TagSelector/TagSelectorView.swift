//
//  TagSelectorView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import SwiftUI
import Foundation

struct TagSelectorView: View {
  @State private var viewModel: AddContactViewModel = AddContactViewModel()
  
  var body: some View {
    Menu {
      Picker("Tags", selection: $viewModel.selectedTagNumber) {
        ForEach(Tags.allCases) { tag in
          Text(tag.rawValue)
            .tag(tag.id)
            .onTapGesture {
              viewModel.selectedTagNumber = tag
            }
        }
      }
    } label: {
      HStack(spacing: .zero) {
        Text(viewModel.selectedTagNumber.rawValue)
          .foregroundStyle(.azure)
        CMIcon(.systemChevronRight)
      }
    }
  }
}

#Preview {
  TagSelectorView()
}
