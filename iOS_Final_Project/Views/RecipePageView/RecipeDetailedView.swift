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
    
    @Binding var recipe: Recipe
    @Binding var weekDays: WeekDays?
    @State private var showDayPicker: Bool = false
    @State private var selectedDay: String = "Monday"
    var showAddButton: Bool = true
    
    let days = ["Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
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
                            Image("noImage")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .scaledToFit()
                                .cornerRadius(10)
                                .padding(.trailing,15)
                                .padding(.leading,15)
                        }
                        
                        //Name of the recipe
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
                            //Time it takes to prepare
                            if let time = dr.readyInMinutes {
                                InformationBox(icon: "clock", iconColor: Color.red,value: String(service.formatTime(time:time)), description: "Time")
                            }
                            
                            //Number of servings
                            if let servings = dr.servings {
                                InformationBox(icon: "person.2", iconColor: Color.blue,value: String(servings), description: "Servings")
                            }
                            
                            //Number of ingredients
                            if let ingredients = dr.extendedIngredients {
                                InformationBox(icon: "carrot", iconColor: Color.orange, value: String(ingredients.count), description: "Items")
                            }
                            
                        }
                    }
                    
                    //Add to meal plan button
                    if showAddButton { //if the button should be shown or not
                        VStack{
                            Button {
                                showDayPicker = true
                            } label: {
                                Text("Add to Meal Planner")
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 20, weight:.bold))
                                Image(systemName:"plus")
                                    .foregroundStyle(Color.white)
                            } //below is sheet that shows up. User is prompted to choose a day to add the recipe to
                            .sheet(isPresented: $showDayPicker){
                                VStack{
                                    Text("Pick a Day")
                                        .font(.system(size: 20, weight:.bold))
                                        .padding()
                                    Picker("Day", selection: $selectedDay) {
                                        ForEach(days, id:\.self) { day in
                                            Text(day)
                                        }
                                    }
                                    
                                    Button{
                                        addToMealPlan(day: selectedDay)
                                        showDayPicker = false
                                    } label: {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundStyle(Color.blue)
                                            .font(.system(size:25))
                                            .padding()
                                    }
                                }
                            }
                        }
                        .padding(5)
                        .frame(width:365)
                        .background(RoundedRectangle(cornerRadius:10)
                            .foregroundStyle(Color.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius:10)
                                    .stroke(Color(red:0.3, green:0.3, blue:0.3), lineWidth:2)
                            ))
                    }

                    
                    //Lists the Ingredients
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
                let response = try await service.getDetailedRecipes(id: id)
                //let response = service.getMockDetailedRecipes()
                detailedRecipe = response
                
                ingredientList = response.extendedIngredients ?? []
                instructionList = response.analyzedInstructions?.flatMap { $0.steps } ?? []
                
            }
        }
    }
    
    /**Creates a small cubicle box to display information. Uses an icon, icon color, the actual information, and a unit*/
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
    
    /**Uses a for loop to display information in a list format. Information is placed inside a box.**/
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
    
    /**Uses case-switch to determine which array to add the new recipe.**/
    func addToMealPlan(day: String) {
        switch day {
        case "Monday": weekDays?.monday.meals.append(recipe)
        case "Tuesday": weekDays?.tuesday.meals.append(recipe)
        case "Wednesday": weekDays?.wednesday.meals.append(recipe)
        case "Thursday": weekDays?.thursday.meals.append(recipe)
        case "Friday": weekDays?.friday.meals.append(recipe)
        case "Saturday": weekDays?.saturday.meals.append(recipe)
        case "Sunday": weekDays?.sunday.meals.append(recipe)
        default: break
        }
    }
    
}

#Preview {
    //RecipeDetailedView(id:100)
}
