part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;

  const AppSettingState({
    this.themeMode = ThemeMode.light,
    this.locale = AppConfig.defaultLocal,
  });

  @override
  List<Object?> get props => [themeMode, locale];

  AppSettingState copyWith({ThemeMode? themeMode, Locale? locale, r}) {
    return AppSettingState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}
