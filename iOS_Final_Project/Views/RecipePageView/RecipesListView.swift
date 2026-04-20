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
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 0){
                //Search
                HStack{
                    TextField("Search recipes...", text: $searchTerm)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button {
                        searchRecipes()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.white)
                            .padding(5)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                
                
                //List
                VStack {
                    if let recipes {
                        List(recipes, id: \.id) { recipe in
                            NavigationLink {
                                RecipeDetailedView(id: recipe.id)
                            } label: {
                                RecipeView(recipe: recipe)
                            }
                        }
                        .navigationTitle("Recipes")
                        .scrollContentBackground(.hidden)
                        .background(Color.gray.opacity(0.1))
                        
                    } else {
                        Text("Loading ...")
                    }
                }
            }
        }
        .onAppear{
            searchRecipes()
        }
    }
    
    func searchRecipes() {
        Task {
            print("getRecipes called")
            let response = try await service.getRecipes(query: searchTerm)
            //let response = service.getMockRecipes()
            recipes = response
        }
    }
    
}

#Preview {
    RecipesListView()
}
