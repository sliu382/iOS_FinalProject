//
//  RecipeService.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/13/26.
//

import SwiftUI

class RecipeService {
    func getRecipes(/*query: String*/) async throws -> [Recipe] {
        let apiKey = ""
        let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&number=2")! //query=\(query)&
        
        do {
            //Request data
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //Decode JSON
            let decoded = try JSONDecoder().decode(AllRecipes.self, from: data)
            print(decoded.results)
            return decoded.results
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
            return DetailedRecipe(id: 0, title: "", image: "",imageType: "", servings: 0, readyInMinutes: 0, cookingMinutes:0,preparationMinutes:0,healthScore:0,pricePerServing:0.0,cuisines:[], summary: "", instructions: "")
        }
        do {
            let decoded = try JSONDecoder().decode(DetailedRecipe.self, from: data)
            return decoded
        } catch {
            print("Decoding error: ", error)
            return DetailedRecipe(id: 0, title: "", image: "",imageType: "", servings: 0, readyInMinutes: 0, cookingMinutes:0,preparationMinutes:0,healthScore:0,pricePerServing:0.0,cuisines:[], summary: "", instructions: "")
        }
    }
    
    
    /**Formatting Time**/
    func formatTime(time: Int)  -> String {
        let hour = Int(time/60)
        let minutes = time % 60
        var timeText: String
        
        if hour == 0 {
            timeText = String(format: "%02d min", minutes)
        } else {
            timeText = String(format: "%d hr %02d min", hour, minutes)
        }
        
        return timeText
    }
}
