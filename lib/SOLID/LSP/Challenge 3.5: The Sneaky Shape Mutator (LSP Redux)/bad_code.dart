class Rectangle {
  double _width = 0;
  double _height = 0;

  void setWidth(double width) {
    _width = width;
  }

  void setHeight(double height) {
    _height = height;
  }

  double get width => _width;
  double get height => _height;
  double get area => _width * _height;
}

class Square extends Rectangle {
  @override
  void setWidth(double width) {
    _width = width;
    _height = width; // Enforcing square rules
  }

  @override
  void setHeight(double height) {
    _height = height;
    _width = height; // Enforcing square rules
  }
}
