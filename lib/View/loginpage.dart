import 'package:flutter/material.dart';
import 'todo.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  @override
  State createState() => _LogInPageState();
}

class User {
  final String? userid;
  final String? password;
  const User({this.userid, this.password});
}

class _LogInPageState extends State {
  @override
  Widget build(BuildContext context) {
    TextEditingController userId = TextEditingController();
    TextEditingController password = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    List userbase = [const User(userid: "Tushar", password: "1234")];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 178, 168, 237),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(
                  width: 330,
                  child: Text(
                    "welcome user",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  )),
              Image.asset(
                "lib/assets/images/task.png",
                height: 300,
                width: 300,
              ),
              Column(
                children: [
                  TextFormField(
                      controller: userId,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "enter your username",
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "please enter username!!";
                        } else {
                          return null;
                        }
                      })),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "enter your password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.remove_red_eye)),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "please enter password!!";
                      } else {
                        return null;
                      }
                    }),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 106, 235),
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 128, 106, 235))),
                    onPressed: () {
                      bool loginvalidate = formKey.currentState!.validate();
                      if (loginvalidate) {
                        if (userId.text == userbase[0].userid &&
                            password.text == userbase[0].password) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "Login Successful!!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const ToDo();
                            },
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Login failed!!"),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Login failed!!"),
                        ));
                      }
                    },
                    child: const Text("log in",
                        style: TextStyle(color: Colors.white))),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
