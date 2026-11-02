import 'models.dart';

const String _a = 'assets/img/';

/// Everything the UI needs, hardcoded from the KiTalk design copy so the app
/// runs without a backend. Swap this file for a repository to go live.
class KtData {
  const KtData._();

  static const String avatar = '${_a}avatar_kitani.png';
  static const String hero = '${_a}photo_hero.png';
  static const String premiumBackdrop = '${_a}bg_premium.png';

  static const List<Episode> newEpisodes = [
    Episode(
      id: 'pivot-11',
      showId: 'pivot',
      showTitle: 'Pivot',
      number: 11,
      title: 'The new COVID stimulus and',
      cover: '${_a}cover_pivot.png',
      description:
          'Kara and Scott break down the newest relief package and what it '
          'actually changes for small businesses.',
      minutesLeft: 41,
    ),
    Episode(
      id: 'ft-22',
      showId: 'ft-news',
      showTitle: 'FT News Briefing',
      number: 22,
      title: 'Martin Wolf looks back at',
      cover: '${_a}cover_ft_news.png',
      description:
          'Martin Wolf on the economic lessons of the past year and the risks '
          'still on the table.',
      minutesLeft: 12,
    ),
    Episode(
      id: 'ux-129',
      showId: 'ux-podcast',
      showTitle: 'UX Podcast',
      number: 129,
      title: 'Touching Screens',
      cover: '${_a}cover_uxpodcast.png',
      description:
          'How haptics, gesture and voice reshape the way we think about '
          'interface craft.',
      minutesLeft: 33,
    ),
  ];

  static const Show fearlessTalks = Show(
    id: 'fearless-talks',
    title: 'Fearless Talks',
    artist: 'Kim King',
    cover: '${_a}cover_fearless_talks.png',
    backdrop: '${_a}bg_show.png',
    about:
        'The official podcast of the miniseries Chernobyl, from HBO and Sky. '
        'Join host Peter Sagal (NPR’s “Wait Wait...Don\'t Tell Me!”) and… ',
    episodes: [
      Episode(
        id: 'fearless-12',
        showId: 'fearless-talks',
        showTitle: 'Fearless Talk',
        showArtist: 'Kim King',
        number: 12,
        title: 'For the Sake of Fearless',
        cover: '${_a}cover_for_the_sake.png',
        description:
            'For The Sake Of is a podcast about faith, life and what it all '
            'means. Join host Sister Kim King, a Religious of the Sacred Heart, '
            'as she engages in conversations with individuals connected',
        minutesLeft: 28,
        progress: .62,
      ),
      Episode(
        id: 'fearless-11',
        showId: 'fearless-talks',
        showTitle: 'Fearless Talk',
        showArtist: 'Kim King',
        number: 11,
        title: 'Intimate Knowladge',
        cover: '${_a}cover_intimate_knowledge.png',
        description:
            'Intimate Knowledge with Brooke Burke and Meghan King Edmonds and '
            'sex and intimacy coach Lila Darville covers EVERYTHING '
            'intimacy, sex and relationships.',
        minutesLeft: 36,
      ),
      Episode(
        id: 'fearless-10',
        showId: 'fearless-talks',
        showTitle: 'Fearless Talk',
        showArtist: 'Kim King',
        number: 10,
        title: 'Women’s History Month',
        cover: '${_a}cover_womens_history.png',
        description:
            'Celebrate Women\'s History Month with shows that highlight '
            'women\'s global, political, cultural, economic, and social '
            'achievements across industries.',
        minutesLeft: 24,
        progress: .74,
      ),
      Episode(
        id: 'fearless-9',
        showId: 'fearless-talks',
        showTitle: 'Fearless Talk',
        showArtist: 'Kim King',
        number: 9,
        title: 'Mommy Doomsday',
        cover: '${_a}cover_mommy_doomsday.png',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting '
            'industry. Lorem Ipsum has been the industry\'s ',
        minutesLeft: 45,
      ),
    ],
  );

  static Episode get nowPlaying => fearlessTalks.episodes[2];
  static Episode get continueListening => fearlessTalks.episodes.first;

  static const List<Show> laughRow = [
    Show(
      id: 'hollywood',
      title: 'Hollywood, The Sequel',
      artist: 'KPCC',
      cover: '${_a}cover_hollywood.png',
      backdrop: '${_a}bg_show.png',
      about: 'Hollywood is broken. Let\'s fix it.',
      episodes: [],
    ),
    Show(
      id: 'scattered',
      title: 'Scattered',
      artist: 'WNYC Radio',
      cover: '${_a}cover_scattered.png',
      backdrop: '${_a}bg_show.png',
      about: 'Stories that do not stay in their lane, from WNYC Studios.',
      episodes: [],
    ),
    Show(
      id: 'south-side',
      title: 'South Side Stories',
      artist: 'WBEZ',
      cover: '${_a}cover_south_side.png',
      backdrop: '${_a}bg_show.png',
      about: 'Chicago\'s South Side, reported from the inside.',
      episodes: [],
    ),
  ];

  static const List<Show> designResults = [
    Show(
      id: 'design-diaries',
      title: 'The Design Diaries',
      artist: 'Alyssa Nguyen',
      cover: '${_a}cover_design_diaries.png',
      backdrop: '${_a}bg_show.png',
      about: 'A working designer\'s notebook, read out loud.',
      episodes: [],
    ),
    Show(
      id: 'by-design',
      title: 'By Design',
      artist: 'Abstract',
      cover: '${_a}cover_by_design.png',
      backdrop: '${_a}bg_show.png',
      about: 'The ideas behind the products you use every day.',
      episodes: [],
    ),
    Show(
      id: 'ux-growth',
      title: 'UX Design & Personal Growth',
      artist: 'Jason Ogle',
      cover: '${_a}cover_ux_growth.png',
      backdrop: '${_a}bg_show.png',
      about: 'Craft and confidence for designers at every level.',
      episodes: [],
    ),
    Show(
      id: 'indesign-secrets',
      title: 'InDesign Secrets',
      artist: 'Blatner and Concepcion',
      cover: '${_a}cover_indesign_secrets.png',
      backdrop: '${_a}bg_show.png',
      about: 'Two typesetters, one layout app, endless shortcuts.',
      episodes: [],
    ),
    Show(
      id: 'content-design',
      title: 'Content Design Podcast',
      artist: 'Vanessa Barlow',
      cover: '${_a}cover_content_design.png',
      backdrop: '${_a}bg_show.png',
      about: 'Designing the words as carefully as the screens.',
      episodes: [],
    ),
  ];

  static const List<Show> educationalPopular = [
    Show(
      id: 'thinking-lsat',
      title: 'Thinking LSAT',
      artist: 'Nathan Fox',
      cover: '${_a}cover_thinking_lsat.png',
      backdrop: '${_a}bg_show.png',
      about: 'A different way to think about logic games.',
      episodes: [],
    ),
    Show(
      id: 'teachers-in-america',
      title: 'Teachers in America',
      artist: 'HMH',
      cover: '${_a}cover_teachers_america.png',
      backdrop: '${_a}bg_show.png',
      about: 'The people inside the classroom, in their own words.',
      episodes: [],
    ),
    Show(
      id: 'econ-talk',
      title: 'Econ Talk',
      artist: 'WBEZ',
      cover: '${_a}cover_econ_talk.png',
      backdrop: '${_a}bg_show.png',
      about: 'Conversations for the curious about markets and money.',
      episodes: [],
    ),
  ];

  static const List<Episode> favouriteEpisodes = [
    Episode(
      id: 'fav-12',
      showId: 'fearless-talks',
      showTitle: 'Fearless Talk',
      showArtist: 'Kim King',
      number: 12,
      title: 'For the Sake of Fearless',
      cover: '${_a}cover_for_the_sake.png',
      description:
          'For The Sake Of is a podcast about faith, life and what it all '
          'means. Join host Sister Kim King, a Religious of the Sacred Heart, '
          'as she engages in conversations with individuals connected',
      minutesLeft: 28,
    ),
    Episode(
      id: 'fav-3',
      showId: 'content-design',
      showTitle: 'Content Design Podcast',
      number: 3,
      title: 'Work smarter and faster with these..',
      cover: '${_a}cover_content_design.png',
      description:
          'Are you inundated with emails requesting content? Do you spend ages '
          'going through different data sources?',
      minutesLeft: 19,
    ),
    Episode(
      id: 'fav-2',
      showId: 'content-design',
      showTitle: 'Content Design Podcast',
      number: 2,
      title: 'Kicking off a digital content design..',
      cover: '${_a}cover_content_design.png',
      description:
          'Want to introduce content design to your organisation? Jack '
          'Garfinkel chats about how he did just that at Scope.',
      minutesLeft: 26,
    ),
    Episode(
      id: 'fav-9',
      showId: 'design-diaries',
      showTitle: 'The Design Diaries',
      number: 9,
      title: 'Instagram Marketing 101',
      cover: '${_a}cover_design_diaries.png',
      description:
          'For The Sake Of is a podcast about faith, life and what it all means.',
      minutesLeft: 31,
    ),
  ];

  static const List<BrowseCategory> browseCategories = [
    BrowseCategory('Top 10', '${_a}cat_top10.png',
        subtitle: 'Podcast this week', tall: true),
    BrowseCategory('News & Politics', '${_a}cat_news.png'),
    BrowseCategory('Society & Cultural', '${_a}cat_society.png'),
    BrowseCategory('Music', '${_a}cat_music.png'),
    BrowseCategory('Comedy', '${_a}cat_comedy.png', column: 1),
    BrowseCategory('Stories', '${_a}cat_stories.png', column: 1),
    BrowseCategory('Sports', '${_a}cat_sports.png', column: 1),
    BrowseCategory('Educational', '${_a}cat_educational.png', column: 1),
    BrowseCategory('Art', '${_a}cat_art.png', column: 1),
  ];

  static const List<String> homeCategoryTiles = [
    'Top Podcast',
    'Stories',
    'Comedy',
    'Entertainment',
  ];
}
