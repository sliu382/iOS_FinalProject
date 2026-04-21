//
//  ContentView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/12/26.
//

import SwiftUI

struct ContentView: View {
    let service = MealPlanService()
    @State var weekDays: WeekDays?
    
    @State var isRecipePageOpen: Bool = true
    @State var isMealPlannerPageOpen: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                //calls the two pages depending on the state variables
                if isRecipePageOpen {
                    RecipesListView(weekDays: $weekDays)
                } else {
                    MealPlannerPageView(weekDays: $weekDays)
                }
            }
            .safeAreaInset(edge: .bottom) {
                //creates the bottom task bar with the two buttons
                HStack {
                    Button {
                        isRecipePageOpen = true
                        isMealPlannerPageOpen = false
                    } label: {
                        MenuButton(image:"magnifyingglass",isOn: isRecipePageOpen)
                    }
                    
                    Button {
                        isRecipePageOpen = false
                        isMealPlannerPageOpen = true
                    } label: {
                        //Image(systemName:"calendar")
                        MenuButton(image: "calendar", isOn: isMealPlannerPageOpen)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.ignoresSafeArea(edges: .bottom))
            }
        }
        .onAppear {
            Task{
                //calls the API
                print("getMealPlan called")
                let response = try await service.getMealPlan()
                //let response = service.getMockMealPlan()
                weekDays = response
            }
        }
    }
    
    //changes the button look depending on if the current page corresponds with the button
    func MenuButton(image: String, isOn: Bool) -> some View {
        if isOn {
            Image(systemName: (image + ".circle.fill"))
                .foregroundStyle(Color.blue)
                .font(.system(size: 30))
            
        } else {
            Image(systemName: image)
                .foregroundStyle(Color.black)
                .font(.system(size: 30))
        }
    }
}

#Preview {
    ContentView()
}
