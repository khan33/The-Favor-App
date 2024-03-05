//
//  CustomDatePicker.swift
//  The Favour
//
//  Created by Atta khan on 25/07/2023.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    // month update on arrow button clicks ....
    
    @State var currentMonth: Int = 0
    var body: some View {
        
        VStack(spacing: 35) {
            
            let days: [String] = ["Sun", "Mon", "The", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }

                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                
            }
            .padding(.horizontal)
            
            
            // ... days View
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            
            // .... Dates view
            // .... lazy Grid View
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)

            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background(
                            Circle()
                                .fill(Color.appPrimaryColor)
//                                .padding(4)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            
            
            VStack(spacing: 15) {
                Text("Task")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)

                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: currentDate)
                }) {
                    
                    ForEach(task.task) { task in
                        VStack(alignment: .leading, spacing: 15) {
                            Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
                            
                            Text(task.title)
                                .font(.title2.bold())
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            Color.red.opacity(0.5)
                                .cornerRadius(12)
                        )
                        
                    }
                    
                    
                } else {
                    Text("No Task found.")
                        .font(.callout)
                        .foregroundColor(Color.red)
                }
                
                
            }
            .padding()
            
        }
        .onChange(of: currentMonth) { newValue in
            // ... Updating Month
            currentDate = getCurrentMonth()
        }
        
        
    }
    
    @ViewBuilder
    func CardView(value: DateValue) ->some View {
        VStack {
            
            
            if value.day != -1 {
                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)

                }) {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)

                    Spacer()
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color.appPrimaryColor)
                        .frame(width: 8, height: 8)

                } else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                
                
                
            }
        }
        
        .padding(.vertical)
        .frame(height: 60, alignment: .top)
        
        

    }
    
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extract Year and Month for display ......

    
    
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
        
        
        
    }
    
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        // Getting Current Month date....
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        
        return currentMonth
    }
    
    
    
    func extractDate() -> [DateValue]{
        let calendar = Calendar.current
        // Getting Current Month date....
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            // getting day...
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
            
        // adding offset days to get exact week day
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
        
    }
}

//struct CustomDatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        //BookingView()
//    }
//}


extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        // .... get start date....
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
        
        
        
        
        
    }
}


struct DateValue: Identifiable {
    var id = UUID().uuidString
    let day: Int
    let date: Date
}


struct Task: Identifiable {
    var id = UUID().uuidString
    let title: String
    let time: Date = Date()
}


struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

func getSampleDate(offset: Int) -> Date {
    let calender = Calendar.current
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}



var tasks: [TaskMetaData] = [

TaskMetaData(task: [
    Task(title: "Talk to iJustine"),
    Task(title: "iPhone 13 is great design"),
    Task(title: "Finish Task schedule")

], taskDate: getSampleDate(offset: 1)),


TaskMetaData(task: [
    Task(title: "Talk to Haider"),
    Task(title: "Meeting with client at 1 PM")

], taskDate: getSampleDate(offset: -3)),

TaskMetaData(task: [
    Task(title: "Meeting with Tim cook"),

], taskDate: getSampleDate(offset: -8)),

TaskMetaData(task: [
    Task(title: "Meeting with Tim cook"),

], taskDate: getSampleDate(offset: 0))

]
