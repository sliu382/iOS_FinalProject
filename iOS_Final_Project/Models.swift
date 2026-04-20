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
    //let license: String
    //let sourceName: String
    //let sourceUrl: String
    let healthScore: Float?
    //let spoonacularSource: String
    let pricePerServing: Double?
    //let analyzedInstructions: [ExtendedInstruction]
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
    let monday: MealPlan
    let tuesday: MealPlan
    let wednesday: MealPlan
    let thursday: MealPlan
    let friday: MealPlan
    let saturday: MealPlan
    let sunday: MealPlan
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


//"week": {
//  "monday": {
//    "meals": [
//      {
//        "id": 639637,
//        "image": "Classic-scones-639637.jpg",
//        "imageType": "jpg",
//        "title": "Classic scones",
//        "readyInMinutes": 45,
//        "servings": 4,
//        "sourceUrl": "https://www.foodista.com/recipe/8R27PR6L/classic-scones"
//      },
//      {
//        "id": 642585,
//        "image": "Farfalle-with-fresh-tomatoes--basil-and-mozzarella-642585.jpg",
//        "imageType": "jpg",
//        "title": "Farfalle with fresh tomatoes, basil and mozzarella",
//        "readyInMinutes": 15,
//        "servings": 4,
//        "sourceUrl": "https://www.foodista.com/recipe/B6CC3QXM/farfalle-with-fresh-tomatoes-basil-and-mozzarella"
//      },
//      {
//        "id": 661094,
//        "image": "Sp
