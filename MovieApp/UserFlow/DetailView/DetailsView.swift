//
//  DetailsView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI
//import Kingfisher

// Вью с детальной информацией о фильме
struct DetailsView: View {
    
    var data: MovieModel
    var imageView = UIImageView()
    
    @ObservedObject var dashboardVM : DashboardViewModel
    // Свойство кнопки: через которое будем возвращаться на предыдущий экран
    @Environment(\.presentationMode) var presentationMode
    
    init(data: MovieModel, dashboardVM: DashboardViewModel) {
        self.data = data
        self.dashboardVM = dashboardVM
//        self.imageView.kf.setImage(with: URL(string: Formatter.urlForImage + data.posterPath!))
    }
    
    var body: some View {
        
        ZStack {
            // Poster Image View
            VStack{
                Image(uiImage: imageView.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 1.2), alignment: .top)
                Spacer()
            }
            
            // Top Navigation Bar
            VStack(alignment : .leading) {
                // Navigation bar top buttons: Backward && Down
                HStack {
                    Button(action : {
                        // dissmis current detail view
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 24, weight: .semibold, design: .default))
                            .foregroundColor(.blue)
                            .shadow(color: Color.white.opacity(0.6), radius: 6, x: 0.0, y: 0.0)
                            .padding()
                            .padding(.top, 8)
                    }
                    Spacer()
                    Button(action : {
                        // прикол сохраняем в фотоальбом постер
                        dashboardVM.writeToPhotoAlbum(image: imageView.image!)
                    }){
                        Image(systemName: "arrow.down.circle")
                            .font(.system(size: 26, weight: .semibold, design: .default))
                            .foregroundColor(.blue)
                            .padding()
                            .padding(.top, 8)
                            .shadow(color: Color.white.opacity(0.6), radius: 6, x: 0.0, y: 0.0)
                    }
                }
                Spacer()
            }
            .padding(.top, 8)
            
            // Pan view
            VStack {
                Spacer()
                // Pan View
                VStack {
                    // Description Vstack
                    VStack(alignment : .leading, spacing : 8) {
                        // Title: Shang-Chi ...
                        Text("\(data.title ?? "Title not available")")
                            .font(.system(size: 32, weight: .bold, design: .default))
                        // Genres
                        Text("\(dashboardVM.getGenreString(id: data.genre_ids!))")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(Color.black.opacity(0.5))
                        // Release Date 2021-09-01
                        Text("\(data.releaseDate!)")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(Color.black.opacity(0.5))
                        // Description
                        Text("\(data.overview!)")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .lineSpacing(4)
                            .foregroundColor(Color.black.opacity(0.7))
                            .padding(.top, 4)
                        
                        // BUY TICKET && Progress Bar
                        HStack {
                            Button(action : {}){
                                Text("BUY TICKET")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    
                                    .padding(.horizontal, 32)
                                    .frame(width: nil, height: 46, alignment: .center)
                                    .background(Color.black)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(16)
                                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
                            }
                            Spacer()
                            // Круглый прогресс бар
                            // Выводит рейтинг фильма
                            RatingView(arcAngle: dashboardVM.getTheAcrForProgressBar(data : data), rating: "\(data.voteAverage ?? "0.0")",size: 40)
                        }
                        .padding(.top, 16)
                        .padding(.trailing, 16)
                        
                    }.padding(16)
                }.padding()
                .frame(width: UIScreen.main.bounds.width, height: nil, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(50, corners: [.topLeft, .topRight])
                
                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0.0, y: 0.0)
            }.frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height - 200, alignment: .top)
            .offset(x: 0, y: 100)
        }
        .alert(isPresented: $dashboardVM.imageSaved) {
            Alert(title: Text("Image Saved"), message: Text("Image for this movie is saved in your photos"), dismissButton: .default(Text("Ok")))
        }
        .ignoresSafeArea()
    }
}
