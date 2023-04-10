//
//  TexttoImageViewAPI.swift
//  OpenAiAPP
//
//  Created by Jermyle Jones on 4/6/23.
//

import Foundation
import SwiftUI
import OpenAIKit

final class ViewModel: ObservableObject{
    private var openai: OpenAI?
    func setup(){
        openai = OpenAI(Configuration(organizationId: "Personal", apiKey: "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"))
    }
    
    func generateImage(prompt: String) async -> UIImage?{
        guard let openai = openai else{
            return nil
        }
        do{
            let params = ImageParameters(prompt: prompt,
                                         resolution: .medium,
                                         responseFormat: .base64Json)
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            let image = try openai.decodeBase64Image(data)
            return image
        }
        catch{
            print(String(describing: error))
            return nil
        }
    }
}
