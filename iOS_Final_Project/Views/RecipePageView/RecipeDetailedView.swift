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
    @State var instructionList: [IndividualStep] = []
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing:25){
                    if let dr = detailedRecipe, let imageLink = dr.image {
                        AsyncImage(url: URL(string: imageLink)) { image in
                            image
                                .resizable()
                                .frame(width:450)
                                .scaledToFit()
                        } placeholder: { //what shows while image is loading
                            Color.gray.opacity(0.1)
                        }
                        
                        //Title
                        HStack{
                            Text(dr.title)
                                .font(.system(size:40,weight:.bold))
                            Spacer()
                        }
                        .padding(.horizontal,50)
                        
                    } else {
                        Text("No Image Available")
                    }
                    
                    //Three boxes with summaries
                    HStack(spacing:10){
                        if let dr = detailedRecipe {
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
                    numberedSection(title:"Ingredients", items: ingredientList.map {$0.original})
                    
                    //Lists the Steps
                    numberedSection(title:"Instructions", items: instructionList.map {$0.step})
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.1))
                //end of VStack
            }
        }
        .onAppear {
            Task {
                print("getDetailedRecipes called")
                //let response = try await service.getDetailedRecipes(id: id)
                let response = service.getMockDetailedRecipes()
                detailedRecipe = response
                
                ingredientList = response.extendedIngredients ?? []
                instructionList = response.analyzedInstructions?.flatMap { $0.steps } ?? []
                
            }
        }
    }
    
    func InformationBox(icon:String, iconColor: Color, value: String, description: String) -> some View {
        VStack{
            Image(systemName: icon)
                .padding(.top,20)
                .foregroundStyle(iconColor)
                .font(.title)
            Text(value)
                .foregroundStyle(Color.black)
                .font(.system(size:20))
            Text(description)
                .padding(.bottom,20)
                .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                .font(.system(size:18))
            
        }
        .padding(5)
        .frame(width:115, height:80)
        .background(RoundedRectangle(cornerRadius:10)
            .foregroundStyle(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius:10)
                    .stroke(Color(red:0.3, green:0.3, blue:0.3), lineWidth:2)
            ))
    }
    
    func numberedSection(title:String, items: [String]) -> some View {
        VStack (alignment:.leading){
            //title
            HStack{
                Text(title)
                    .font(.system(size:26, weight:.bold))
                Spacer()
            }
            .padding(2)
            .padding(.horizontal,7)
        
            //Numbered Section
            VStack (alignment:.leading) {
                ForEach(items.indices, id: \.self) { index in
                    Text("\(Text("\(index + 1). ").bold())\(Text(items[index]))") //String interpolation
                        .font(.system(size:20))
                        .fixedSize(horizontal: false, vertical:true)
                        .multilineTextAlignment(.leading)
                        .padding(1)
                        .padding(.horizontal,10)
                }
            }
            .padding(.bottom,15)
        }
        .padding(5)
        .frame(width:365)
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
