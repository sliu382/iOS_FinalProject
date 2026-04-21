//
//  MealPlannerPageView.swift
//  iOS_Final_Project
//
//  Created by Siyu Liu on 4/16/26.
//

import SwiftUI

struct MealPlannerPageView: View {
    let service: MealPlanService = MealPlanService()
    @Binding var weekDays: WeekDays?
    
    @State var day: [MealPlan] = []
    let week = ["Mon", "Tues", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @State var dayNum: [Int] = []
    
    @State var selectedIndex: Int? = nil
    
    var body: some View {
        NavigationStack {
            //Title for the page
            HStack{
                Text("Meal Planner")
                    .font(.system(size:30,weight:.bold))
                Spacer()
            }
            .padding(.horizontal,28)
            
            VStack{
                
                //Top Horizontal List View of all the day's ina  week
                HStack {
                    ForEach(day.indices, id:\.self) { index in
                        Button {
                            selectedIndex = index
                        } label: {
                            //Changes dependong on button clicked
                            DateBox(day: week[index], dayNum: dayNum[index], clicked: selectedIndex==index)
                        }
                    }
                }
                //shows the EachDayView when the box is clicked
                if let index = selectedIndex {
                    EachDayView(day: $day[index])
                }

            }

        }
        .onAppear {
            Task{
                print("getMealPlan called")
                //let response = try await service.getMealPlan()
                //***let response = service.getMockMealPlan()
                //weekDays = response
                    
                if let weekDays {
                    day = [weekDays.monday, weekDays.tuesday, weekDays.wednesday, weekDays.thursday, weekDays.friday, weekDays.saturday, weekDays.sunday]
                }
                dayNum = getWeekDates()
            }
        }
    }
    /** Uses SwiftUI's built in methods to find the current week's dates.*/
    func getWeekDates() -> [Int] {
        var dates:[Int] = []
        
        let cal = Calendar.current
        let today = Date()
        let startOfWeek = cal.dateInterval(of: .weekOfYear, for: today)!.start
        
        for offset in 0..<7 {
            let date = cal.date(byAdding: .day, value: offset, to: startOfWeek)!
            let dayNum = cal.component(.day, from: date)
            dates.append(dayNum)
        }
        return dates
    }
    
    /**Formats a box with parameters of the day, the actual date's numerical value, and whether the button was clicked.**/
    func DateBox(day:String, dayNum: Int, clicked: Bool) -> some View {
        let textColor: Color
        let backgroundColor: Color
        if clicked {
            textColor = Color.white
            backgroundColor = Color.blue
        } else {
            textColor = Color.black
            backgroundColor = Color.white
        }
        
        return VStack{
            Text(day)
                .font(.system(size: 10))
            Text(String(dayNum))
                .font(.system(size:15, weight:.bold))
        }
        .foregroundStyle(textColor)
        .padding(5)
        .frame(width:45, height:50)
        .background(RoundedRectangle(cornerRadius:10)
            .foregroundStyle(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius:10)
                    .stroke(Color(red:0.3, green:0.3, blue:0.3), lineWidth:2)
            ))
    }
}

#Preview {
    //MealPlannerPageView()
}
