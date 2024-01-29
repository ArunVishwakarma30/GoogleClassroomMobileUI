import 'package:hci_lms/models/user_model.dart';
import 'assignment_model.dart';

class ClassDetails {
  User mainTeacherDetails;
  String className;
  String classInviteCode; // it should be unique for every class any user creates
  String? classSection;
  String? classRoom;
  String? classSubject;
  List<User>? classStudents;
  List<User>? classTeachers;
  List<String>? classAnnouncements;
  List<Assignment>? classAssignments;

  // Named parameters are used with curly braces to make them optional.
  ClassDetails(
      this.mainTeacherDetails,
      this.className,
      this.classInviteCode, {
        this.classSection,
        this.classRoom,
        this.classSubject,
        this.classStudents,
        this.classTeachers,
        this.classAnnouncements,
        this.classAssignments,
      });
}
