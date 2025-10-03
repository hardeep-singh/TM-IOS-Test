//
//  OAuth1Authenticator.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation

struct OAuth1Authenticator {
    
    let consumerKey = Bundle.main.trademeSandboxAPIKey
    let consumerSecret = Bundle.main.trademeSandboxAPISecret

    func authorizationHeader() -> String {
        let signature = "\(consumerSecret)&"
        return [
            "OAuth oauth_consumer_key=\"\(consumerKey)\"",
            "oauth_signature_method=\"PLAINTEXT\"",
            "oauth_signature=\"\(signature)\""
        ].joined(separator: ", ")
    }
    
}

private extension Bundle {
    
    var trademeSandboxAPIKey: String {
        guard let key = infoDictionary?["TMAPITM_API_KeyKey"] as? String else {
            fatalError("API Key is missing")
        }
        return key
    }
    
    var trademeSandboxAPISecret: String {
        guard let key = infoDictionary?["TM_API_Sec_Key"] as? String else {
            fatalError("API Secret key is missing")
        }
        return key
    }
    
}
