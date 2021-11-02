import '/core/base/model/user_model.dart';
import 'package:mobx/mobx.dart';
import '/constants/enums/login_form_status.dart';
import '/core/init/locator.dart';
import '/core/init/repository/db_repository.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final DbRepository _dbRepository = locator<DbRepository>();
  @observable
  LoginFormStatus _loginFormStatus = LoginFormStatus.signIn;

  @computed
  LoginFormStatus get loginFormStatus => _loginFormStatus;

  @action
  void changeLoginFormStatus(LoginFormStatus newLoginFormStatus) {
    _loginFormStatus = newLoginFormStatus;
  }

  void replaceUserModel(UserModel? userModel, UserModel newUserModel) {
    userModel = newUserModel;
    userModel.saveUserModeltoLocale();
  }

  /*Future<bool> setNotificationToken({required String userID, required String token}) {
    //return _dbRepository.setNotificationToken(userID: userID, token: token);
  }*/
}
