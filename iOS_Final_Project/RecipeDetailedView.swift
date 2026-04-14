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
    var body: some View {
        NavigationStack {
            VStack{
                if let dr = detailedRecipe, let imageLink = dr.image{
                    AsyncImage(url: URL(string: imageLink)) { image in
                        image
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFit()
                    } placeholder: { //what shows while image is loading
                        Color.gray.opacity(0.1)
                    }
                        
                } else {
                    Text("No Image Available")
                }
                
                HStack{
                    //time
                    VStack{
                        if let dr = detailedRecipe, let time = dr.readyInMinutes {
                            Image(systemName: "clock")
                            Text(service.formatTime(time: time))
                        }
                    }
                    .background(RoundedRectangle(cornerRadius:5)
                        .foregroundStyle(Color.white))
                    
                    //Servings
                    VStack{
                        
                    }
                    
                    //Items
                    VStack{
                        
                    }
                }
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
            }
        }
        
    }
    
}

#Preview {
    RecipeDetailedView(id:100)
}
