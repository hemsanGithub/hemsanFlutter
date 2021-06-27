import 'package:flutter/material.dart';
import 'Mail.dart';
import 'MailGenerator.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'login.dart';
import 'signup.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var drawerIcons = [
    Icon(Icons.move_to_inbox),
    Icon(Icons.send),
  ];
  var drawerText = [
    "All inboxes",
    "Sent",
  ];
  var titleBarContent = "Primary";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getMailAppBar(),
      drawer: _getMailAccountDrawerr(),
      body: _mailListViewGenerator(),
      floatingActionButton: _getMailFloatingActionButton(),
    );
  }

  FloatingActionButton _getMailFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ComposeEmailPageState()),
        );
      },
      child: Icon(Icons.edit),
      backgroundColor: Colors.red,
    );
  }

  AppBar _getMailAppBar() {
    return AppBar(
      backgroundColor: Colors.red,
      title: new Text(
        titleBarContent,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 13.0),
          child: Icon(
            Icons.search,
            size: 25.0,
          ),
        ),
      ],
    );
  }

  Drawer _getMailAccountDrawerr() {
    Text email = new Text(
      "santoram@gmail.com",
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
    );
    Text name = new Text(
      "Jhasi Rajput",
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
    );
    return Drawer(
        child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.red),
          accountName: name,
          accountEmail: email,
          currentAccountPicture: Icon(
            Icons.account_circle,
            size: 50.0,
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
              padding: EdgeInsets.only(top: 0.0),
              itemCount: drawerText.length,
              itemBuilder: (context, position) {
                return ListTile(
                  leading: drawerIcons[position],
                  title: Text(drawerText[position],
                      style: TextStyle(fontSize: 15.0)),
                  onTap: () {
                    this.setState(() {
                      titleBarContent = drawerText[position];
                    });
                    Navigator.pop(context);
                  },
                );
              }),
        )
      ],
    ));
  }

  Widget _mailListViewGenerator() {
    return ListView.builder(
        itemCount: MailGenerator.mailListLength,
        itemBuilder: (context, position) {
          MailContent mailContent = MailGenerator.getMailContent(position);
          return Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 14.0, right: 14.0, top: 5.0, bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 55.0,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                mailContent.sender,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontSize: 17.0),
                              ),
                              Text(
                                mailContent.time,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    fontSize: 13.5),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    mailContent.subject,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                        fontSize: 15.5),
                                  ),
                                  Text(
                                    mailContent.message,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                        fontSize: 15.5),
                                  )
                                ],
                              ),
                              Icon(Icons.star_border, size: 25.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ]);
        });
  }
}

class ComposeEmailPageState extends StatelessWidget {
  String? from;
  String? to;
  String? Cc;
  String? sub;
  String? cmpose;
  String pwd='sanHem?.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 25.0),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: new Text(
            "Compose",
            style: TextStyle(
              color: Colors.white,
              fontSize: 21.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: Icon(
                Icons.attachment,
                size: 25.0,
                color: Colors.white,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: IconButton(
                  onPressed: () => mailsend(),
                  icon: Icon(
                    Icons.send,
                    size: 23.0,
                    color: Colors.white,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: PopupMenuButton(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45)),
                  itemBuilder: (_) {
                    return [
                      PopupMenuItem(
                          child: TextButton(
                              onPressed: () => sDg(context),
                              child: Text(
                                'Scheduled Selector',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ))),
                    ];
                  }),
            ),
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                ListTile(
                  title: TextField(
                      onChanged: (val) => from = val,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                        labelText: "From",
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal),
                      )),
                ),
                Divider(),
                ListTile(
                  title: TextField(
                      onChanged: (val) => to = val,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                          labelText: "To",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                              fontStyle: FontStyle.normal))),
                ),
                Divider(),
                ListTile(
                  title: TextField(
                      onChanged: (val) => Cc = val,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                          labelText: "Cc",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                              fontStyle: FontStyle.normal))),
                ),
                Divider(
                  thickness: 0.7,
                ),
                ListTile(
                  title: TextField(
                      onChanged: (val) => sub = val,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                          hintText: "Subject",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                              fontStyle: FontStyle.normal))),
                ),
                Divider(
                  thickness: 0.7,
                ),
                ListTile(
                  title: TextField(
                      onChanged: (val) => cmpose = val,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                        hintText: "Compose Email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontStyle: FontStyle.normal),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Future<Null> sDg(BuildContext context) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Container(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Container(
                      height: 290,
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          padding: EdgeInsets.all(4),
                          crossAxisSpacing: 2,
                          children: [
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                color: Colors.white70,
                                child: Center(
                                    child: Text(
                                  'Recurring Schedule',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                color: Colors.white70,
                                child: Center(
                                    child: Text(
                                  'Weekly Schedule',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                color: Colors.white70,
                                child: Center(
                                    child: Text(
                                  'Monthly Schedule',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                color: Colors.white70,
                                child: Center(
                                    child: Text(
                                  'Yearly Schedule',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))),
                          ]))));
        });
  }

  mailsend() async {
    // String username = 'santoshhembram269@gmail.com';
    // String password = 'sanHem?.';

    final smtpServer = gmail(from!, pwd);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(from!)
      ..recipients.add(to)
       ..ccRecipients.addAll([Cc])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = sub
      ..text =cmpose
      ..html =
          "<h1></h1>\n<p>$cmpose</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE

    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    /*  final equivalentMessage = Message()
    ..from = Address(username, 'Your name 😀')
    ..recipients.add(Address('destination@example.com'))
    ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
    ..bccRecipients.add('bccAddress@example.com')
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
    ..attachments = [
      FileAttachment(File('exploits_of_a_mom.png'))
        ..location = Location.inline
        ..cid = '<myimg@3.141>'
    ];

  final sendReport2 = await send(equivalentMessage, smtpServer);

  // Sending multiple messages with the same connection
  //
  // Create a smtp client that will persist the connection
  var connection = PersistentConnection(smtpServer);

  // Send the first message
  await connection.send(message);

  // send the equivalent message
  await connection.send(equivalentMessage);

  // close the connection
  await connection.close(); */
  }
}
