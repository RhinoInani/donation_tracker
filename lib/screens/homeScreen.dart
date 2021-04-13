import 'package:donation_tracker/components/donationTextField.dart';
import 'package:donation_tracker/screens/settingsScreen.dart';
import 'package:donation_tracker/userSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentDate = DateTime.now();
  DateTime selectedDate;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    targetAmount = 0.0;
    amountDonated = 0.0;
    selectedDate ??= DateTime.now();
    remainder = targetAmount - amountDonated;
  }

  void _newDonationPopUp(context, Size size, bool isMoney) {
    TextEditingController recipientController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController valueController = TextEditingController();
    String date = "${currentDate.month}/${currentDate.day}/${currentDate.year}";
    counter = 0;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.025,
                  left: MediaQuery.of(context).size.width * 0.025,
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "New Donation",
                            style: TextStyle(fontSize: size.width * 0.06),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                              recipientController.clear();
                              amountController.clear();
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.black87,
                        thickness: 0.5,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      DonationsTextField(
                        textController: recipientController,
                        text: "Recipient",
                        isAmount: false,
                      ),
                      isMoney
                          ? Container()
                          : DonationsTextField(
                              textController: valueController,
                              text: "Item",
                              isAmount: false),
                      DonationsTextField(
                        textController: amountController,
                        text: isMoney ? "Amount:" : "Value",
                        isAmount: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 8.0),
                            child: Text(
                              "Date:",
                              style: TextStyle(fontSize: size.width * 0.045),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _selectDate(context, isMoney);
                              counter++;
                              setState(() {
                                date =
                                    "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey[400],
                                  width: 0.7,
                                ),
                              ),
                              width: size.width * 0.6,
                              height: size.height * 0.07,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$date",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Center(
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey[400],
                                width: 0.7,
                              ),
                            ),
                            width: size.width * 0.85,
                            height: size.height * 0.07,
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(fontSize: size.width * 0.045),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.02),
            topRight:
                Radius.circular(MediaQuery.of(context).size.height * 0.02)),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isMoney) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: counter > 0 ? selectedDate : currentDate,
      firstDate: DateTime(2005),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.dark(
              primary: isMoney ? Colors.green[300] : Colors.blue[300],
              onPrimary: Colors.black,
              surface: isMoney ? Colors.green[300] : Colors.blue[300],
              onSurface: Colors.black,
              secondary: Colors.black,
              onSecondary: Colors.black,
              secondaryVariant: Colors.black,
              brightness: Brightness.dark,
            ),
            textTheme: GoogleFonts.ralewayTextTheme(),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Colors.white.withOpacity(0),
        //   elevation: 0,
        //   actions: [
        //     IconButton(
        //         icon: Icon(
        //           Icons.settings,
        //           color: Colors.grey[600],
        //         ),
        //         onPressed: () {})
        //   ],
        // ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: size.height * 0.05,
            top: size.height * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Recent Donations",
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                  width: size.width * 0.85,
                  height: size.height * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Target Amount: \$$targetAmount"),
                      Text("Amount Donated: \$$amountDonated"),
                      Text("Remainder: \$$remainder"),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.black87,
                  height: 30,
                  indent: size.width * 0.05,
                  endIndent: size.width * 0.05,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          useRotationAnimation: true,
          closeManually: false,
          curve: Curves.decelerate,
          overlayColor: Colors.transparent,
          overlayOpacity: 0.3,
          buttonSize: 70.0,
          visible: true,
          icon: Icons.add,
          activeIcon: Icons.remove,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.attach_money_rounded),
              backgroundColor: Colors.green[300],
              label: 'Money',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                _newDonationPopUp(context, size, true);
                setState(() {});
              },
              onLongPress: () {},
            ),
            SpeedDialChild(
              child: Icon(
                Icons.shopping_bag_outlined,
              ),
              backgroundColor: Colors.blue[300],
              label: 'Item',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                _newDonationPopUp(context, size, false);
              },
              onLongPress: () {},
            ),
            SpeedDialChild(
                child: Icon(Icons.settings),
                backgroundColor: Colors.deepPurple[300],
                label: 'Settings',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SettingsScreen();
                  }));
                })
          ],
        ));
  }
}
