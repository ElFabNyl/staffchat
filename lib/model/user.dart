class Users {
  final String uid;
  final String employeeName;
  String employeeEmail;
  String employeeStaffCode;
  String employeeRole;

  Users(
      {
         required this.uid,
        required this.employeeName,
      required this.employeeEmail,
      required this.employeeStaffCode,
      required this.employeeRole});
}
