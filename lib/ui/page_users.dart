import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:landlord_tenent/ui/page_payment.dart';
import 'package:landlord_tenent/ui/page_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:landlord_tenent/utils/responsive_screen.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_search_bar/flutter_search_bar.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
  Users();
}

class _UsersState extends State<Users> {
  bool _enabled = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Screen? size;
  // SearchBar? searchBar;

  void onSubmitted(String? value) {
    // setState(() => _scaffoldKey.currentState
    //     .showSnackBar(SnackBar(content: Text('You wrote $value!'))));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text('Search People'), backgroundColor: Colors.blue[700]!);
    // actions: [searchBar!.getSearchAction(context)]);
  }

  _UsersState() {
    // searchBar = SearchBar(
    //     inBar: false,
    //     buildDefaultAppBar: buildAppBar,
    //     setState: setState,
    //     onSubmitted: onSubmitted,
    //     onClosed: () {
    //       print("closed");
    //     });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[700]!);
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(context),
        // appBar: searchBar!.build(context),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('User').snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == null || !snapshot.hasData)
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue[700]!,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.fromLTRB(size!.getWidthPx(10),
                          size!.getWidthPx(10), size!.getWidthPx(10), 0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot docsSnap =
                              snapshot.data!.docs[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              getUserCard(docsSnap, context),
                            ],
                          );
                        },
                      ),
                    );
            }));
  }

  Widget getUserCard(DocumentSnapshot docsSnap, var context) {
    Map<String, dynamic> docData = docsSnap.data()! as Map<String, dynamic>;
    size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(bottom: size!.getWidthPx(10)),
      child: Card(
        elevation: 4,
        borderOnForeground: true,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfilePage('/User/' + docsSnap.id, true)));
            //Fluttertoast.showToast(msg: "Card Tapped ${docsSnap['firstName']} ${docsSnap['lastName']}" );
          },
          child: Container(
            width: size!.wp(90),
            height: size!.hp(15),
            child: Row(
              children: <Widget>[
                Container(
                  width: size!.hp(15),
                  color: Colors.grey,
                  child: docData.containsKey("profileImage")
                      ? Image.network(
                          '${docsSnap['profileImage']}',
                        )
                      : Image.asset('assets/icons/avatar.png'),
                ),
                Container(
                  width: size!.wp(90) - size!.hp(15),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size!.getWidthPx(12),
                        horizontal: size!.getWidthPx(16)),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${docsSnap['firstName']} ${docsSnap['lastName']}',
                            style: TextStyle(
                                fontFamily: 'Ex02',
                                fontSize: size!.getWidthPx(20),
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              size: size!.getWidthPx(16),
                              color: Colors.grey,
                            ),
                            docData.containsKey("city")
                                ? Text(
                                    "${docsSnap['city']}, India",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: size!.getWidthPx(16)),
                                  )
                                : Text("India",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: size!.getWidthPx(16))),
                          ],
                        ),
                        SizedBox(
                          height: size!.getWidthPx(10),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size!.getWidthPx(15)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: size!.getWidthPx(40),
                                height: size!.getWidthPx(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      size!.getWidthPx(20)),
                                  border: Border.all(
                                      width: size!.getWidthPx(1),
                                      color: Colors.transparent),
                                  color: Colors.greenAccent.shade700,
                                ),
                                child: Center(
                                  child: IconButton(
                                    tooltip: "Call",
                                    icon: Icon(
                                      FontAwesomeIcons.phoneAlt,
                                      size: size!.getWidthPx(17),
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      var url = "tel:" +
                                          docsSnap['mobileNo'].toString();
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Can't Lauch Phone",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: size!.getWidthPx(15));
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: size!.getWidthPx(12)),
                              Container(
                                width: size!.getWidthPx(40),
                                height: size!.getWidthPx(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      size!.getWidthPx(20)),
                                  border: Border.all(
                                      width: size!.getWidthPx(1),
                                      color: Colors.transparent),
                                  color: Colors.redAccent,
                                ),
                                child: Center(
                                  child: IconButton(
                                      tooltip: "Chat",
                                      icon: Icon(
                                        FontAwesomeIcons.solidComment,
                                        size: size!.getWidthPx(17),
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        //   Fluttertoast.showToast(
                                        //     msg: "Start Chatting with ${docsSnap['firstName']}",
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.BOTTOM,
                                        //     timeInSecForIos: 1,
                                        //     backgroundColor: Colors.black,
                                        //     textColor: Colors.white,
                                        //     fontSize: size!.getWidthPx(15)
                                        //   );
                                        var url = "sms:" +
                                            docsSnap['mobileNo'].toString();
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Can't Lauch Phone",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: size!.getWidthPx(15));
                                        }
                                      }),
                                ),
                              ),
                              SizedBox(width: size!.getWidthPx(10)),
                              Container(
                                width: size!.getWidthPx(40),
                                height: size!.getWidthPx(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      size!.getWidthPx(20)),
                                  border: Border.all(
                                      width: size!.getWidthPx(1),
                                      color: Colors.transparent),
                                  color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: IconButton(
                                    tooltip: "Pay Rent",
                                    icon: Icon(
                                      FontAwesomeIcons.wallet,
                                      size: size!.getWidthPx(17),
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PaymentPage(docsSnap)));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
