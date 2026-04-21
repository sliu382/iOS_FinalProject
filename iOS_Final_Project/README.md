# **EasyMeal**

## Purpose
Meal times can get stressful when your schedule is packed and you have limited time to eat. With EasyMeal, you can quickly search up recipes and add them to your meal plan! EasyMeal will automatically generate a week's meal plan for you. If you do not like some of the meals on it, you can simply delete and add other meals to your calendar!

## APIs + Tools Used
This app utilizes Spoonacular's API to search through recipes and to generate a meal plan.

## Screenshots and Demo Video
![image alt](https://github.com/sliu382/iOS_FinalProject/blob/main/iOS_Final_Project/Screenshot%202026-04-20%20at%2011.00.09%20PM.jpg?raw=true)

![image alt](https://github.com/sliu382/iOS_FinalProject/blob/main/iOS_Final_Project/Screenshot%202026-04-20%20at%2011.25.38%20PM.jpg?raw=true)

![image alt](https://github.com/sliu382/iOS_FinalProject/blob/main/iOS_Final_Project/Screenshot%202026-04-20%20at%2011.03.02%20PM.jpg?raw=true)

## Features Implemented
### Recipe Search
The recipe search page allows for users to search throw Spoonacular's catalog of recipes. Once the user sees a recipe they like, they can click on the recipe. From there, a more detailed page of the recipe will be shown. If the user likes the recipe, they can then click on the add button. The computer then prompts the user to decide the specific day they would like to add the recipe to. After pressing add again, the recipe will be added to their meal plan.
### Meal Planner
When a user enters the meal planner page, seven boxes will show up, each corresponding to one day in the week. The user can then press one of the boxes to see the meal plan for that day. Since the meal planner is designed to automatically generate a recipe for the user, the users are able to delete recipes and add more recipes. To delete a recipe, users can simple swipe left to delete. To add recipes, users can go back to the recipe search.

## Obstacles and Future Improvements
### Obstacles
I had trouble implementing the first page where users can search for recipes. I was struggling to figure out how to connect the model, the RecipeService, and the RecipeListView. After a lot of trial and error, I finally got the individual recipes to show up in the RecipeListView. Once I was able to get information from the API once, I was able to recreate it for the meal plan page. I also had trouble with syncing the Meal Planner to the actual weak, but I figured out how to use SwiftUI's built in method to get the current date and find out the corresponding week. Lastly, I also struggled to implement the "add" button for the recipes because I had to pass in bindings from each view. This overall process got confusing since I had to modify a lot of each of my individual view's to make it work. One other obstacle I had was Spoonacular's limited requests per day with the free plan; I had roughly only 45 requests a day, so I had to create mock data to test my views first. I had to optimize my API calls per day.

### Future Improvements -- login page, shopping cart, maybe to find deals?, show nutrients
To make this app work, a login page is essential for saving each user's individual meal plan. Spoonacular's API has a built in system to connect a user. The app should also add nutrients to each of the displayed recipe information so that individuals can make their meals attuned to their health needs. Most importantly, the app would greatly benefit with a shopping cart section where users can easily identify items they need to buy. This shopping cart page can act like a checklist, making shoppping more efficient and convenient for users. Lastly, the app could also help users find deals on their needed ingredients since inflation and cost of living is rising.

