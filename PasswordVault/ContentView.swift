//
//  ContentView.swift
//  PasswordVault
//
//  Created by Gulshan Mandal on 11/04/2020.
//  Copyright © 2020 Gulshan Mandal. All rights reserved.
//

import SwiftUI
import Combine

struct Item: Identifiable, Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return true
    }
    
    var id: String {
        return Name
    }
    
    var Name: String
    var EncryptedValue: String
    var Items: [Item]
    var IsFolder: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(Name)
    }
}

struct ContentView: View {
    let root = Item(Name: "/", EncryptedValue: "", Items: [
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
    var body: some View {
        NavigationView {
            HomeView(Root: root)
        }
    }
}

struct HomeView: View {
    let Root: Item
    @State private var isShowingAlert = false
    @State private var alertInput = ""
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach (Root.Items) {item in
                    if item.IsFolder {
                        AnyView(NavigationLink(destination: HomeView(Root:item)) {
                            ItemRootView(Item: item)
                        })
                    } else {
                        AnyView(ItemRootView(Item: item)).onTapGesture {
                            self.isShowingAlert.toggle()
                        }
                    }
                    Divider()
                }
            }
        }
        .navigationBarTitle(Root.Name)
        .navigationBarItems(trailing:
            HStack {
                Button(action: {}) {
                    Image(systemName: "folder.badge.plus")
                        .font(.largeTitle)
                }
                Button(action: {}) {
                    Image(systemName: "plus.app")
                        .font(.largeTitle)
                }
        })
//        .sheet(isPresented: $isShowingAlert, onDismiss: {
//            print(self.isShowingAlert)
//        }) {
//            ModalView(message: "This is Modal view")
//        }
        .textFieldAlert(isShowing: $isShowingAlert, text: $alertInput, title: "Alert!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}


struct ModalView: View {
    @Environment(\.presentationMode) var presentation
    let message: String

    var body: some View {
        VStack {
            Text(message)
            Button("Dismiss") {
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    let title: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(self.isShowing)
                VStack {
                    Text(self.title)
                    TextField("", text: self.$text)
                    Divider()
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                            }
                        }) {
                            Text("Dismiss")
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

extension View {

    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       title: title)
    }

}



