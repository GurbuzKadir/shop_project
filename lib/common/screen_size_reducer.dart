part of 'common.dart';

extension ScreenSizeReducer on BuildContext {
  /// Container
  dartz.Tuple2<double, double> scale(
          {double scale = 100, bool includeToolbar = false}) =>
      dartz.Tuple2(
          screenWidth(percentage: scale),
          screenHeight(
              percentage: scale,
              reducedBy: includeToolbar ? kToolbarHeight : 0.0));

  double fontSize(double value) => scale(scale: value).value1;

  double circularSize(double value) => fontSize(value);

  /// Sub-Methods
  Size get _screenSize => MediaQuery.of(this).size;

  EdgeInsets get _screenPadding => MediaQuery.of(this).padding;

  double get _safeAreaHorizontal => _screenPadding.left + _screenPadding.right;

  double get _safeAreaVertical => _screenPadding.top + _screenPadding.bottom;

  double screenHeight({double percentage = 100, double reducedBy = 0.0}) =>
      (_screenSize.height - _safeAreaVertical - reducedBy) * (percentage / 100);

  double screenWidth({double percentage = 100, double reducedBy = 0.0}) =>
      (_screenSize.width - _safeAreaHorizontal - reducedBy) *
      (percentage / 100);
}
