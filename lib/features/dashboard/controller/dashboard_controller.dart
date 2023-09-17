import 'package:get/get.dart';

import '../../../core/services/user/model/doctor_model.dart';
import '../../../core/services/user/usecase.dart';

class DashboardController extends GetxController {
  final UserServices _userServices = UserServices();

  Future<List<DoctorModel>> getAllDoctors() async {
    return await _userServices.getAllDoctors();
  }
}
