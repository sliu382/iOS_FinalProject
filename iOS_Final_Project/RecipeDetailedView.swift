//
//  RecipeDetailedView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/14/26.
//

import SwiftUI

struct RecipeDetailedView: View {
    let service: RecipeService = RecipeService()
    let id: Int
    @State var detailedRecipe: DetailedRecipe?
    @State var ingredientList: [Ingredient] = []
    var body: some View {
        NavigationStack {
            VStack{
                if let dr = detailedRecipe, let imageLink = dr.image {
                    AsyncImage(url: URL(string: imageLink)) { image in
                        image
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFit()
                    } placeholder: { //what shows while image is loading
                        Color.gray.opacity(0.1)
                    }
                    //Title
                    HStack{
                        Text(dr.title)
                            .font(.system(size:20,weight:.bold))
                        Spacer()
                    }
                    .padding(.horizontal,50)
                    
                } else {
                    Text("No Image Available")
                }
                
                //Three boxes with summaries
                HStack(spacing:10){
                    if let dr = detailedRecipe{
                        //time
                        if let time = dr.readyInMinutes {
                            InformationBox(icon: "clock", iconColor: Color.red,value: String(service.formatTime(time:time)), description: "Time")
                        }
                        
                        //Servings
                        if let servings = dr.servings {
                            InformationBox(icon: "person.2", iconColor: Color.blue,value: String(servings), description: "Servings")
                        }
                    
                        //Items
                        if let ingredients = dr.extendedIngredients {
                            InformationBox(icon: "carrot", iconColor: Color.orange, value: String(ingredients.count), description: "Items")
                        }
                        
                    }
                }
                
                //Ingredients
                VStack (alignment:.leading){
                    HStack{
                        Text("Ingredients")
                            .font(.system(size:18, weight:.bold))
                        Spacer()
                    }.padding(10)
                    
                    //List the ingredients
//                    ForEach($ingredientList) { $ingredient in
//                        HStack{
//                            Button {
//                                ingredient.isChecked.toggle()
//                            } label: {
//                                Image(systemName: ingredient.isChecked ? "circle.fill": "circle")
//                            }
//                            Text(ingredient.original)
//                        }
//                    }
                    
                }
                .padding(5)
                .frame(width:320, height:300)
                .background(RoundedRectangle(cornerRadius:10)
                    .foregroundStyle(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius:10)
                            .stroke(Color(red:0.3, green:0.3, blue:0.3), lineWidth:2)
                    ))
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
            
        }
        .onAppear {
            Task {
                print("getDetailedRecipes called")
                //let response = try await service.getRecipes()
                let response = service.getMockDetailedRecipes()
                detailedRecipe = response
                
                //ingredientList = response.extendedIngredients ?? []
            }
        }
        
    }
    
    func InformationBox(icon:String, iconColor: Color, value: String, description: String) -> some View {
        VStack{
            Image(systemName: icon)
                .foregroundStyle(iconColor)
                .font(.title2)
            Text(value)
                .foregroundStyle(Color.black)
            Text(description)
                .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
            
        }
        .padding(5)
        .frame(width:100, height:80)
        .background(RoundedRectangle(cornerRadius:10)
            .foregroundStyle(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius:10)
                    .stroke(Color(red:0.3, green:0.3, blue:0.3), lineWidth:2)
            ))
    }
    
}

#Preview {
    RecipeDetailedView(id:100)
}
