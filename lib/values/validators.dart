import 'package:form_field_validator/form_field_validator.dart';

final MultiValidator nameValidator = MultiValidator([
  RequiredValidator(errorText: "S.current.kEnterFirstName"),
  MinLengthValidator(1, errorText: "S.current.kEnterValidFirstName"),
]);
final MultiValidator emailValidator = MultiValidator([
  RequiredValidator(errorText: "please enter email"),
  EmailValidator(errorText: "please enter valid email"),
]);

final MultiValidator emailOrPhoneValidator = MultiValidator([
  RequiredValidator(errorText: "please enter email or phone number"),
]);
final MultiValidator phoneValidator = MultiValidator([
  RequiredValidator(errorText: "please enter phone number"),
  MinLengthValidator(10, errorText: "please enter valid phone number"),
  MaxLengthValidator(15, errorText: "please enter valid phone number"),
]);
final MultiValidator mobileCodeValidator = MultiValidator([
  RequiredValidator(errorText: "S.current.kEnterCountryCode"),
]);
final MultiValidator passwordValidator = MultiValidator([
  RequiredValidator(errorText: "please enter password"),
]);
final MultiValidator confPasswordValidator = MultiValidator([
  RequiredValidator(errorText: "S.current.kConfPassword"),
  MinLengthValidator(8, errorText: "S.current.kEnterValidPassword"),
]);
final MultiValidator newPasswordValidator = MultiValidator([
  // Ensure the password is not empty
  RequiredValidator(errorText: "please enter password"),
  // Ensure the password meets the minimum length requirement and pattern
  MinLengthValidator(
    8,
    errorText:
        "Password must be at least 8 characters long and include one uppercase letter, one lowercase letter, one digit, and one special character.",
  ),
  // Ensure the password meets the pattern requirement
  PatternValidator(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    errorText:
        "Password must be at least 8 characters long and include one uppercase letter, one lowercase letter, one digit, and one special character.",
  ),
]);

final MultiValidator firstNameValidator = MultiValidator([
  RequiredValidator(errorText: "please enter first name"),
]);

final MultiValidator workspaceNameValidator = MultiValidator([
  RequiredValidator(errorText: "please enter workspace name"),
]);

final MultiValidator addressValidator = MultiValidator([
  RequiredValidator(errorText: "please enter address"),
]);

final MultiValidator cityValidator = MultiValidator([
  RequiredValidator(errorText: "please enter city name"),
]);

final MultiValidator stateValidator = MultiValidator([
  RequiredValidator(errorText: "please enter state name"),
]);

final MultiValidator countryValidator = MultiValidator([
  RequiredValidator(errorText: "please enter country name"),
]);

final MultiValidator requiredValidator = MultiValidator([
  RequiredValidator(errorText: "required"),
]);
final MultiValidator lastNameValidator = MultiValidator([
  RequiredValidator(errorText: "please enter last name"),
]);

final MultiValidator usernameValidator = MultiValidator([
  RequiredValidator(errorText: "please enter username"),
  MinLengthValidator(3,
      errorText: "Username must be at least 3 characters long."),
]);
