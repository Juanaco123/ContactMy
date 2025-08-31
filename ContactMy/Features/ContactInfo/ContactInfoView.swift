//
//  ContactInfoView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 28/07/25.
//

import SwiftUI

struct ContactInfoView: SheetView {
  @Environment(\.dismiss) private var dismiss
  @State private var viewModel: ContactInfoViewModel = ContactInfoViewModel()
  @State private var showNumberList: Bool = false
  @State private var showEditView: Bool = false
  
  var onUpdateContact: () -> Void = {}
  var onDeleteContact: () -> Void = {}
  
  private let contact: ContactModel?
  private let size: CGFloat = 142.0
  private let minimumPhoneNumber: Int = 1
  
  var sheetScreenConfiguration: SheetScreenConfiguration {
    SheetScreenConfiguration(
      fullSheet: true,
      leadingText: Constants.ShowContactInfo.close,
      trailingText: Constants.ShowContactInfo.edit,
      trailingAction:  {
        showEditView.toggle()
      })
  }
  
  init(
    _ contact: ContactModel,
    onUpdateContact: @escaping () -> Void = {},
    onDeleteContact: @escaping () -> Void = {},
  ) {
    self.contact = contact
    self.onDeleteContact = onDeleteContact
    self.onUpdateContact = onUpdateContact
    _viewModel = State(initialValue: ContactInfoViewModel(contact))
  }
  
  var content: some View {
    VStack {
      VStack {
        PhotoView(
          selectedPhoto: Binding(
            get: { viewModel.contact?.photo },
            set: { viewModel.contact?.photo = $0 }
          )
        )
        
        Text(viewModel.contact?.name ?? "")
          .padding(.top, .space4x)
        
        HStack {
          IconButton(icon: .systemMessage) { viewModel.textContact() }
          IconButton(icon: .systemPhone) {
            if let phoneNumbersCount = viewModel.contact?.phoneNumber.count, phoneNumbersCount > minimumPhoneNumber {
              showNumberList.toggle()
              
            } else {
              viewModel.call(to: viewModel.contact?.phoneNumber[0].number ?? "")
            }
          }
          
          ShareLink(
            item: viewModel.shareContact(),
            preview:
              SharePreview(
                viewModel.contact?.name ?? "",
                image: Image(uiImage: viewModel.contact?.photo ?? UIImage()))
          ) {
            CMIcon(.systemShare)
              .padding(.horizontal, .space4x)
              .padding(.vertical, .space1x)
              .background(Color.platinum)
              .clipShape(.rect(cornerRadius: .radius10))
          }
          
        }
        .padding(.top, .space2x)
      }
      
      VStack(spacing: .space4x) {
        if let phones = viewModel.contact?.phoneNumber {
          ForEach(phones) { phone in
            phoneButton(
              tag: phone.tag,
              phone: phone.number
            )
          }
        } else {
          Text("No phones to show.\nEdit this contact to add phones")
        }
      }
      .padding(.vertical, .space2x)
      .padding(.leading, .space2x)
      .frame(maxWidth: .infinity)
      .background(Color.platinum)
      .clipShape(.rect(cornerRadius: .radius5))
      .padding(.top, .space6x)
      
      VStack(spacing: .space4x) {
        actionButton(Constants.ShowContactInfo.linkMessage) { viewModel.textContact() }
        actionButton(Constants.ShowContactInfo.linkCall) { showNumberList.toggle() }
        
        ShareLink(
          item: viewModel.shareContact(),
          preview:
            SharePreview(
              viewModel.contact?.name ?? "",
              image: Image(uiImage: viewModel.contact?.photo ?? UIImage()))
        ) {
          HStack {
            Text(Constants.ShowContactInfo.linkShare)
              .foregroundStyle(.azure)
            
            Spacer()
          }
        }
      }
      .padding(.vertical, .space2x)
      .padding(.leading, .space2x)
      .frame(maxWidth: .infinity)
      .background(Color.platinum)
      .clipShape(.rect(cornerRadius: .radius5))
      .padding(.top, .space6x)
      
      Spacer()
    }
    .applyDefaultPadding()
    .adaptativeSheet(isPresented: $showNumberList, noBackground: true) {
      numberList
    }
    .adaptativeSheet(isPresented: $showEditView) {
      ContactFormView(
        contact: viewModel.contact,
        isEditing: true,
        onUpdateContact: {
          onUpdateContact()
          dismiss()
        },
        onDeleteContact: {
          onDeleteContact()
          dismiss()
        })
    }
  }
  
  @ViewBuilder
  private func phoneButton(tag: String, phone: String) -> some View {
    HStack {
      VStack(alignment: .leading, spacing: .space1x) {
        Text(tag)
          .fontWeight(.medium)
        Button {
          viewModel.call(to: phone)
        } label: {
          Text(phone)
            .fontWeight(.regular)
            .foregroundStyle(.azure)
        }
      }
      Spacer()
    }
  }
  
  @ViewBuilder
  private func actionButton(_ label: String, action: @escaping () -> Void) -> some View {
    HStack {
      VStack {
        Button {
          action()
        } label: {
          Text(label)
            .foregroundStyle(.azure)
        }
      }
      Spacer()
    }
  }
  
  @ViewBuilder
  private var numberList: some View {
    if let phones = viewModel.contact?.phoneNumber {
      VStack {
        ForEach(phones) { phone in
          VStack(spacing: .space4x) {
            Button {
              viewModel.call(to: phone.number)
            } label: {
              HStack(spacing: .space2x) {
                CMIcon(.systemPhone)
                Text("Call \(phone.number)")
                Spacer()
              }
              .foregroundStyle(.azure)
              .padding(.vertical, .space4x)
              .padding(.horizontal, .space4x)
              .frame(maxWidth: .infinity)
              .background(.milk)
            }
            .buttonStyle(.plain)
            .clipShape(.rect(cornerRadius: .radius10))
            .padding(.horizontal, .space2x)
          }
        }
        
        Button {
          dismiss()
        } label: {
          VStack(alignment: .center) {
            Text("Cancel")
              .font(.headline)
              .foregroundStyle(.scarlet)
          }
          .padding(.vertical, .space4x)
          .frame(maxWidth: .infinity)
          .background(.metal)
          .clipShape(.rect(cornerRadius: .radius10))
          .padding(.horizontal, .space2x)
          .padding(.vertical, .space4x)
        }
      }
    }
  }
}

#Preview {
  let phones: [PhoneNumberModel] = [
    PhoneNumberModel(
      tag: "Business",
      number: "123456789"
    ),
    PhoneNumberModel(
      tag: "Business",
      number: "123456789"
    ),
    PhoneNumberModel(
      tag: "Business",
      number: "123456789"
    )
  ]
  ContactInfoView(
    ContactModel(
      name: "Juan Camilo Victoria",
      phoneNumber: phones,
      photo: UIImage(systemName: "phone")
    )
  )
}
