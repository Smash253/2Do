//
//  ToDoApp.swift
//  ToDo
//
//  Created by Darie Nistor Nicolae on 15.11.2021.
//

import SwiftUI

/*
 MVVM Arhitecure
 
 Mode - data point
 View - UI
 ViewModel - manages Models of the View
 
 
 */

@main
struct ToDoApp: App {
   @StateObject var listViewModel: ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListViews()
            }
            .navigationViewStyle(.stack)
            .environmentObject(listViewModel)
        }
    }
}
