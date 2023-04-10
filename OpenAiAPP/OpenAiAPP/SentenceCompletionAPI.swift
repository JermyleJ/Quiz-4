//
//  SentenceCompletionAPI.swift
//  OpenAiAPP
//
//  Created by Jermyle Jones on 4/10/23.
//

import Foundation
import OpenAISwift

final class APICaller{
    static let shared = APICaller()
    
    @frozen enum Constants{
        static let key = "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"
    }
    private var client: OpenAISwift?
    
    public func setup(){
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String, completion: @escaping(Result<String, Error>)-> Void){
        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case.success(let model):
                let output = model.choices?.first?.text ?? ""
                completion(.success(output))
            case.failure(let error):
                completion(.failure(error))
            }
        })
    }
}
