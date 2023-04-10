//
//  TexttoImageView.swift
//  OpenAiAPP
//
//  Created by Jermyle Jones on 4/6/23.
//

import SwiftUI

struct TexttoImageView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var image: UIImage?
    var body: some View {
        NavigationView{
            VStack{
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 150, height: 150)
                }
                else{
                    Text("Type prompt to generate image")
                        .foregroundColor(.white)
                }
                Spacer()
                TextField("Type Prompt Here...", text: $text)
                    .padding()
                Button("Generate"){
                    Task{
                        if !text.trimmingCharacters(in: .whitespaces).isEmpty{
                            let result = await viewModel.generateImage(prompt: text)
                            self.image = result
                        }
                    }
                }
            }
            
            .navigationTitle("Image Generator")
            .onAppear{
                
                viewModel.setup()
            }
            .padding()
        }
    }
    
    struct TexttoImageView_Previews: PreviewProvider {
        static var previews: some View {
            TexttoImageView()
        }
    }
}
