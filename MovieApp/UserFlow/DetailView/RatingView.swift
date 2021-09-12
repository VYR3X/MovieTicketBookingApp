//
//  RatingView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI

// RatingView ( Progress Bar 8 / 10 )
struct RatingView: View {
    
    @State var arcAngle : CGFloat
    @State var rating : String
    @State var size : CGFloat
    
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: size/2)
                .trim(from: arcAngle, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 3, x: 0, y: 3)
                .frame(width: size, height: size)
            
            
            RoundedRectangle(cornerRadius: size/2)
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5))
                .frame(width: size, height: size)
            
            Text("\(rating)")
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}

struct RatingView_Preview: PreviewProvider {
    static var previews: some View {
        RatingView(arcAngle: 10, rating: "8.0", size: 40)
    }
}
