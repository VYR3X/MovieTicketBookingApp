//
//  BookingView.swift
//  MovieApp
//
//  Created by v.zhokhov on 10.09.2021.
//

import SwiftUI

struct BookingView: View {
    
    @State var bookedSeats: [Int] = [1, 10, 26, 35, 40]
    @State var selectedSeats: [Int] = []
    
    @State var date: Date = Date()
    @State var selectedTime = "11:30"
    
    // Через эту переменну делаем dismiss
    // https://stackoverflow.com/questions/57036645/swiftui-navigationlink-pop
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            // Навигационный бар горизонтальный <
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                Spacer()
            }
            .overlay(
                Text("Selected sits")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            )
            .padding()
            
            // Curve or Thatre view
            GeometryReader { reader in
                let width = reader.frame(in: .global).width
                
                Path { path in
                    // creating simple curve
                    
                    path.move(to: CGPoint(x: 0, y: 50))
                    
                    path.addCurve(to: CGPoint(x: width, y: 50),
                                  control1: CGPoint(x: width / 2, y: 0),
                                  control2: CGPoint(x: width / 2, y: 0))
                }
                .stroke(Color.gray, lineWidth: 2)
            }
            .frame(height: 50)
            .padding(.top, 20)
            .padding(.horizontal, 35)
            
            // Grid view of seats
            
            // total seats == 60
            // По дизайну там по углам 4 пустых места
             
            let totalSeats = 60 + 4
            
            let leftSide = 0 ..< totalSeats / 2
            let rightSide = totalSeats / 2 ..< totalSeats
            
            HStack(spacing: 30) {
                let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
                
                LazyVGrid(columns: columns, spacing: 13, content: {
                    ForEach(leftSide, id: \.self) { index in
                        // getting correct seats
                        let seat = index >= 29 ? index - 1 : index
                        
                        SeatView(index: index,
                                 seat: seat,
                                 selectedSeats: $selectedSeats,
                                 bookedSeats: $bookedSeats)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                // checking and adding
                                if selectedSeats.contains(seat) {
                                    selectedSeats.removeAll { (removeSeat) -> Bool in
                                        return removeSeat == seat
                                    }
                                    return
                                }
                                // adding ...
                                selectedSeats.append(seat)
                            }
                            // disables if seat is booked
                            .disabled(bookedSeats.contains(seat))
                    }
                })
                
                LazyVGrid(columns: columns, spacing: 13, content: {
                    
                    ForEach(rightSide, id: \.self) { index in
                        let seat = index >= 35 ? index - 2 : index - 1
                        
                        SeatView(index: index,
                                 seat: seat,
                                 selectedSeats: $selectedSeats,
                                 bookedSeats: $bookedSeats)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                // checking and adding
                                if selectedSeats.contains(seat) {
                                    selectedSeats.removeAll { (removeSeat) -> Bool in
                                        return removeSeat == seat
                                    }
                                    return
                                }
                                // adding ...
                                selectedSeats.append(seat)
                            }
                            // disables if seat is booked
                            .disabled(bookedSeats.contains(seat))
                    }
                })
            }
            .padding()
            .padding(.top, 55)
            
            // Горизонтальный стек
            HStack {
                // Booked Seats
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.caption)
                            .foregroundColor(.gray)
                    )
                Text("Booked")
                    .font(.caption)
                    .foregroundColor(.white)
                
                // Available seats
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 20, height: 20)
                
                Text("Available")
                    .font(.caption)
                    .foregroundColor(.white)
                
                // Selected Seats
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                
                Text("Selected")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(.top, 25)
            
            // Date horizontal stack
            HStack {
                Text("Date:")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            .padding(.top)
            
            // Timing in scroll view
            // Collection view == ScrollView + Hstack
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 20) {
                    // перменна time это массив из папки Model
                    ForEach(time, id: \.self) { timing in
                        Text(timing)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal, 30)
                            .background(Color.blue.opacity(selectedTime == timing ? 1 : 0.2))
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedTime = timing
                            }
                            
                    }
                }
                .padding(.horizontal)
            })
            
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("\(selectedSeats.count) Seats")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("$ \(selectedSeats.count * 70)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                })
                .frame(width: 100)
                
                Button(action: {}, label: {
                    Text("But Ticket")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
            }
            .padding()
            .padding(.top, 20)
        })
        .background(Color(.darkGray).ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

// Вьюшка кресла )

struct SeatView: View {
    
    var index: Int
    var seat: Int
    
    @Binding var selectedSeats: [Int]
    @Binding var bookedSeats: [Int]
    
    var body: some View {
        
        ZStack{
             RoundedRectangle(cornerRadius: 6)
                // делам серую обводку креска если место занято
                .stroke(bookedSeats.contains(seat) ? Color.gray : Color.blue, lineWidth: 2)
                .frame(height: 30)
                .background(
                    selectedSeats.contains(seat) ? Color.yellow : Color.clear
                )
            // Скрываем эти 4-ре уресла
                .opacity(index == 0 || index == 28 || index == 35 || index == 63 ? 0 : 1 )
            
            if bookedSeats.contains(seat) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }
        }
    }
    
}


struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
