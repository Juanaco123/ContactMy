//
//  ContactInfoView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 28/07/25.
//

import SwiftUI

struct ContactInfoView: SheetView {
  @State private var viewModel: ContactInfoViewModel = ContactInfoViewModel()
  
  private let contact: ContactModel?
  private let size: CGFloat = 142.0
  
  var sheetScreenConfiguration: SheetScreenConfiguration {
    SheetScreenConfiguration(
      fullSheet: true,
      leadingText: Constants.ShowContactInfo.close.rawValue,
      trailingText: Constants.ShowContactInfo.edit.rawValue
    )
  }
  
  init(_ contact: ContactModel) {
    self.contact = contact
    _viewModel = State(initialValue: ContactInfoViewModel(contact))
  }
  
  var content: some View {
    VStack {
      VStack {
        if let photo = viewModel.contact?.photo {
          Image(uiImage: photo)
            .resizable()
            .scaledToFit()
            .clipShape(.circle)
            .frame(width: size, height: size)
        } else {
          Circle()
            .fill(.metal)
            .frame(width: size, height: size)
        }
        
        Text(viewModel.contact?.name ?? "")
          .padding(.top, .space4x)
        
        HStack {
          IconButton(icon: .systemMessage) {}
          IconButton(icon: .systemPhone) {}
          IconButton(icon: .systemShare) {}
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
        actionButton(Constants.ShowContactInfo.linkMessage.rawValue) {}
        actionButton(Constants.ShowContactInfo.linkCall.rawValue) {}
        actionButton(Constants.ShowContactInfo.linkShare.rawValue) {}
        actionButton(Constants.ShowContactInfo.linkFavorite.rawValue) {}
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
  }
  
  @ViewBuilder
  private func phoneButton(tag: String, phone: String) -> some View {
    HStack {
      VStack(alignment: .leading, spacing: .space1x) {
        Text(tag)
          .fontWeight(.medium)
        if let destination = viewModel.onCall(to: phone) {
          Link(destination: destination) {
            Text(phone)
              .fontWeight(.regular)
          }
        } else {
          Text("❌ Number unreachable")
            .foregroundStyle(.scarlet)
        }
      }
      Spacer()
    }
  }
  
  @ViewBuilder
  private func actionButton(
    _ label: String,
    action: @escaping () -> Void
  ) -> some View {
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
      phoneNumber: phones
    )
  )
}
