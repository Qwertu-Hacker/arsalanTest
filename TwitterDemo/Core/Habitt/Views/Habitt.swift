//
//  Habit.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 08.09.2022.
//

import SwiftUI
//import CoreData

struct Habitt: View {
    @FetchRequest(entity: Habit.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Habit.dateAdded, ascending: false)], predicate: nil, animation: .easeInOut) var habits: FetchedResults<Habit>
    
    @StateObject var habitModel: HabitViewModel = .init()
    var percent: CGFloat = 50
    let multiplayer: CGFloat = 360 / 100
    
    var body: some View {
        VStack(spacing: 0) {
            
            ScrollView(habits.isEmpty ? .init() : .vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(habits) { habit in
                        NavigationLink {
                            InHabit(habit: habit)
                        } label: {
                        HabitCardView(habit: habit)
                        }
                    }
                    // MARK: Add Habit Button
                    Button {
                        habitModel.addNewHabit.toggle()
                    } label: {
                        Label {
                            Text("Add new habit")
                        } icon: {
                            Image(systemName: "plus.circle")
                        }
                        .font(.callout.bold())
                        .foregroundColor(.black)
                    }
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Habits")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity)
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "gearshape")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
//        .fullScreenCover(isPresented: $habitModel.adddNewHabit) {
//
//        } content: {
//            InHabit()
//        }
        .sheet(isPresented: $habitModel.addNewHabit) {
            habitModel.reseteDate()
        } content: {
            AddNewHabit()
                .environmentObject(habitModel)
        }
    }
    func HabitCardView(habit: Habit) -> some View {
        VStack(spacing: 6) {
            HStack {
                Text(habit.title ?? "")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(Color.black)
                                    
                Image(systemName: "bell.badge.fill")
                    .font(.callout)
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(Color.black)
                    .scaleEffect(0.9)
                    .opacity(habit.isRemaiderOn ? 1 : 0)
                
                Spacer()
                let count = (habit.weekDays?.count ?? 0)
                Text(count == 7 ? "Everydays" : "\(count) times a week")
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 10)
            HStack {
                Text("\(Int(percent)) %")
                    .foregroundColor(.black)
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            let calendar = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calendar.weekdaySymbols.dropFirst() + [Calendar.current.weekdaySymbols.first!]
            let startDate = currentWeek?.start ?? Date()
            let activeWeekDays = habit.weekDays ?? []
            let activePlot = symbols.indices.compactMap { index -> (String,Date) in
                let currentDate = calendar.date(byAdding: .day, value: index, to: startDate)
                return (symbols[index], currentDate!)
            }
            HStack(spacing: 0) {
                ForEach(activePlot.indices, id: \.self) { index in
                    let item = activePlot[index]
                    
                    VStack(spacing: 6) {
                        Text(item.0.prefix(3))
                            .font(.caption)
                            .foregroundColor(.black)
                        
                        let status = activeWeekDays.contains { day in
                            return day == item.0
                        }
                        Text(getDate(date: item.1))
                            .foregroundColor(status ? Color.white : Color.black)
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(Color.black)
                                    .opacity(status ? 1 : 0)
                            }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 15)
            
        }
        .padding(.vertical)
        .padding(.horizontal, 6)
        .background {
            GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(Color(habit.color ?? "Card-1").opacity(0.1))
                    .frame(width: proxy.size.width, height: 150)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(Color(habit.color ?? "Card-1").opacity(0.8))
                    .frame(width: percent * (proxy.size.width / 100), height: 150)
                }
            }
        }
    }
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}


struct Habitt_Previews: PreviewProvider {
    static var previews: some View {
        Habitt()
    }
}
