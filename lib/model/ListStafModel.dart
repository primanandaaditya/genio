
import 'package:manajemen/model/StaffModel.dart';

class ListStafModel{
  List<StaffModel> _models;

  List<StaffModel> get models => _models;

  set models(List<StaffModel> value) {
    _models = value;
  }
}

class ListStafBegin extends ListStafModel{}
