import 'package:flutter/material.dart';

class StepperExample extends StatefulWidget {
  StepperExample({Key? key}) : super(key: key);

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _activeStep = 0;
  String username = "", mail = "", password = "";
  List<Step> allSteps = [];
  bool error = false;
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  List<bool> isActive = [true, false, false];

  @override
  void initState() {
    // TODO: implement initState
    //allSteps = _allSteps();
    //bu şekilde olduğunda görüntü ilk başlandığında olşturuluyor, güncellenmiyor.
    //setState ilgili build metodunu tekrar çalıştırır ve değişikliklerin ekrana yansımasını sağlar.
  }

  @override
  Widget build(BuildContext context) {
    allSteps = _allSteps(); //bu şekilde ise baştaki ikonlar güncellenebiliyor.
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Stepper",
      )),
      body: SingleChildScrollView(
          child: Stepper(
        controlsBuilder:
            (BuildContext context, ControlsDetails controlsDetails) {
          return Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: controlsDetails.onStepContinue,
                child: Text("Continue"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.green), // Değiştireceğiniz renk
                  padding: MaterialStateProperty.all(
                      EdgeInsets.all(16)), // Değiştireceğiniz boyut
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: controlsDetails.onStepCancel,
                child: Text("Back"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.grey), // Değiştireceğiniz renk
                  padding: MaterialStateProperty.all(
                      EdgeInsets.all(16)), // Değiştireceğiniz boyut
                ),
              ),
            ],
          );
        },
        //physics: ClampingScrollPhysics(), //gerek olursa kaydırma için kullanılabilir.
        steps: allSteps,
        currentStep: _activeStep,
        /* onStepTapped: (tappedStep) {
          setState(() {
            _activeState = tappedStep;
          });
        }, */ //sırasıyla gitmesi icin kodu yorum yaptık
        onStepContinue: () {
          setState(() {
            _continueButtonControl();
          });
        },
        onStepCancel: () {
          setState(() {
            if (_activeStep > 0) {
              isActive[_activeStep] = false;
              _activeStep--;
            }
          });
        },
      )),
    );
  }

  List<Step> _allSteps() {
    List<Step> allStepsList = [
      Step(
          title: Text("Username title"),
          subtitle: Text("Username subtitle"),
          state: _setupState(0),
          isActive: isActive[0],
          content: TextFormField(
            key: key0,
            decoration: const InputDecoration(
                labelText: "UsernameLabel",
                hintText: "UsernameHint",
                border: OutlineInputBorder()),
            validator: (value) {
              if (value!.length < 6) {
                return "Enter at least 6 characters";
              }
            },
            onChanged: (value) {
              username = value;
            },
          )),
      Step(
          title: Text("Mail title"),
          subtitle: Text("Mail subtitle"),
          state: _setupState(1),
          isActive: isActive[1],
          content: TextFormField(
            key: key1,
            decoration: const InputDecoration(
                labelText: "MailLabel",
                hintText: "MailHint",
                border: OutlineInputBorder()),
            validator: (value) {
              if (value!.length < 6 || !value.contains("@")) {
                return "Invalid email address";
              }
            },
            onChanged: (value) {
              mail = value;
            },
          )),
      Step(
          title: Text("Password title"),
          subtitle: Text("Password subtitle"),
          state: _setupState(2),
          isActive: isActive[2],
          content: TextFormField(
            key: key2,
            decoration: const InputDecoration(
                labelText: "PasswordLabel",
                hintText: "PasswordHint",
                border: OutlineInputBorder()),
            validator: (value) {
              if (value!.length < 6) {
                return "Enter at least 6 characters";
              }
            },
            onChanged: (value) {
              password = value;
            },
          )),
    ];
    return allStepsList;
  }

  StepState _setupState(int i) {
    if (_activeStep == i) {
      if (error) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  void _continueButtonControl() {
    switch (_activeStep) {
      case 0:
        if (key0.currentState!.validate()) {
          key0.currentState!.save();
          error = false;
          _activeStep = 1;
          isActive[_activeStep] = true;
        } else {
          error = true;
        }
        break;
      case 1:
        if (key1.currentState!.validate()) {
          key1.currentState!.save();
          error = false;
          _activeStep = 2;
          isActive[_activeStep] = true;
        } else {
          error = true;
        }
        break;
      case 2:
        if (key2.currentState!.validate()) {
          key2.currentState!.save();
          error = false;
          isActive[_activeStep] = true;
          formCompleted();
        } else {
          error = true;
        }
        break;
      default:
    }
  }

  void formCompleted() {
    debugPrint(
        "Values: username = $username, mail = $mail, password = $password");
  }
}


/*

*Renk değiştirmeye çalıştım fakat step widgetında icon parametresi yok. Paketten değiştirmek gerekiyor.

 List<Step> _allSteps() {
  var usernameIconColor = _activeStep >= 0 ? Colors.green : Colors.grey;
  var mailIconColor = _activeStep >= 1 ? Colors.green : Colors.grey;
  var passwordIconColor = _activeStep >= 2 ? Colors.green : Colors.grey;

  List<Step> allStepsList = [
    Step(
      title: Text("Username title"),
      subtitle: Text("Username subtitle"),
      state: _setupState(0),
      isActive: true,
      content: TextFormField(
        key: key0,
        decoration: const InputDecoration(
          labelText: "UsernameLabel",
          hintText: "UsernameHint",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 6) {
            return "Enter at least 6 characters";
          }
        },
        onChanged: (value) {
          setState(() {
            username = value;
          });
        },
      ),
      icon: Icon(Icons.account_circle, color: usernameIconColor), // Username icon rengini belirle
    ),
    Step(
      title: Text("Mail title"),
      subtitle: Text("Mail subtitle"),
      state: _setupState(1),
      isActive: true,
      content: TextFormField(
        key: key1,
        decoration: const InputDecoration(
          labelText: "MailLabel",
          hintText: "MailHint",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 6 || !value.contains("@")) {
            return "Invalid email address";
          }
        },
        onChanged: (value) {
          setState(() {
            mail = value;
          });
        },
      ),
      icon: Icon(Icons.mail, color: mailIconColor), // Mail icon rengini belirle
    ),
    Step(
      title: Text("Password title"),
      subtitle: Text("Password subtitle"),
      state: _setupState(2),
      isActive: true,
      content: TextFormField(
        key: key2,
        decoration: const InputDecoration(
          labelText: "PasswordLabel",
          hintText: "PasswordHint",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 6) {
            return "Enter at least 6 characters";
          }
        },
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
      ),
      icon: Icon(Icons.lock, color: passwordIconColor), // Password icon rengini belirle
    ),
  ];
  return allStepsList;
}
 */
