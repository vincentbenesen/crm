class Mail {
  late String firstName;
  late String lastName;
  late String email;
  late String subject;
  late String message;

  Mail(
      [this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.subject = '',
      this.message = '']);

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'subject': subject,
      'message': message
    };
  }

  static Mail fromMap(Map<String, dynamic> map) {
    return Mail(map['firstName'], map['lastName'], map['email'], map['subject'],
        map['message']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Mail{firstName: $firstName, lastName: $lastName, email: $email, subject: $subject, message: $message}';
  }
}
