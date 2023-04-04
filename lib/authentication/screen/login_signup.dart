import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../pages/home.dart';
import '../config/palette.dart';


class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  TextEditingController userNameTextEditingController  = TextEditingController();
  TextEditingController emaiTextEditingController  = TextEditingController();
  TextEditingController passwordTextEditingController  = TextEditingController();
  TextEditingController loginUserNameTextEditingController  = TextEditingController();
  TextEditingController loginPasswordTextEditingController  = TextEditingController();
  late String email;
  late String password;
  bool? login;
  //TextEditingController textEditingController  = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  loginRegister(bool register) async{
    try {
      if(register){
        final credential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (credential.user != null)
        {
          Fluttertoast.showToast(
              msg: "Sign Up Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          setState(() {
            isSignupScreen = ! isSignupScreen;
          });
        }
      }
      else if(!register){
        try{
          final credential =  await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          if(credential.user != null)
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(),));
          }
        }
        catch (e){
          Fluttertoast.showToast(
              msg: "Wrong user name or password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

      }
    } catch (e) {
      print(e);
    }
  }
  bool isMale = true;
  bool isSignupScreen = true;
  bool isRememberMe = false;
  bool showHiddenPass = true;
  Icon blueEye = Icon(Icons.remove_red_eye, color: Colors.blue,);
  Icon whiteEye = Icon(Icons.remove_red_eye, color: Colors.grey,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/img.png'), fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                //alignment: Alignment.topLeft,
                color: Color(0xFF3b5999).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Welcome to',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.yellow[700],
                            letterSpacing: 2,
                          ),
                          children: [
                            TextSpan(
                                text: isSignupScreen ? ' Foods World, ' : ' Back, ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow[700],
                                ))
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignupScreen
                          ? 'Signup to Continue'
                          : 'Signin to Continue',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 700),
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              padding: EdgeInsets.all(20),
              height: isSignupScreen ? 380 : 250,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    )
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                              showHiddenPass = true;
                              userNameTextEditingController.text = '';
                              passwordTextEditingController.text = '';
                              emaiTextEditingController.text = '';
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                              showHiddenPass = true;
                              loginUserNameTextEditingController.text = '';
                              loginPasswordTextEditingController.text = '';
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'SIGNUP',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                  margin: EdgeInsets.only(top: 3),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          buildSubmitButton(),
          Positioned(
            top: MediaQuery.of(context).size.height - 120,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(isSignupScreen ? 'Or Signup with' : 'Or Signin with'),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTextButton(MaterialCommunityIcons.facebook,
                          "Facebook", Palette.facebookColor),
                      buildTextButton(MaterialCommunityIcons.google_plus,
                          "Google", Palette.googleColor),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSubmitButton() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,
      child: GestureDetector(
        onTap: () {


           if(isSignupScreen)
             {
               email = emaiTextEditingController.text;
               password = passwordTextEditingController.text;
               loginRegister(true);
             }
           else{
             email = loginUserNameTextEditingController.text;
             password = loginPasswordTextEditingController.text;
             loginRegister(false);
           }

        },
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade200,
                Colors.red.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1))
            ],
          ),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, 'info@demouri.com', false, true, loginUserNameTextEditingController),
          buildTextField(Icons.lock_outline, '*************', true, false, loginPasswordTextEditingController),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = value!;
                      });
                    },
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(fontSize: 12, color: Palette.textColor1),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 12, color: Palette.textColor1),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(MaterialCommunityIcons.account_outline, 'User Name',
              false, false, userNameTextEditingController),
          buildTextField(
              MaterialCommunityIcons.email_outline, 'email', false, true, emaiTextEditingController),
          buildTextField(
              MaterialCommunityIcons.lock_outline, 'password', true, false, passwordTextEditingController),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        width: 30,
                        decoration: BoxDecoration(
                          color:
                          isMale ? Palette.textColor2 : Colors.transparent,
                          border: Border.all(
                              width: 1,
                              color: isMale
                                  ? Colors.transparent
                                  : Palette.textColor1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text(
                        'Male',
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        width: 30,
                        decoration: BoxDecoration(
                          color:
                          isMale ? Colors.transparent : Palette.textColor2,
                          border: Border.all(
                              width: 1,
                              color: isMale
                                  ? Palette.textColor1
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Palette.iconColor : Colors.white,
                        ),
                      ),
                      Text(
                        'Female',
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "By pressing 'Submit' you agree to our ",
                    style: TextStyle(
                      color: Palette.textColor2,
                    ),
                    children: [
                      TextSpan(
                          text: "term & conditions",
                          style: TextStyle(color: Colors.orange))
                    ])),
          )
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          minimumSize: Size(150, 40),
          side: BorderSide(width: 1, color: Colors.grey),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor,
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 5,
            ),
            Text(title),
          ],
        ));
  }

  Widget buildTextField(
      IconData icon, String hinText, bool isPassword, bool isEmail, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        obscureText: showHiddenPass? isPassword : showHiddenPass,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Palette.iconColor,
            ),


            suffixIcon: IconButton(onPressed: () {
              setState(() {
                showHiddenPass = !showHiddenPass;
                print(showHiddenPass);
              });
            }, icon: isPassword? (showHiddenPass? whiteEye : blueEye) : const Icon(null),

            ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.textColor1),
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.textColor1),
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
            hintText: hinText,
            hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
            contentPadding: EdgeInsets.all(10)),
      ),
    );
  }
}