/// A podcast show ("Artist Playlist" screen in the KiTalk design).
class Show {
  const Show({
    required this.id,
    required this.title,
    required this.artist,
    required this.cover,
    required this.backdrop,
    required this.about,
    required this.episodes,
  });

  final String id;
  final String title;
  final String artist;
  final String cover;
  final String backdrop;
  final String about;
  final List<Episode> episodes;
}

/// A single episode. [progress] is 0..1 and drives the "Continue Listening" bar.
class Episode {
  const Episode({
    required this.id,
    required this.showId,
    required this.showTitle,
    required this.number,
    required this.title,
    required this.cover,
    required this.description,
    required this.minutesLeft,
    this.showArtist = '',
    this.progress = 0,
  });

  final String id;
  final String showId;
  final String showTitle;
  final String showArtist;
  final int number;
  final String title;
  final String cover;
  final String description;
  final int minutesLeft;
  final double progress;
}

/// A browse tile on the Search screen. [column] is the masonry column (0 = left);
/// [tall] marks the hero "Top 10" tile that spans two normal rows.
class BrowseCategory {
  const BrowseCategory(this.name, this.image, {this.subtitle, this.column = 0, this.tall = false});

  final String name;
  final String image;
  final String? subtitle;
  final int column;
  final bool tall;
}
