class Trailer {
  final String title;
  final String duration;
  final String thumbnailUrl;
  final String youtubeUrl;

  const Trailer({
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
    required this.youtubeUrl,
  });
}

class Movie {
  final String id;
  final String title;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final double rating;
  final List<String> genres;
  final List<Trailer> trailers;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.rating,
    required this.genres,
    required this.trailers,
    this.isFavorite = false,
  });
}

final List<Movie> sampleMovies = [
  Movie(
    id: '1',
    title: 'Inception',
    overview: 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O., but his tragic past may doom the project.',
    posterUrl: 'https://image.tmdb.org/t/p/w500/o07wMNjCYm7yBBja6nWrBF40nCM.jpg',
    backdropUrl: 'https://image.tmdb.org/t/p/original/8Zg66q92A1W7714pMwf2F8jD3tA.jpg',
    rating: 8.8,
    genres: ['Sci-Fi', 'Action', 'Thriller'],
    trailers: [
      const Trailer(
        title: 'Official Main Trailer',
        duration: '2:24',
        thumbnailUrl: 'https://image.tmdb.org/t/p/w500/8Zg66q92A1W7714pMwf2F8jD3tA.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=YoHD9XEInc0',
      ),
      const Trailer(
        title: 'Teaser Trailer',
        duration: '1:32',
        thumbnailUrl: 'https://image.tmdb.org/t/p/w500/o07wMNjCYm7yBBja6nWrBF40nCM.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=8hP9D6kZseM',
      ),
    ],
  ),
  Movie(
    id: '2',
    title: 'Interstellar',
    overview: 'The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.',
    posterUrl: 'https://image.tmdb.org/t/p/w500/gEU2QvIPwc3Hzv1820HLvbgf2AO.jpg',
    backdropUrl: 'https://image.tmdb.org/t/p/original/xJHokZbljvjC1OcfoWv2VMZ54ti.jpg',
    rating: 8.7,
    genres: ['Sci-Fi', 'Drama', 'Adventure'],
    trailers: [
      const Trailer(
        title: 'Official Trailer 3',
        duration: '2:33',
        thumbnailUrl: 'https://image.tmdb.org/t/p/w500/xJHokZbljvjC1OcfoWv2VMZ54ti.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=zSWdZVtXT7E',
      ),
      const Trailer(
        title: 'Hearts and Minds Featurette',
        duration: '5:12',
        thumbnailUrl: 'https://image.tmdb.org/t/p/w500/gEU2QvIPwc3Hzv1820HLvbgf2AO.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=lclZ4ePus0Q',
      ),
    ],
  ),
  Movie(
    id: '3',
    title: 'The Dark Knight',
    overview: 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
    posterUrl: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDg92StatusmIY55ZGS.jpg',
    backdropUrl: 'https://image.tmdb.org/t/p/original/nMK4285v7w21980v43G4nCYmZ48.jpg',
    rating: 9.0,
    genres: ['Action', 'Crime', 'Drama'],
    trailers: [
      const Trailer(
        title: 'Main Trailer HD',
        duration: '2:17',
        thumbnailUrl: 'https://image.tmdb.org/t/p/w500/nMK4285v7w21980v43G4nCYmZ48.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=EXeTwQWrcwY',
      ),
    ],
  ),
  Movie(
    id: '4',
    title: 'Spider-Man: Into the Spider-Verse',
    overview: 'Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.',
    posterUrl: 'https://image.tmdb.org/t/p/w500/iiJy61fbzm60V5aK0gh9y683wBF.jpg',
    backdropUrl: 'https://image.tmdb.org/t/p/original/bL74n3kw4876X6Jg5i5p5979xJ2.jpg',
    rating: 8.4,
    genres: ['Animation', 'Action', 'Adventure'],
    trailers: [
      const Trailer(
        title: 'Official Trailer 1',
        duration: '2:52',
        thumbnailUrl: 'https://image.tmdb.org/t/p/w500/bL74n3kw4876X6Jg5i5p5979xJ2.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=g4HbzUK12dk',
      ),
      const Trailer(
        title: 'Sneak Peek Teaser',
        duration: '1:58',
        thumbnailUrl: 'https://image.tmdb.org/t/p/w500/iiJy61fbzm60V5aK0gh9y683wBF.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=tg52up16eq0',
      ),
    ],
  ),
  Movie(
    id: '5',
    title: 'Avatar: The Way of Water',
    overview: 'Jake Sully lives with his newfound family formed on the extraterrestrial moon Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
    posterUrl: 'https://image.tmdb.org/t/p/w500/t6z8hp702XYreJz7Wk8Es6IYdGk.jpg',
    backdropUrl: 'https://image.tmdb.org/t/p/original/v859424eX9858u32.jpg',
    rating: 7.6,
    genres: ['Sci-Fi', 'Action', 'Adventure'],
    trailers: [
      const Trailer(
        title: 'Official Trailer',
        duration: '2:29',
        thumbnailUrl: 'https://image.tmdb.org/t/p/w500/vHQV2n1P17822vR3K.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=d9MyW72ELq0',
      ),
    ],
  ),
];
