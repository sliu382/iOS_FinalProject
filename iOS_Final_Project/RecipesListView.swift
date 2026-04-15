//
//  RecipesListView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/13/26.
//
import SwiftUI

struct RecipesListView: View {
    let service: RecipeService = RecipeService()
    @State var recipes: [Recipe]?
    
    var body: some View {
        NavigationStack {
            if let recipes {
                List(recipes, id: \.id) { recipe in
                    RecipeView(recipe: recipe)
                }
            } else {
                Text("Loading ...")
            }
        }
        .onAppear{
            Task {
                print("getRecipes called")
               // let response = try await service.getRecipes()
                let response = service.getMockRecipes()
                recipes = response
            }
        }
    }
    
}

#Preview {
    RecipesListView()
}
