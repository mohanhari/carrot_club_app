class Registration {
  bool termAndCondition = false;
  String mobileNum, tacCode, name, email, nricNumber, gender;
  List genders = ['Male', 'Female'];

  String validateName(String value){
    if(value.isEmpty)
      return('Please enter name!');

    RegExp regExp = new RegExp(r"^[A-Za-z]+$");

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'Name is not valid';
  }

  String validateEmail(String value){
    if(value.isEmpty)
      return('Please enter email!');
    RegExp regExp = new RegExp(r"^\S+@\S+\.\S+$");

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'Email is not valid';
  }

  String validateNricNumber(String value){
    if(value.isEmpty)
      return('Please enter NRIC!');
    RegExp regExp = new RegExp(r"^\d{12}$");

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'NRIC is not valid';
  }

  String validateGender(String value){
    if(value == null ||  value.isEmpty)
      return('Please enter Gender!');
    else
      return null;
  }

  String validateMobileNumber(String value){
    if(value.isEmpty)
      return('Please enter phone number!');

    RegExp regExp = new RegExp(r"^\d{9}$");

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'Phone number is not valid';
  }

  String validateTacCode(String value){
    if(value.isEmpty)
      return('Please enter TAC code!');

    RegExp regExp = new RegExp(r"^\d{4}$");

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'TAC code is not valid';
  }
}