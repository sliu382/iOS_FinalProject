//
//  RecipeService.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/13/26.
//

import SwiftUI

class RecipeService {
    let apiKey = ""
    
    /**Recipe Services**/
    func getRecipes(query: String) async throws -> [Recipe] {
        let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&number=10&query=\(query)&addRecipeInformation=true")!
        
        do {
            //Request data
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //Decode JSON
            let decoded = try JSONDecoder().decode(AllRecipes.self, from: data)
            return decoded.results
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func getDetailedRecipes(id: Int) async throws -> DetailedRecipe {
        let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=\(apiKey)")!
        do {
            //Request Data
            let (data,_) = try await URLSession.shared.data(from: url)
            
            //Decode JSON
            let decoded = try JSONDecoder().decode(DetailedRecipe.self, from: data)
            return decoded
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    //https://api.spoonacular.com/recipes/644387/information?apiKey=70702841d94d4a64aed448016bf9c9c0
    
    
    /**Placeholder Recipes**/
    func getMockRecipes() -> [Recipe] {
        guard let url = Bundle.main.url(forResource: "recipe", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
            }
        do {
            let decoded = try JSONDecoder().decode(AllRecipes.self, from: data)
            return decoded.results
        } catch {
            print("Decoding error: ", error)
            return []
        }
    }
    
    func getMockDetailedRecipes() -> DetailedRecipe {
        guard let url = Bundle.main.url(forResource: "DetailRecipes", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return DetailedRecipe(id: 0, title: "", image: "",imageType: "", servings: 0, readyInMinutes: 0, cookingMinutes:0,preparationMinutes:0,healthScore:0,pricePerServing:0.0,cuisines:[], extendedIngredients: [],summary: "", analyzedInstructions:[])
        }
        do {
            let decoded = try JSONDecoder().decode(DetailedRecipe.self, from: data)
            return decoded
        } catch {
            print("Decoding error: ", error)
            return DetailedRecipe(id: 0, title: "", image: "",imageType: "", servings: 0, readyInMinutes: 0, cookingMinutes:0,preparationMinutes:0,healthScore:0,pricePerServing:0.0,cuisines:[], extendedIngredients: [], summary: "", analyzedInstructions:[])
        }
    }
    
    
    /**Formatting Time**/
    func formatTime(time: Int)  -> String {
        let hour = Int(time/60)
        let minutes = time % 60
        var timeText: String
        
        if hour == 0 {
            timeText = String(format: "%2d min", minutes)
        } else {
            timeText = String(format: "%d hr %2d min", hour, minutes)
        }
        
        return timeText
    }
}
