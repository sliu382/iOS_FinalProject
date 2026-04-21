//
//  Models.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/12/26.
//

import SwiftUI

struct AllRecipes: Codable {
    let results: [Recipe]
}

struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String?
    let imageType: String?
    let readyInMinutes: Int?
    let servings: Int?
}


struct DetailedRecipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String?
    let imageType: String?
    let servings: Int?
    let readyInMinutes: Int?
    let cookingMinutes: Int?
    let preparationMinutes: Int?
    let healthScore: Float?
    let pricePerServing: Double?
    let cuisines: [String]?
    let extendedIngredients: [Ingredient]?
    let summary: String?
    let analyzedInstructions: [Instruction]?
}

struct Ingredient: Identifiable, Codable {
    let id: Int
    let original: String
}

struct Instruction: Codable {
    let steps: [IndividualStep]
}

struct IndividualStep: Identifiable, Codable {
    let number: Int
    let step: String
    var id: Int {number}
}


/**Meal Plan Structs**/
struct Week: Codable {
    let week: WeekDays
}

struct WeekDays: Codable {
    var monday: MealPlan
    var tuesday: MealPlan
    var wednesday: MealPlan
    var thursday: MealPlan
    var friday: MealPlan
    var saturday: MealPlan
    var sunday: MealPlan
}


struct MealPlan: Codable {
    var meals: [Recipe]
    let nutrients: Nutrient
}

struct Nutrient: Codable {
    let calories: Double
    let carbohydrates: Double
    let fat: Double
    let protein: Double
}
