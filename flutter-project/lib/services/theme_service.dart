abstract interface class ThemeService {
  bool get isDarkTheme;
  void toggle();
}

final class ThemeServiceImpl implements ThemeService {
  bool _isDarkTheme = false;
  @override
  bool get isDarkTheme => _isDarkTheme;

  @override
  void toggle() => _isDarkTheme = !_isDarkTheme;
}
