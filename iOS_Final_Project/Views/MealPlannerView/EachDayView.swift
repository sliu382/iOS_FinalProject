//
//  EachDayView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/17/26.
//

import SwiftUI

struct EachDayView: View {
    let service: MealPlanService = MealPlanService()
    @Binding var day: MealPlan
    //@State var meals: [Recipe]?
    //@State var nutrients: Nutrient?
    
    /**temp**/
    //@State var day: MealPlan?
    
    var body: some View {
        //Nutrients info
        VStack{
            VStack(alignment:.leading){
                Text("\(Text("Calories").bold()): \(String(day.nutrients.calories))")
                Text("\(Text("Carbs").bold()): \(String(day.nutrients.carbohydrates))")
                Text("\(Text("Fat").bold()): \(String(day.nutrients.fat))")
                Text("\(Text("Protein").bold()): \(String(day.nutrients.protein))")
            }
            .padding(.leading, 10)
            .frame(width:360, height:100, alignment:.leading)
            .padding(5)
            .background(RoundedRectangle(cornerRadius:10)
                .foregroundStyle(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius:10)
                        .stroke(Color(red:0.3, green:0.3, blue:0.3), lineWidth:2)
                ))
                
            
            //List of Meals for the day
            List {
                ForEach(day.meals, id:\.id) { recipe in
                    NavigationLink {
                        RecipeDetailedView(id: recipe.id)
                    } label: {
                        RecipeView(recipe: recipe)
                    }
                }
                .onDelete { indexSet in
                    day.meals.remove(atOffsets: indexSet)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.gray.opacity(0.1))
            
            }
        }
}

#Preview {
    //EachDayView()
}
