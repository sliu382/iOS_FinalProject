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
    let summary: String?
    let instructions: String?
}
//let servings: Int?
//let readyInMinutes: Int?
//let cookingMinutes: Int?
//let sourceUrl: String?
//let healthScore: Float?
//let cuisines: [String]?
