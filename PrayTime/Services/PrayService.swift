//
//  PrayService.swift
//  PrayTime
//
//  Created by Mehmet Tayyar Kuyucu on 21.01.2023.
//

import Foundation

enum NetworkError: Error{
    case invalidResponse
}

class PrayService : ObservableObject{
    
    func getPrayInfo(url:URL) async throws -> PrayData {
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else{
            throw NetworkError.invalidResponse
        }
        
        let prayData = try! jsonDecoder().decode(PrayData.self, from: data)
        print(prayData)
        return prayData
    }
    
    func jsonDecoder() -> JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterWithNoTime = DateFormatter()
        dateFormatterWithNoTime.dateFormat = "yyyy-MM-dd"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = dateFormatter.date(from: dateString){
                return date
            } else if let date = dateFormatterWithNoTime.date(from: dateString){
                return date
            }
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            
        })
        
        return decoder;
    }
}
