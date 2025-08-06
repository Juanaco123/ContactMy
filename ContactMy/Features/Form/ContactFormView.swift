//
//  AddContactView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import PhotosUI

struct ContactFormView: SheetView {
  @Environment(\.dismiss) private var dismiss
  @State private var viewModel: ContactFormViewModel = ContactFormViewModel()
  @State private var isEditing: Bool = false
  
  var onAddContact: () -> Void
  
  var sheetScreenConfiguration: SheetScreenConfiguration {
    SheetScreenConfiguration(
      fullSheet: false,
      leadingText: Constants.AddContact.cancel.rawValue,
      trailingText: isEditing ? Constants.EditContact.done.rawValue : Constants.AddContact.add.rawValue,
      trailingAction: {
        if isEditing {}
        viewModel.addContact()
        onAddContact()
        dismiss()
      }
    )
  }
  
  init(onAddContact: @escaping () -> Void = {}) {
    self.onAddContact = onAddContact
  }
  
  var content: some View {
    VStack {
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
      
      if isEditing {
        VStack {
          deleteContactButton() {}
        }
        .padding(.top, .space8x)
      }
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
  
  @ViewBuilder
  private func deleteContactButton(_ action: @escaping () -> Void) -> some View {
    Button {
      action()
    } label: {
      VStack(alignment: .center) {
        Text(Constants.EditContact.buttonLabel.rawValue)
          .foregroundStyle(Color.scarlet)
      }
      .padding(.vertical, .space3x)
      .frame(maxWidth: .infinity)
      .background(Color.metal)
      .clipShape(.rect(cornerRadius: .radius5))
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ContactFormView()
}
