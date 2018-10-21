import 'package:scoped_model/scoped_model.dart';

class Data extends Model {
  double _budget = 100.0;

  double get budget => _budget;

  set budget(double value) {
    _budget = value;
    notifyListeners();
  }
}