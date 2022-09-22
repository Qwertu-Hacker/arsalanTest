//
//  InHabit.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 15.09.2022.
//

import SwiftUI

struct InHabit: View {
    @ObservedObject var inHabitViewModel = InHabitViewModel()
    @ObservedObject var habitModel: HabitViewModel
    
    let habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
        self.habitModel = HabitViewModel()
    }
    var percent: CGFloat = 50
    let multiplayer: CGFloat = 360 / 100
    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack(spacing: 5) {
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.05))
                            .padding(-40)
                        
                        Circle()
                            .trim(from: 0, to: inHabitViewModel.progress)
                            .stroke(.white.opacity(0.03), lineWidth: 80)
                        
                        Circle()
                            .stroke(Color.purple, lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-2)
                        
                        Circle()
                            .fill(.black)
                        
                        Circle()
                            .trim(from: 0, to: inHabitViewModel.progress)
                            .stroke(Color.purple.opacity(0.7),lineWidth: 10)
                        
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 30, height: 30, alignment: .center)
                                .overlay(content: {
                                    Circle()
                                        .fill(.white)
                                        .padding(5)
                                })
                                .frame(width: size.width, height: size.height, alignment: .center)
                                .offset(x: size.height / 2)
                                .rotationEffect(.init(degrees: inHabitViewModel.progress * 360))
                        }
                        
                        Text(inHabitViewModel.timerString)
                            .foregroundColor(Color.white)
                            .font(.system(size: 45, weight: .light))
                            .rotationEffect(.init(degrees: -90))
                            .animation(.none, value: inHabitViewModel.progress)
                    }
                    .padding(25)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: inHabitViewModel.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Button {
                        if inHabitViewModel.isStarted {
                            
                        } else {
                            inHabitViewModel.addNewTimer = true
                        }
                    } label: {
                        Image(systemName: !inHabitViewModel.isStarted ? "timer": "pause")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color.white)
                            .frame(width: 80, height: 80, alignment: .center)
                            .background {
                                Circle()
                                    .fill(Color.purple)
                            }
                            .shadow(color: Color.purple, radius: 15, x: 0, y: 0)
                    }
                    
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .toolbar {
         
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    habitModel.editHabit = habit
                    habitModel.restoreEditDate()
                    habitModel.changeHabit.toggle()
                } label: {
                    Image(systemName: "gearshape")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
        }
        
        .padding()
        .background {
            Color.black
                .ignoresSafeArea()
        }
        .sheet(isPresented: $habitModel.changeHabit) {
            habitModel.reseteDate()
        } content: {
            AddNewHabit()
                .environmentObject(habitModel)
        }
    }

}

//struct InHabit_Previews: PreviewProvider {
//    static var previews: some View {
//        InHabit()
//    }
//}
