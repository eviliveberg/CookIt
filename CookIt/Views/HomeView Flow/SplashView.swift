//
//  SplashView.swift
//  CookIt
//
//  Created by Artem Golovchenko on 2025-02-18.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.specialBlack.ignoresSafeArea()
            
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            }
            .offset(y: -35)
        }
//        .task {
//            try? await RecipesManager.shared.uploadRecipes()
//        }
        .task {
            do {
                try await vm.fetchAllData()
            } catch {
                print("Error while fetching primary data: \(error)")
            }
        }
    }
}

#Preview {
    SplashView()
}
