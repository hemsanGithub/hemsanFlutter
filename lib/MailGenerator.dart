import 'Mail.dart';

class MailGenerator {
  static var mailList = [
    MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
    MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
    MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
    MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
    MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
    MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
    MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
     MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
     MailContent("Flutter Coding", "Jonny", "11 June",
        "This is a simple demo mail..."),
  ];

  static MailContent getMailContent(int position) => mailList[position];
  static int mailListLength = mailList.length;
}