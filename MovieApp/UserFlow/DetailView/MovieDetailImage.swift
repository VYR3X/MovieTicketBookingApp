//
//  MovieDetailImage.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//

import SwiftUI

/// Картинка фильма на экране с детальной информацией о фильме
struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

//struct MovieDetailImage_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailImage(imageLoader: ImageLoader(), imageURL: <#T##URL#>)
//    }
//}
