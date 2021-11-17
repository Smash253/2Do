//
//  AddView.swift
//  ToDo
//
//  Created by Darie Nistor Nicolae on 15.11.2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var input: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                FirstResponderTextField(input: $input, placeholder: "Type something...")
                    .padding(.horizontal)
                    .frame(height:55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    
                Button {
                    save()
                } label: {
                    Text("Save me! 🤪")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }

            }
            .padding(15)
        }
        .navigationTitle("Add an Item 🖋")
        .alert(isPresented: $showAlert) {
            getAlert()
        }
    }
    
    func save() {
        if checkText() {
            
            listViewModel.addItem(title: input)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func checkText() -> Bool {
        if input.count < 3 {
            alertTitle = "Introduce at least 3 charts🖋"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct FirstResponderTextField: UIViewRepresentable {
    
    @Binding var input: String
    let placeholder: String
    
    class Coordinator:NSObject, UITextFieldDelegate {
        @Binding var input: String
        var becameFirstResponder = false
        
        init(input: Binding<String> ) {
            self._input = input
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            input = textField.text ?? ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(input: $input)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        return textField
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        AddView()
        }
        .environmentObject(ListViewModel())
    }
}
