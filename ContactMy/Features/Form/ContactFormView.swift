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
  
  private let size: CGFloat = 142.0
  
  var onAddContact: () -> Void
  var onUpdateContact: () -> Void = {}
  var onDeleteContact: () -> Void = {}
  
  var sheetScreenConfiguration: SheetScreenConfiguration {
    SheetScreenConfiguration(
      fullSheet: false,
      leadingText: Constants.AddContact.cancel,
      trailingText: isEditing ? Constants.EditContact.done : Constants.AddContact.add,
      trailingAction: {
        if isEditing {
          viewModel.updateContact()
          onUpdateContact()
        } else {
          viewModel.addContact()
          onAddContact()
        }
        dismiss()
      }
    )
  }
  
  init(
    contact: ContactModel? = nil,
    isEditing: Bool = false,
    onAddContact: @escaping () -> Void = {},
    onUpdateContact: @escaping () -> Void = {},
    onDeleteContact: @escaping () -> Void = {},
  ) {
    self.isEditing = isEditing
    self.onAddContact = onAddContact
    _viewModel = State(initialValue: ContactFormViewModel(contact))
    self.onUpdateContact = onUpdateContact
    self.onDeleteContact = onDeleteContact
  }
  
  var content: some View {
    VStack {
      // Photo
      ContactPhotoView(
        selectedImage: $viewModel.selectedPhoto,
        initialImage: isEditing || viewModel.selectedPhoto == nil ? viewModel.contact?.photo : nil
      )
      
      VStack(alignment: .leading) {
        
        VStack {
          // Name
          HStack {
            Text(Constants.AddContact.nameSubtitle)
            nameField
          }
          .padding(.bottom, .space1x)
          .keyboardType(.default)
          
          Divider()
          
          // Phone
          HStack(alignment: .top) {
            Text(Constants.AddContact.phoneSubtitle)
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
                  Text(Constants.AddContact.buttonAddPhone)
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
          deleteContactButton() {
            viewModel.deleteContact()
            onDeleteContact()
            dismiss()
          }
        }
        .padding(.top, .space8x)
      }
    }
    .applyDefaultPadding()
  }
  
  @ViewBuilder
  private var nameField: some View {
    TextField(
      Constants.AddContact.addNamePlaceholder,
      text: isEditing
      ? Binding(
        get: { viewModel.contact?.name ?? "" },
        set: { viewModel.contact?.name = $0 })
      : $viewModel.contactName
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
        Text(Constants.EditContact.buttonLabel)
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
  ContactFormView(
    contact: ContactModel(
      name: "Juan",
      phoneNumber: [
        PhoneNumberModel(tag: "", number: "12345")
      ]
    )
  )
}
