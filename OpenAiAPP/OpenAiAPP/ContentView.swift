//
//  ContentView.swift
//  OpenAiAPP
//
//  Created by Jermyle Jones on 4/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
//            Text("Hello World")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                ToolbarItem(placement: .principal){
//                    Text("OpenAi API")
//                        .font(.headline)
//                        .foregroundColor(.black)
//                }
//            }
            VStack(){
                HStack{
                    Text("OpenAi API")
                        .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.bold)
                }
                
            Spacer()
                
                NavigationLink(destination: TexttoImageView()) {
                    Text("Text To Image")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                NavigationLink(destination: SentenceCompletionView()) {
                    Text("Sentence Completion")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                NavigationLink(destination: SentimentView()) {
                    Text("Sentiment Analysis")
                        .font(.title)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
            
                //.navigationBarTitle("OpenAi API", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
