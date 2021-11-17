//
//  ListViews.swift
//  ToDo
//
//  Created by Darie Nistor Nicolae on 15.11.2021.
//

import SwiftUI

struct ListViews: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
            }
        }
        
        .listStyle(.plain)
        .navigationTitle("2Do List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
        )
    }
}

struct ListViews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListViews()
        }
        .environmentObject(ListViewModel())
    }
}

