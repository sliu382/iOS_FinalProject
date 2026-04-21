//
//  RecipesListView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/13/26.
//
import SwiftUI

struct RecipesListView: View {
    let service: RecipeService = RecipeService()
    @State var recipes: [Recipe] = []
    @State private var searchTerm: String = ""
    @Binding var weekDays: WeekDays?
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 0){
                //Search bar
                HStack{
                    //text field with state variable
                    TextField("Search recipes...", text: $searchTerm)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    //button next to search bar
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
                
                
                //List of all the recipes
                VStack {
                    List(recipes.indices, id: \.self) { index in
                        NavigationLink { //leads to a more detailed version of recipe
                            RecipeDetailedView(id: recipes[index].id, recipe: $recipes[index],weekDays: $weekDays)
                        } label: { //Shows the recipe as the other view int he list
                            RecipeView(recipe: recipes[index])
                        }
                    }
                    .navigationTitle("Recipes")
                    .scrollContentBackground(.hidden)
                    .background(Color.gray.opacity(0.1))
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
    //RecipesListView()
}
