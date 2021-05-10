import 'dart:convert';

class EmployeeData {
  String firstname;
  String lastname;
  int employeeId;
  int phonenumber;
  int officeid;

  List<String> tasks;

  EmployeeData(
  { 
    this.firstname,
    this.lastname,
    this.employeeId,
    this.phonenumber,
    this.officeid
  });

  String serializeForEmployeeInfo() {
    return jsonEncode(
      {
        "firstName": firstname,
        "lastName": lastname,
        "employeeId": employeeId,
        "employeePhoneNumber": phonenumber,
        "officeId": officeid
      }
    );
  }
}