//
//  SearchContact.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 14/07/25.
//

import SwiftUI

struct SearchContact: View {
  @State var searchText: String = ""
  var label: String
  
  init(
    searchText: String,
    label: String = ""
  ) {
    self.searchText = searchText
    self.label = label
  }
  
  var body: some View {
    HStack {
      CMIcon(.systemSearch)
      TextField(label, text: $searchText)
        .fontWeight(.medium)
        .padding(.leading, .space2x)
    }
    .padding(.horizontal, .space3x)
    .padding(.vertical, .space1x)
    .background {
      Color(.platinum)
        .clipShape(.rect(cornerRadius: .radius5))
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  SearchContact(searchText: "", label: "Search contact...")
}
