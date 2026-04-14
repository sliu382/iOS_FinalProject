//
//  RecipeView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/13/26.
//

import SwiftUI

struct RecipeView: View {
    let service: RecipeService = RecipeService()
    //@Binding var id: Int
    var recipe: Recipe
    //@State var detailedRecipe: DetailedRecipe?
    
    var body: some View {
        HStack{
            if let imageLink = recipe.image {
                AsyncImage(url: URL(string: imageLink)) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                } placeholder: { //what shows while image is loading
                    Color.gray.opacity(0.1)
                }
                    
            } else {
                Text("No Image Available")
            }
            
            VStack (alignment: .leading){
                Text(recipe.title)
                    .font(.system(size:20, weight:.bold))
                Spacer()
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
        //.frame(maxWidth: .infinity, maxHeight:.infinity)
        .frame(width:375, height:100)
        .padding(.vertical, 8)
    }
}

#Preview {
    let recipe1: Recipe = Recipe(id:644387,title: "Garlicky Kale", image: "https://img.spoonacular.com/recipes/644387-312x231.jpg", imageType: "jpg", readyInMinutes: 100, servings: 5)
    RecipeView(recipe: recipe1)
}

//"id": 644387,
//"title": "Garlicky Kale",
//"image": "https://img.spoonacular.com/recipes/644387-312x231.jpg",
//"imageType": "jpg"


//struct Recipe: Identifiable, Codable {
//    let id: Int
//    let title: String
//    let image: String?
//    let imageType: String?
//    let servings: Int?
//    let readyInMinutes: Int?
//    let cookingMinutes: Int?
//    let sourceUrl: String?
//    let healthScore: Float?
//    let cuisines: [String]?
//}


//if let imageLink = recipe.image {
//    AsyncImage(url: URL(string: imageLink))
//} else {
//    //Image("noImage.png")
//    Text("No Image")
//}
