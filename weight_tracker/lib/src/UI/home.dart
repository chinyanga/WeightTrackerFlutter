import 'package:flutter/material.dart';
import 'package:weight_tracker/src/BLoC/home_bloc.dart';
import 'package:weight_tracker/src/UI/colors/colors.dart';
import 'package:weight_tracker/src/models/user.dart';
import 'package:weight_tracker/src/models/weight.dart';
import 'package:weight_tracker/src/routes/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBloC = HomeBloC();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Weight Tracker"),
            actions: [
              IconButton(
                  icon: Icon(Icons.exit_to_app),
                  color: AppColors.red,
                  onPressed: null)
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: [
                  Divider(height: 10),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Target Weight'), Text('50kgs')]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StreamBuilder<Object>(
                      stream: null,
                      builder: (context, weightSnapShot) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/weight/detail",
                                              arguments: WeightDetailPageArgs(
                                                  new Weight(),
                                                  new User(),
                                                  homeBloC));
                                        },
                                        child: ListTile(
                                          leading: Text('100kgs'),
                                          title: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text('2020-04-21',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          subtitle: Text('23:00'),
                                          trailing: Container(
                                            width: 100,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('-1.0'),
                                                  Icon(Icons
                                                      .keyboard_arrow_right)
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Divider(height: 10),
                                    ),
                                  ],
                                );
                              }),
                        );
                      }),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/add/weight", arguments: homeBloC);
            },
          ),
        ));
  }
}
