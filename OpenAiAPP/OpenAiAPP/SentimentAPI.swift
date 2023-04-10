//
//  SentimentAPI.swift
//  OpenAiAPP
//
//  Created by Jermyle Jones on 4/10/23.
//

import Foundation

class OpenAI1 {
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func analyzeSentiment(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = "https://api.openai.com/v1/engines/davinci/completions"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let prompt = "The sentiment of this text is:\n\(text)\n- Positive, Negative, or Neutral?\n"
        let parameters: [String: Any] = [
            //"model" = text-davinci-003
            "prompt": prompt,
            "temperature": 0,
            "max_tokens": 60,
            "top_p": 1,
            //"stop": "",
            "frequency_penalty": 0.5,
            "presence_penalty": 0
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Empty response", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let choices = json?["choices"] as? [[String: Any]],
                   let sentiment = choices[0]["text"] as? String {
                    switch sentiment.lowercased() {
                    case "positive":
                        completion(.success("Positive"))
                    case "negative":
                        completion(.success("Negative"))
                    default:
                        completion(.success("Positive"))
                    }
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
