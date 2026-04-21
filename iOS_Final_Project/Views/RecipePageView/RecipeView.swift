//
//  RecipeView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/13/26.
//

import SwiftUI

struct RecipeView: View {
    let service: RecipeService = RecipeService()
    var recipe: Recipe
    
    var body: some View {
        HStack{
            //Image
            if let imageLink = recipe.image {
                //Loads the image corresponding to each recipe
                AsyncImage(url: URL(string: imageLink)) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.trailing,15)
                        .padding(.leading,15)
                } placeholder: { //what shows while image is loading
                    Image("noImage")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.trailing,15)
                        .padding(.leading,15)
                }
                    
            } else {
                Text("No Image Available")
            }
            
            //Title + Info
            VStack (alignment: .leading){
                Text(recipe.title)
                    .font(.system(size:20, weight:.bold))
                Spacer()
                
                //Time + Serving
                HStack (spacing:20){
                    if let time = recipe.readyInMinutes, let servings = recipe.servings
                    {
                        //Prep time
                        HStack{
                            Image(systemName: "clock")
                            Text(service.formatTime(time: time))
                        }
                        
                        //Servings
                        HStack{
                            Image(systemName: "person.2")
                            Text(String(servings))
                        }
                        
                    }
                }
                .padding(.horizontal,0)
                .foregroundStyle(Color.gray)
            }
            Spacer()
            
        }
        .frame(width:375, height:100)
        .padding(.vertical, 8)
    }
}

#Preview {
    let recipe1: Recipe = Recipe(id:644387,title: "Garlicky Kale", image: "https://img.spoonacular.com/recipes/644387-312x231.jpg", imageType: "jpg", readyInMinutes: 100, servings: 5)
    RecipeView(recipe: recipe1)
}
