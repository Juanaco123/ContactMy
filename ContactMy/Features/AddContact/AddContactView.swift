//
//  AddContactView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import PhotosUI

struct AddContactView: View {
  @State private var viewModel: AddContactViewModel = AddContactViewModel()
  
  var body: some View {
    VStack {
      HStack {
        Button("Cancel") {}
        Spacer()
        Button("Add") {}
      }
      // Photo
      ContactPhotoView()
      
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
                Field(
                  text: $field.text,
                  placeholder: field.placeholder
                ) {
                  removePhoneField(with: field.id)
                }
              }
              
              Button{
                addNewPhoneField()
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
    TextField(Constants.AddContact.addNamePlaceholder.rawValue, text: $viewModel.contactName)
      .padding(.leading, .space2x)
      .padding(.vertical, .space2x)
      .background(.milk)
      .clipShape(.rect(cornerRadius: .radius10))
  }
  
  func addNewPhoneField() {
    let newField: PhoneFieldModel = PhoneFieldModel(
      text: "",
      placeholder: Constants.AddContact.addNumberPlaceholder.rawValue
    )
    viewModel.phoneNumberFields.append(newField)
  }
  
  func removePhoneField(with id: UUID) {
    viewModel.phoneNumberFields.removeAll { phoneField in
      phoneField.id == id
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  AddContactView()
}
