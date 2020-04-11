//
//  FolderView.swift
//  PasswordVault
//
//  Created by Gulshan Mandal on 11/04/2020.
//  Copyright © 2020 Gulshan Mandal. All rights reserved.
//

import SwiftUI

struct ItemRootView: View {
    let Item: Item
    var body: some View {
        return HStack {
            Image(systemName: Item.IsFolder ? "folder" : "pencil.and.ellipsis.rectangle")
                .resizable()
                .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(Item.Name).multilineTextAlignment(.leading).font(.headline)
                Text(Item.IsFolder ? "\(Item.Items.count) items" : "Tap to see password").font(.subheadline)
            }
            Spacer()
        }.padding()
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        let root = Item(Name: "root", EncryptedValue: "", Items: [
            Item(Name: "First level 1", EncryptedValue: "", Items: [
                Item(Name: "Second level 1", EncryptedValue: "", Items: [
                    Item(Name: "Password 1", EncryptedValue: "ssfsdf sdf", Items: [], IsFolder: false),
                    Item(Name: "Password 2", EncryptedValue: "ssfsdf sdf", Items: [], IsFolder: false)
                    
                ], IsFolder: true),
                Item(Name: "Second level 2", EncryptedValue: "", Items: [
                    
                ], IsFolder: true),
                Item(Name: "Password 1", EncryptedValue: "ssfsdf sdf", Items: [], IsFolder: false),
                Item(Name: "Password 2", EncryptedValue: "ssfsdf sdf", Items: [], IsFolder: false)
                
            ], IsFolder: true),
            Item(Name: "First level 2", EncryptedValue: "", Items: [
                
            ], IsFolder: true),
            Item(Name: "Password 1", EncryptedValue: "ssfsdf sdf", Items: [], IsFolder: false),
            Item(Name: "Password 2", EncryptedValue: "ssfsdf sdf", Items: [], IsFolder: false)
        ], IsFolder: true)
        return ItemRootView(Item: root)
    }
}
