import 'package:flutter_web/widgets.dart';

class IconDataBrands extends IconData {
  const IconDataBrands(int codePoint)
      : super(
    codePoint,
    fontFamily: 'FontAwesomeBrands',
  );
}

class IconDataSolid extends IconData {
  const IconDataSolid(int codePoint)
      : super(
    codePoint,
    fontFamily: 'FontAwesomeSolid',
  );
}

class IconDataRegular extends IconData {
  const IconDataRegular(int codePoint)
      : super(
    codePoint,
    fontFamily: 'FontAwesomeRegular',
  );
}