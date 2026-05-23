abstract class Shape {
  double get area;
}

class Rectangle implements Shape {
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
  @override
  double get area => _width * _height;
}

class Square extends Shape {
  double _side = 0.0;
  void setSide(double side) {
    _side = side;
  }

  @override
  double get area => _side * _side;
}
