//
//  MovieModel.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//

import Foundation

/// Ответ от сервера с результатом в виде списка фильмов
struct MovieResponse: Decodable {
    let results: [Movie]
}

/// Модель фильма
struct Movie: Decodable {
    
    /// Id фильма
    let id: Int
    /// Назване фильма
    let title: String
    /// путь к URL  для горизонтального постера
    let backdropPath: String?
    /// путь к URL  для вертикального постера
    let posterPath: String?
    /// Описание
    let overview: String
    /// Средняя оценка зрителя
    let voteAverage: Double
    /// ХЗ может
    let voteCount: Int
    /// Продолжительность в минутах
    let runtime: Int?
    let releaseDate: String?
    
    /// Массив жаноров фильма
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    /// Получаем продолжительность фильма в часах и минутах
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    /// URL  для горизонтального постера
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    // URL  для вертикального постера
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    /// Жанр фильма
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    /// Рейтинг ввиде звездочек
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    /// Рейтинг: 10 / 10
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    /// Средний рейтинг фильма 
    var averageRating: String {
        return String("\(voteAverage)".prefix(3))
    }
    
    /// Год выпуска фильма
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    /// Продолжительность фильма
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    /// В главных ролях
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    /// Команда
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    /// Режиссеры
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    /// Продюсеры
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
    
    /// Сценаристы
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }
    
    /// Ссылки на трейлеры фильма ( может быть несколько видео метериалов у одного фильма )
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
}


// MARK: - Hashable

extension Movie: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


// MARK: - Identifiable

extension Movie: Identifiable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}

/// Жанр фильма
struct MovieGenre: Decodable {
    /// Название жанра
    let name: String
}


// MARK: - MovieCredit

/// Актерский состав + Команда
struct MovieCredit: Decodable {
    /// Актерский состав
    let cast: [MovieCast]
    /// Команда
    let crew: [MovieCrew]
}

/// Актерский состав фильма
struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

/// Команда фильма
struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}


// MARK: - MovieVideoResponse

/// Ответ от сервера с результатом в виде списка трейлеров
struct MovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

/// Модель трейлера фильма
struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    /// URL видео ролика с YouTube
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}

