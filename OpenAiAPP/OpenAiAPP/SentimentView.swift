//
//  SentimentView.swift
//  OpenAiAPP
//
//  Created by Jermyle Jones on 4/6/23.
//
import SwiftUI

struct SentimentView: View {
    @State private var inputText = ""
    @State private var sentimentScore = ""
    @State private var isLoading = false
    @State private var error: Error?
    
    let openAI1 = OpenAI1(apiKey: "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")
    
    var body: some View {
        VStack {
            TextField("Enter some text", text: $inputText)
                .padding()
            
            Button("Generate") {
                generateSentiment()
            }
            .disabled(isLoading)
            .padding()
            
            if isLoading {
                ProgressView()
                    .padding()
            } else if let error = error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            } else if !sentimentScore.isEmpty {
                Text("Sentiment score: \(sentimentScore)")
                    .padding()
            }
        }
    }
    
    func generateSentiment() {
        isLoading = true
        
        openAI1.analyzeSentiment(text: inputText) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let score):
                    self.sentimentScore = score
                    self.error = nil
                case .failure(let error):
                    self.sentimentScore = ""
                    self.error = error
                }
            }
        }
    }
}

struct SentimentView_Previews: PreviewProvider {
    static var previews: some View {
        SentimentView()
    }
}
