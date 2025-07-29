//
//  AddContactView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import PhotosUI

struct ContactFormView: View {
  @State private var viewModel: ContactFormViewModel = ContactFormViewModel()
  @Environment(\.dismiss) private var dismiss
  
  var onAddContact: () -> Void
  
  init(onAddContact: @escaping () -> Void = {}) {
    self.onAddContact = onAddContact
  }
  
  var body: some View {
    VStack {
      HStack {
        Button(Constants.AddContact.cancel.rawValue) {
          dismiss()
        }
        Spacer()
        Button(Constants.AddContact.add.rawValue) {
          viewModel.addContact()
          onAddContact()
          dismiss()
        }
      }
      // Photo
      ContactPhotoView(selectedImage: $viewModel.selectedPhoto)
      
      VStack(alignment: .leading) {
        
        VStack {
          // Name
          HStack {
            Text(Constants.AddContact.nameSubtitle.rawValue)
            nameField
          }
          .padding(.bottom, .space1x)
          .keyboardType(.default)
          
          Divider()
          
          // Phone
          HStack(alignment: .top) {
            Text(Constants.AddContact.phoneSubtitle.rawValue)
            VStack(alignment: .leading) {
              ForEach($viewModel.phoneNumberFields) { $field in
                PhoneNumberField(
                  tag: $field.tag,
                  text: $field.number
                ) {
                  viewModel.removePhoneField(with: field.id)
                }
              }
              
              Button{
                viewModel.addNewPhoneField()
              } label: {
                HStack {
                  CMIcon(.systemPlusCircle, color: .erin)
                  Text(Constants.AddContact.buttonAddPhone.rawValue)
                    .foregroundStyle(.azure)
                  Spacer()
                }
                .padding(.leading, .space2x)
                .padding(.vertical, .space2x)
                .frame(maxWidth: .infinity)
                .background(.milk)
                .clipShape(.rect(cornerRadius: .radius10))
              }
            }
            .keyboardType(.numberPad)
          }
        }
        .padding(.space2x)
      }
      .background(.platinum)
      .clipShape(.rect(cornerRadius: .radius5))
      .padding(.top, .space6x)
    }
    .applyDefaultPadding()
  }
  
  @ViewBuilder
  private var nameField: some View {
    TextField(
      Constants.AddContact.addNamePlaceholder.rawValue,
      text: $viewModel.contactName
    )
      .padding(.leading, .space2x)
      .padding(.vertical, .space2x)
      .background(.milk)
      .clipShape(.rect(cornerRadius: .radius10))
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ContactFormView()
}
