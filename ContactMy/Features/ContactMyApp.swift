//
//  ContactMyApp.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 14/07/25.
//

import SwiftUI

@main
struct ContactMyApp: App {
  let persistenceContainer = ContactService.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .preferredColorScheme(.light)
        .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
    }
  }
}
