//
//  ContentView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/12/26.
//

import SwiftUI

struct ContentView: View {
    @State var isRecipePageOpen: Bool = true
    @State var isMealPlannerPageOpen: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                if isRecipePageOpen {
                    RecipesListView()
                } else {
                    MealPlannerPageView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Button {
                        isRecipePageOpen = true
                        isMealPlannerPageOpen = false
                    } label: {
                        //Image(systemName:"magnifyingglass")
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
    }
    
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
