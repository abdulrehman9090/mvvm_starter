import 'package:flutter/material.dart';
import 'package:mvvm_theme_switching/res/AppColors.dart';
import 'package:mvvm_theme_switching/utils/LoggerHelpers.dart';
import 'package:mvvm_theme_switching/utils/routes/routes_name.dart';
import 'package:mvvm_theme_switching/utils/utils.dart';
import 'package:mvvm_theme_switching/view/components/custom_button.dart';
import 'package:mvvm_theme_switching/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();


  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bool isUserLoggedIn = Provider.of<AuthViewModel>(context, listen: false).checkIsUserLoggedIn();
      print(isUserLoggedIn);
      if(isUserLoggedIn){
        print("hello");
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.demo, (route) => false,);
      }
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailFocus.dispose();
    passwordFocus.dispose();

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthViewModel>(context, listen: true);
    // print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/3.4,),
                TextFormField(
                  focusNode: emailFocus,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColorLight
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.shiftFocusOfField(context, emailFocus, passwordFocus);
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  focusNode: passwordFocus,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColorLight
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),

                CustomButton(
                    loading: authProvider.isLoading,
                    onPress: () {

                      if(emailController.text.trim().isEmpty){
                        Utils.flushBarErrorMessage("Email Field Cannot be empty", context);
                      } /*else if(!Utils.checkEmail(emailController.text.trim().toString())){
                        Utils.flushBarErrorMessage("Please enter a valid email", context);
                      } */else if(passwordController.text.trim().isEmpty){
                        Utils.flushBarErrorMessage("Password Field Cannot be empty", context);
                      } else if(passwordController.text.trim().length < 6){
                        Utils.flushBarErrorMessage("Password should be greater than 5 characters", context);
                      }else{
                        // every thing is fine
                        authProvider.loginUser(context: context, email: emailController.text.toString(), password: passwordController.text.toString());
                      }
                    },
                    text: "Login"
                ),

                const SizedBox(height: 25,),

                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, RoutesName.register);register
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      Text("Register", style: TextStyle(color: AppColors.primaryColorLight)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
