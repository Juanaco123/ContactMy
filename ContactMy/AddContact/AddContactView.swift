//
//  AddContactView.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import PhotosUI

struct AddContactView: View {
  
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
            Text("Name")
            TextField("", text: .constant("Juan Camilo Victoria"))
              .padding(.leading, .space2x)
              .padding(.vertical, .space2x)
              .background(.milk)
              .clipShape(.rect(cornerRadius: .radius10))
          }
          .padding(.bottom, .space1x)
          
          Divider()
          
          // Phone
          HStack(alignment: .top) {
            Text("Phone")
            
            VStack(alignment: .leading) {
              
              HStack {
                Button {} label: {
                  HStack {
                    CMIcon(.systemErase, color: .scarlet)
                  }
                }
                
                Button {} label: {
                  HStack {
                    Text("Personal")
                      .foregroundStyle(.azure)
                    CMIcon(.systemChevronRight)
                  }
                }
                TextField("", text: .constant("112324564"))
              }
              .padding(.leading, .space2x)
              .padding(.vertical, .space2x)
              .background(.milk)
              .clipShape(.rect(cornerRadius: .radius10))
              
              Button{
                
              } label: {
                HStack {
                  CMIcon(.systemPlusCircle, color: .erin)
                  Text("Add phone")
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
          }
        }
        .padding(.space2x)
      }
      .background(.platinum)
      .clipShape(.rect(cornerRadius: .radius5))
    }
    .applyDefaultPadding()
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  AddContactView()
}
