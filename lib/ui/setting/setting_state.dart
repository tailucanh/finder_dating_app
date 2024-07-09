part of 'setting_cubit.dart';

class SettingState extends Equatable {
  final LoadStatus loadStatus;
  final ThemeMode themeMode;
  final Locale locale;
  final Tokens? tokenUser;

  const SettingState({
    this.loadStatus = LoadStatus.initial,
    this.themeMode = ThemeMode.system,
    this.locale = AppConfig.defaultLocal,
    this.tokenUser,
  });

  @override
  List<Object?> get props => [loadStatus,themeMode, locale,tokenUser];

  SettingState copyWith(
      {LoadStatus? loadStatus,
      ThemeMode? themeMode,
      Locale? locale,
        Tokens? tokenUser
      }) {
    return SettingState(
      loadStatus: loadStatus ?? this.loadStatus,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      tokenUser: tokenUser ?? this.tokenUser,
    );
  }
}
