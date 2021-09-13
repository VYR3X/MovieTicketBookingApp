//
//  ImageLoader.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//

import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

/// Загрузчик изображений по урлу
class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache

    /// Метод загрузки изображения
    /// Работает асинхронно в background потоке
    /// - Parameter url: адресс изображения в сети
    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        // Локальное кэширование изображения
        // Если изображение уже было сохранено то достаем его
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        // Иначе начинаем загружку
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let self = self else { return }
            
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                // Помещаем загруженное из сети изображение в кеш хранилище по ключу URL
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

