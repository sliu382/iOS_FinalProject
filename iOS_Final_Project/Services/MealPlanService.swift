//
//  MealPlanService.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/16/26.
//

import SwiftUI

class MealPlanService {
    let apiKey = ""
    
    /**getting data from API**/
    func getMealPlan() async throws -> WeekDays {
        let url = URL(string: "https://api.spoonacular.com/mealplanner/generate?timeFrame=week&apiKey=\(apiKey)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(Week.self, from: data)
            return decoded.week
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /**Hard coded data**/
    func getMockMealPlan() -> WeekDays {
        let baseNutrient = Nutrient(calories:0.0, carbohydrates: 0.0, fat: 0.0, protein: 0.0)
        let emptyMealPlan = MealPlan(meals: [], nutrients: baseNutrient)
        let emptyWeekDays = WeekDays(monday: emptyMealPlan, tuesday: emptyMealPlan, wednesday: emptyMealPlan, thursday: emptyMealPlan,friday: emptyMealPlan, saturday: emptyMealPlan, sunday: emptyMealPlan)
        
        guard let url = Bundle.main.url(forResource: "MealPlan", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return emptyWeekDays
        }
        
        do {
            let decoded = try JSONDecoder().decode(Week.self,from: data)
            return decoded.week
        } catch {
            print("Decoding error: ", error)
            return emptyWeekDays
        }
    }
}
