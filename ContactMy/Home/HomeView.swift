//
//  HomeView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 14/07/25.
//

import SwiftUI


struct HomeView: View {
  @State private var searchText: String = ""
  var body: some View {
    VStack {
      HStack {
        Text("Contact My")
          .font(.title)
          .fontWeight(.medium)
        Spacer()
        CMIcon(
          .systemAdd,
          color: .azure
        )
      }
      SearchContact(searchText: searchText, label: "Search contact...")
      
      List {
        
      }
    }
    .applyDefaultPadding()
  }
}

#Preview {
  HomeView()
}
