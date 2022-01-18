import 'package:todoApp/shared/components/components.dart';
import 'package:flutter/material.dart';

class login_screen extends StatelessWidget {
  // int _counter = 0;
  var passwordVisible = true;
  var TextController = TextEditingController();
  var NameController = TextEditingController();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var PhoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: TextController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.green),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: "Text Filed",
                          labelStyle: TextStyle(fontSize: 30),
                          hintText: "Enter Text",
                          hintStyle: TextStyle(fontSize: 20)),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'password must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.all(10.0),
                  //   child: TextFormField(
                  //     controller: NameController,
                  //     decoration: InputDecoration(
                  //         labelText: "Name",
                  //         labelStyle: TextStyle(fontSize: 30),
                  //         hintText: "Enter Name",
                  //         hintStyle: TextStyle(fontSize: 20),
                  //         icon: Icon(Icons.person_add_outlined)),
                  //     keyboardType: TextInputType.text,
                  //     validator: (value) {
                  //       if (value.isEmpty) {
                  //         return 'password must not be empty';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  defaultFornField(
                    NameController: NameController,
                    iconText: Icons.person_add_outlined,
                    text: 'Name',
                    onTap: () {},
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: EmailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 30),
                          hintText: "Enter Email",
                          hintStyle: TextStyle(fontSize: 20),
                          prefixIcon: Icon(Icons.mark_email_read)),
                      keyboardType: TextInputType
                          .emailAddress, // bche temedelec le clieviy fih @ ya3ref bli der email
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'password must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: PasswordController,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 30),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(fontSize: 20),
                          //  icon: Icon(Icon)
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              // setState(() {
                              // passwordVisible = !passwordVisible;
                              //  }
                              // );
                            },
                          )),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: passwordVisible,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'password must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  // tegder tefr9 binathom hna f plaset margen b SizeBox(),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: PhoneController,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixText: "+213  ",
                          labelText: "Phone Number",
                          labelStyle: TextStyle(fontSize: 30),
                          hintText: "Enter Phone Number",
                          hintStyle: TextStyle(fontSize: 20),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.blue,
                          )),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Phone Number must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    width:
                        370.0, //  hada khatea hena khedm ble pading pusq mach kale tilphonate la talle  ta3hom kifkif
                    text: 'LOGIN',
                    raduis: 5.0,
                    function: () {
                      if (formKey.currentState.validate()) {
                        // t9olo hekem formKey djebli halate deylhom ou dir 3lih validet
                        print(TextController.text);
                        print(NameController.text);
                        print(EmailController.text);
                        print(PasswordController.text);
                        print(PhoneController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account ?  '),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register Now '),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
