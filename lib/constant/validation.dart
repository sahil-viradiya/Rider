class Validator {
  static RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)$',
  );

  static String? validateEmails(String value) {
    if (value.isEmpty) {
      return "Please enter an email address";
    } else if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? validateOtp(String value) {
    if (value.isEmpty) {
      return "Please enter Otp";
    } else if (value.length < 6) {
      return "Otp must be 6 character long";
    }
    return null;
  }
  static String? validateAmount(String value) {
  if (value.isEmpty) {
    return "Please enter an amount";
  } else {
    final amount = double.tryParse(value);
    if (amount == null) {
      return "Please enter a valid number";
    } else if (amount <= 0) {
      return "Amount must be greater than zero";
    }
  }
  return null;
}


  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Please enter Password";
    } else if (value.length < 8) {
      return "Password must be 8 character long";
    }
    return null;
  }
  static String? validateIFSC(String value) {
  if (value.isEmpty) {
    return "Please enter IFSC Code";
  } else if (!RegExp(r'^[A-Za-z]{4}[0-9A-Za-z]{7}$').hasMatch(value)) {
    return "IFSC Code must be 11 characters long and start with 4 alphabetic characters followed by 7 alphanumeric characters";
  }
  return null;
}

static String? validateAccountNumber(String value) {
  if (value.isEmpty) {
    return "Please enter Account Number";
  } else if (value.length >= 12) {
    return "Account Number must be 12 characters long";
  }
  return null;
}

  static String? validateFirstName(String value) {
    if (value.isEmpty) {
      return "Please enter First Name";
    }
    return null;
  }

  static String? validateUserName(String value) {
    if (value.isEmpty) {
      return "Please enter User Name";
    }
    return null;
  }

  static String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Please enter Your Address";
    }
    return null;
  }

  static String? validateLastName(String value) {
    if (value.isEmpty) {
      return "Please enter Last Name";
    }
    return null;
  }
   static String? bankName(String value) {
    if (value.isEmpty) {
      return "Please enter Bank Name";
    }
    return null;
  }
   static String? branchName(String value) {
    if (value.isEmpty) {
      return "Please enter Bank Name";
    }
    return null;
  }

  static String? validateConfirmPassword(String value, String val) {
    if (value.isEmpty) {
      return "Please enter Password";
    } else if (value != val) {
      return "Confirm password does not match with password";
    }
    return null;
  }

  static String? validateMobile(String value) {
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else if (value.isEmpty) {
      return "Please enter Contact Number";
    }
    return null;
  }

  static String? validateMobileOtp(String value) {
    if (value.length != 6) {
      return 'OTP must be of 4 digit';
    } else if (value.isEmpty) {
      return "Please enter OTP";
    }
    return null;
  }
}
