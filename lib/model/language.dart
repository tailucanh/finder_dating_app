class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇻🇳", "Vietnamese", "vi"),
      Language(3, "🇱🇦", "Laos", "lo"),
      Language(4, "🇮🇩", "Indonesia", "id"),
      Language(5, "🇪🇸", "Spanish", "es"),
      Language(6, "🇮🇳", "Indian", "hi"),
      Language(7, "🇨🇳", "中国语", "zh"),
      Language(8, "🇯🇵", "日本語", "ja"),
    ];
  }
}
