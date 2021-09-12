//
//  NowPlayingMoviedView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI

struct NowPlayingMoviedView: View {
    
    @ObservedObject var dashboardVM: DashboardViewModel
    
    @FetchRequest(entity: NowPlaying.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \NowPlaying.timeStamp, ascending: true)])
    
    var nowPlayingMovies: FetchedResults<NowPlaying>
    
    @State var imageLoded = false
    @State var presentDetailsView = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text("\(MovieEndpoint.nowPlaying.description)")
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding(.leading, 20)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing : 20) {
                    if nowPlayingMovies.count > 0 {
                        ForEach(nowPlayingMovies) { item in
                            ForEach(item.nowPlayingMovie!) { value in
                                GeometryReader { geometry in
                                    
                                    LargeCardView(value: value, nowPlayingMovies: nowPlayingMovies, dashboardVM: dashboardVM)
                                        .rotation3DEffect(Angle(degrees:
                                                                    Double(geometry.frame(in: .global).minX - 30) / -20
                                        ), axis: (x: 0, y: 10.0, z: 0))
                                    
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width / 1.4, height: (UIScreen.main.bounds.height / 1.7) + 120, alignment: .top)
                                .onTapGesture {
                                    presentDetailsView = true
                                }
                            }
                        }
                        
                    }
                }
                .padding(.leading, 24)
            }
            .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 1.7) + 120, alignment: .top)
        }
    }
}


//struct NowPlayingMoviedEndPointView_Previews: PreviewProvider {
//    static var previews: some View {
//        NowPlayingMoviedView()
//    }
//}
