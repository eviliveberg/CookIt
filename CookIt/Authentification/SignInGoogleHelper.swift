//
//  SignInGoogleHelper.swift
//  CookIt
//
//  Created by Artem Golovchenko on 2025-02-06.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        let email = gidSignInResult.user.profile?.email
        let name = gidSignInResult.user.profile?.name
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
    
}
