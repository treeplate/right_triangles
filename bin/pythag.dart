import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  if (arguments.isNotEmpty && arguments.contains('-dist')) {
    assert(!arguments.contains('-fromcb') || !arguments.contains('-points'),
        '-points makes no sense for -fromcb');
    assert(!arguments.contains('-fromcb') || !arguments.contains('-3d'),
        '-3d makes no sense for -fromcb');
    assert(!arguments.contains('-perimeter') || arguments.contains('-points'),
        '-perimeter makes no sense for lengths');
    assert(!arguments.contains('-perimeter') || !arguments.contains('-fromcb'),
        '-perimeter makes no sense for -fromcb');
    assert(!arguments.contains('-perimeter') || !arguments.contains('-3d'),
        '-perimeter doesn\'t support -3d');
    bool fromcb = arguments.contains('-fromcb');
    bool d3 = arguments.contains('-3d');
    bool points = arguments.contains('-points');
    bool perimeter = arguments.contains('-perimeter');
    while (true) {
      double a;
      
      double b;
      double? d;
      String str = stdin.readLineSync()!;
      if (str == 'ab') {
        fromcb = false;
      }
      if (str == 'cb') {
        fromcb = true;
      }
      if (str == '2d') {
        d3 = false;
      }
      if (str == '3d') {
        d3 = true;
      }
      if (str == 'lengths') {
        points = false;
      }
      if (str == 'points') {
        points = true;
      }
      if (str == 'perimeter') {
        perimeter = false;
      }
      if (str == 'nonper') {
        perimeter = true;
      }
      if (points) {
        if (d3) {
          double x1 = double.parse(stdin.readLineSync()!);
          double y1 = double.parse(stdin.readLineSync()!);
          double z1 = double.parse(stdin.readLineSync()!);
          double x2 = double.parse(stdin.readLineSync()!);
          double y2 = double.parse(stdin.readLineSync()!);
          double z2 = double.parse(stdin.readLineSync()!);
          a = (y2 - y1).abs();
          b = (x1 - x2).abs();
          d = (z2 - z1).abs();
        } else if (!perimeter) {
          double x1 = double.parse(stdin.readLineSync()!);
          double y1 = double.parse(stdin.readLineSync()!);
          double x2 = double.parse(stdin.readLineSync()!);
          double y2 = double.parse(stdin.readLineSync()!);
          a = (y2 - y1).abs();
          b = (x1 - x2).abs();
        } else {
          double x1 = double.parse(stdin.readLineSync()!);
          double y1 = double.parse(stdin.readLineSync()!);
          double x2 = double.parse(stdin.readLineSync()!);
          double y2 = double.parse(stdin.readLineSync()!);
          double x3 = double.parse(stdin.readLineSync()!);
          double y3 = double.parse(stdin.readLineSync()!);
          a = (y2 - y1).abs();
          b = (x1 - x2).abs();
          double a2 = 
           (y3 - y1).abs();
          double b2 = (x1 - x3).abs();
          double a3 = 
           (y3 - y2).abs();
          double b3 = (x2 - x3).abs();
          double c = pythagFromAB(a, b);
          double c2 = pythagFromAB(a2, b2);
          double c3 = pythagFromAB(a3, b3);
          print("2D PERIMETER: ${((c+c2+c3) * 10).round() / 10}");
          continue;
        }
      } else {
        a = double.parse(stdin.readLineSync()!);
        b = double.parse(stdin.readLineSync()!);
      }
      double c = fromcb ? pythagFromCB(a, b) : pythagFromAB(a, b);
      if (d3) {
        if (points) {
          // done earlier
        } else {
          d = double.parse(stdin.readLineSync()!);
        }
        double e = pythagFromAB(c, d!);
        print("3D LENGTH: ${(e * 10).round() / 10}");
      } else {
        print("2D LENGTH: ${(c * 10).round() / 10}");
      }
    }
  }
  while (true) {
    double o = double.parse(stdin.readLineSync()!);
    double tw = double.parse(stdin.readLineSync()!);
    double th = double.parse(stdin.readLineSync()!);
    if (o * o + tw * tw == th * th) {
      print('yes, $o^2 + $tw^2 (${o * o + tw * tw}) = $th^2 (${th * th})');
    } else if (o * o + th * th == tw * tw) {
      print('yes, $o^2 + $th^2 (${o * o + th * th}) = $tw^2 (${tw * tw})');
    } else if (th * th + tw * tw == o * o) {
      print('yes, $th^2 + $tw^2 (${th * th + tw * tw}) = $o^2 (${o * o})');
    } else {
      print('no, there is no way these three numbers make a right triangle.');
    }
  }
}

double pythagFromAB(double a, double b) {
  double c = sqrt(a * a + b * b);
  return c;
}

double pythagFromCB(double c, double b) {
  double a = sqrt(c * c - b * b);
  return a;
}
