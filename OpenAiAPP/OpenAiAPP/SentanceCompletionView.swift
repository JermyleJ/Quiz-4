//
//  SentanceCompletionView.swift
//  OpenAiAPP
//
//  Created by Jermyle Jones on 4/6/23.
//
import SwiftUI
import Foundation
struct SentenceCompletionView: View {
    @State private var fieldText = ""
    @State private var models = [String]()
    
    var body: some View {
        VStack {
            
            TextField("Type here", text: $fieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                .padding()
            Button("Configure") {
                fetchModels(models: $models)
            List(models, id: \.self) { model in
                Text(model)
                    .multilineTextAlignment(.center)
            }
            
        }
        .onTapGesture {
            hideKeyboard()
        }

        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func fetchModels(models: Binding<[String]>) {
        guard !fieldText.isEmpty else { return }
        
        APICaller.shared.getResponse(input: fieldText) { result in
            switch result {
            case .success(let output):
                models.wrappedValue.append(output)
                
            case .failure:
                print("Failure")
            }
        }
    }
}
struct SentenceCompletion_Previews: PreviewProvider {
    static var previews: some View {
        SentenceCompletionView()
    }
}

