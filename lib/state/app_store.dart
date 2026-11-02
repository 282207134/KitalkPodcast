import 'package:flutter/material.dart';

import '../data/catalog.dart';
import '../data/models.dart';

enum StreamQuality { high, medium, low }

/// Single app-wide store: theme preference, playback, library and profile.
///
/// Intentionally in-memory — the design is a UI kit, so there is no backend to
/// sync against. Every screen reads and mutates through `context.read<KtStore>()`.
class KtStore extends ChangeNotifier {
  KtStore() {
    _queue = KtData.fearlessTalks.episodes;
    _current = KtData.nowPlaying;
    _progress = _current.progress;
  }

  // ---- appearance -------------------------------------------------------
  ThemeMode themeMode = ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    if (mode == themeMode) return;
    themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() => setThemeMode(
      themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);

  // ---- playback ---------------------------------------------------------
  late final List<Episode> _queue;
  late Episode _current;
  double _progress = 0;
  bool _playing = false;
  bool _hasSession = false;

  Episode get current => _current;
  double get progress => _progress;
  bool get playing => _playing;

  /// The mini player only appears after the user has started a session.
  bool get showMiniPlayer => _hasSession;

  void play(Episode episode) {
    _current = episode;
    _progress = episode.progress;
    _playing = true;
    _hasSession = true;
    notifyListeners();
  }

  void togglePlay() {
    _playing = !_playing;
    _hasSession = true;
    notifyListeners();
  }

  void seek(double value) {
    _progress = value.clamp(0, 1);
    notifyListeners();
  }

  void skip(int delta) {
    final next = (_queue.indexOf(_current) + delta) % _queue.length;
    play(_queue[(next + _queue.length) % _queue.length]);
  }

  /// Drives the fake playback ticker from the player screen.
  void tick() {
    if (!_playing) return;
    _progress += 0.0015;
    if (_progress >= 1) skip(1);
    notifyListeners();
  }

  // ---- library ----------------------------------------------------------
  final Set<String> favouriteShows = {
    'design-diaries',
    'by-design',
    'ux-growth',
    'indesign-secrets',
    'content-design',
  };
  final Set<String> favouriteEpisodes = {'fav-12', 'fav-3', 'fav-2', 'fav-9'};

  bool isFavouriteShow(String id) => favouriteShows.contains(id);
  bool isFavouriteEpisode(String id) => favouriteEpisodes.contains(id);

  void toggleFavouriteShow(String id) {
    favouriteShows.contains(id)
        ? favouriteShows.remove(id)
        : favouriteShows.add(id);
    notifyListeners();
  }

  void toggleFavouriteEpisode(String id) {
    favouriteEpisodes.contains(id)
        ? favouriteEpisodes.remove(id)
        : favouriteEpisodes.add(id);
    notifyListeners();
  }

  // ---- profile & settings ----------------------------------------------
  String name = 'Kitani Sarasvati';
  String email = 'kitani@mail.com';
  String phone = '+65 432135';
  bool premium = false;
  bool notifications = true;
  StreamQuality quality = StreamQuality.medium;
  String language = 'English';

  void saveProfile({String? name, String? email, String? phone}) {
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.phone = phone ?? this.phone;
    notifyListeners();
  }

  void setQuality(StreamQuality value) {
    quality = value;
    notifyListeners();
  }

  void setNotifications(bool value) {
    notifications = value;
    notifyListeners();
  }

  void goPremium() {
    premium = true;
    notifyListeners();
  }
}
