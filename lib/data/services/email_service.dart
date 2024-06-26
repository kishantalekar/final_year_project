import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailData {
  final String recipientEmailAddress;
  final String subject;
  final String text;
  final String html;

  EmailData({
    required this.recipientEmailAddress,
    required this.subject,
    required this.text,
    required this.html,
  });
}

class EmailService {
  Future<void> sendEmail(EmailData emailData) async {
    final smtpServer = SmtpServer(
      'smtp.gmail.com',
      port: 587,
      username:
          'kishantalekar024@gmail.com', // Replace with your Gmail username
      password:
          'cvnkykvniopqbvfp', // Replace with your Gmail password or App password if 2FA is enabled
    );

    final message = Message()
      ..from = const Address('kishantalekar024@gmail.com',
          "Ecobarter") // Replace with your Gmail address and name
      ..recipients.add(emailData.recipientEmailAddress)
      ..subject = emailData.subject
      ..text = emailData.text
      ..html = emailData.html;

    try {
      print("sending");
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport}');
    } catch (e) {
      print('Error occurred while sending email: $e');
    }
  }
}
