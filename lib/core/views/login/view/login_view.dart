import 'package:flutter/material.dart';
import '/core/init/user/user_manager.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/constants/app_constats.dart';
import '/constants/enums/login_form_status.dart';
import '/core/base/view/base_view.dart';
import '/core/components/form/register_form_widget.dart';
import '/core/components/form/signin_form_widget.dart';
import '/core/views/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel loginViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: LoginViewModel(),
      onModelReady: (model) => loginViewModel = model as LoginViewModel,
      onPageBuilder: (context, value) => buildLoginView(),
    );
  }

  Scaffold buildLoginView() {
    //var viewState = context.watch<UserManager>().state;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            buildLoginViewPage(),
            //viewState == ViewState.busy ? buildCircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildLoginViewPage() {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildImageView(context),
              buildSignInAndRegisterForms,
            ],
          ),
        ),
      ),
    );
  }

  Widget get buildSignInAndRegisterForms => Expanded(
        child: Observer(
          builder: (_) =>
              loginViewModel.loginFormStatus == LoginFormStatus.signIn ? buildSignFormWidget() : buildRegisterFormWidget(),
        ),
      );

  SignFormWidget buildSignFormWidget() {
    return SignFormWidget(
      googleSignInOnPressed: () async {
        debugPrint('Google sign in pressed');
        var usermodel = await context.read<UserManager>().signInWithGoogle();
        /*var userNotificationToken = await FirebaseMessaging.instance.getToken();
        if (usermodel != null && usermodel.userID != null && userNotificationToken != null) {
          loginViewModel.setNotificationToken(userID: usermodel.userID!, token: userNotificationToken);
        }*/
      },
      appleSignInOnPressed: () async {
        debugPrint('Apple sign in pressed');
        var usermodel = await context.read<UserManager>().signInWithApple();
        /*var userNotificationToken = await FirebaseMessaging.instance.getToken();
        if (usermodel != null && usermodel.userID != null && userNotificationToken != null) {
          loginViewModel.setNotificationToken(userID: usermodel.userID!, token: userNotificationToken);
        }*/
      },
      signInOnPressed: (email, password) async {
        debugPrint('Sign in on pressed');
        var usermodel = await context.read<UserManager>().signInWithEmailPassword(email, password);
        /*var userNotificationToken = await FirebaseMessaging.instance.getToken();
        if (usermodel != null && usermodel.userID != null && userNotificationToken != null) {
          loginViewModel.setNotificationToken(userID: usermodel.userID!, token: userNotificationToken);
        }*/
      },
      gotoSignUpOnPressed: () => loginViewModel.changeLoginFormStatus(LoginFormStatus.register),
      forgotPwOnPressed: (email) async {
        await context.read<UserManager>().forgotPassword(email);
      },
      anonymouslySignInOnPressed: () async {
        /*setState(() {
          showProgressIndicator = true;
        });
        final string = await context.read<UserManager>().singInAnonymously();
        showSnackBar(context, string);
        setState(() {
          showProgressIndicator = false;
        });*/
      },
    );
  }

  RegisterFormWidget buildRegisterFormWidget() {
    return RegisterFormWidget(
      signUpOnPressed: (email, password) async {
        final isUserCreated = await context.read<UserManager>().createUserWithEmailPassword(email, password);
        if (isUserCreated != null && isUserCreated) {
          loginViewModel.changeLoginFormStatus(LoginFormStatus.signIn);
        }
      },
      gotoSignInOnPressed: () => loginViewModel.changeLoginFormStatus(LoginFormStatus.signIn),
    );
  }

  Container buildCircularProgressIndicator() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color(0x94000000),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container buildImageView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.all(10),
      child: SvgPicture.asset(ApplicationConstants.loginSvgAssetPathDark, semanticsLabel: 'login'),
    );
  }

  void showSnackBar(BuildContext context, String string) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(string),
    ));
  }
}
