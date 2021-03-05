import 'package:donation_tracker/calendar_thing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  final dono_date;

  const MainScreen({Key key, this.dono_date}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int now = new DateTime.now().day;
  int _count = 0;

  void _modalPopUp(context){
    TextEditingController customController = TextEditingController();
    TextEditingController customController2 = TextEditingController();
    showModalBottomSheet(context: context, builder: (BuildContext bc){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
        ),
        height: MediaQuery.of(context).size.height * 0.85,
        child: Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.025, left: MediaQuery.of(context).size.width * 0.025, top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height *0.03),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("New Donation", style: GoogleFonts.sourceSerifPro(textStyle: Theme.of(context).textTheme.display1, color: Colors.black),),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[600],
                indent: MediaQuery.of(context).size.width * 0.01,
                endIndent: MediaQuery.of(context).size.width * 0.02,
              ),
              Text("Donation Location", style: GoogleFonts.sourceSerifPro(fontSize: MediaQuery.of(context).size.height * 0.04),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,10),
                      blurRadius: 20,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
                child: TextField(
                  controller: customController,
                  style: GoogleFonts.sourceSerifPro(),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration.collapsed(
                      hintText: 'GoodWill',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.sourceSerifPro(),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Divider(
                color: Colors.grey[600],
                indent: MediaQuery.of(context).size.width * 0.01,
                endIndent: MediaQuery.of(context).size.width * 0.02,
              ),
              Text("Amount", style: GoogleFonts.sourceSerifPro(fontSize: MediaQuery.of(context).size.height * 0.04),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,10),
                      blurRadius: 20,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
                child: TextField(
                  controller: customController2,
                  style: GoogleFonts.sourceSerifPro(),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration.collapsed(
                    hintText: '\$0.00',
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.sourceSerifPro(),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Divider(
                color: Colors.grey[600],
                indent: MediaQuery.of(context).size.width * 0.01,
                endIndent: MediaQuery.of(context).size.width * 0.02,
              ),
              Text("Date", style: GoogleFonts.sourceSerifPro(fontSize: MediaQuery.of(context).size.height * 0.04),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Text("${widget.dono_date}"),
              RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return MyApp();
                  }));
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Create", style: GoogleFonts.sourceSerifPro(),),
                onPressed: (){
                  Navigator.of(context).pop(customController.text.toString());
                  _createNewCard();
                },
              ),
            ],
          ),
        ),
      );
    },
    isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.02),
          topRight: Radius.circular(MediaQuery.of(context).size.height * 0.02)
      ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> _card = new List.generate(_count, (int i) => new DonationCard());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                    "Recent Donations", style: GoogleFonts.sourceSerifPro(textStyle: Theme.of(context).textTheme.display1, color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
                  child: Container(
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: new ListView(
                            shrinkWrap: false,
                            children: _card,
                          ),
                        );
                      },
                      itemCount: _count,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (BuildContext context, int index){
                        return SizedBox(
                          height: 100,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _modalPopUp(context);
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add, size: MediaQuery.of(context).size.height * 0.05,),
      ),
    );
  }

  void _createNewCard(){
    setState(() {
      _count = _count + 1;
    });
  }
}


class DonationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.grey[500],
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,10),
              blurRadius: 20,
              color: Colors.grey[500],
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Test"),
            Text("pls work"),
          ],
        ),
      ),
    );
  }
}


//createAlertDialog(context).then((value) {
//            SnackBar mySnackBar = SnackBar(content: Text("Hello $value"),);
//            Scaffold.of(context).showSnackBar(mySnackBar);
//
//         });

//  Future<String>createAlertDialog(BuildContext context){
//    TextEditingController customController = TextEditingController();
//    return showDialog(context: context, builder: (context) {
//      return AlertDialog(
//        title: Text("Donation Location"),
//        content: TextField(
//          controller: customController,
//        ),
//        actions: <Widget>[
//          MaterialButton(
//            elevation: 5,
//            child: Text("Submit"),
//            onPressed: (){
//              Navigator.of(context).pop(customController.text.toString());
//            },
//          ),
//        ],
//      );
//    });
//
//    }