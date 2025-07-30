//
//  HomeView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 14/07/25.
//

import SwiftUI


struct HomeView: View {
  @State var viewModel: HomeViewModel = HomeViewModel()
  @State private var showAddContact: Bool = false
  @State private var showContactInfo: Bool = false
  
  init() {
    viewModel.updateView()
  }
  
  var body: some View {
    VStack {
      HStack {
        Text(Constants.Home.title.rawValue)
          .font(.title)
          .fontWeight(.medium)
        Spacer()
        Button {
          showAddContact.toggle()
        } label: {
          CMIcon(
            .systemAdd,
            color: .azure
          )
        }
      }
      .applyDefaultPadding()
      
      SearchContact(
        searchText: $viewModel.searchText,
        label: Constants.Home.searchPlaceholder.rawValue
      )
      .padding(.horizontal, .space4x)
      
      List {
        ForEach(viewModel.filteredContactByName) { contact in
          VStack(spacing: .zero) {
            ContactCard(
              name: contact.name,
              phone: contact.phoneNumber[0].number,
              photo: Image(uiImage: contact.wrapPhoto)
            ) {
              viewModel.selectedContact = contact
              showContactInfo.toggle()
            }
            Divider()
              .padding(.top, .space2x)
          }
          .listRowSeparator(.hidden)
        }
      }
      .listStyle(.plain)
    }
    .adaptiveSheet(isPresented: $showAddContact) {
      ContactFormView() {
        withAnimation {
          viewModel.updateView()
        }
      }
    }
    .sheet(isPresented: $showContactInfo) {
      if let contact = viewModel.selectedContact {
        ContactInfoView(contact)
      }
    }
  }
}

#Preview {
  HomeView()
}
