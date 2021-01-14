import 'package:flutter/material.dart';
import 'package:weight_tracker/src/BLoC/home_bloc.dart';
import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_response.dart';
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
  int targetWeight = 0;
  int userId = 0;
  @override
  void initState() {
    super.initState();
    homeBloC.getUserId().then((userId) {
      homeBloC.fetchListOfAllUserWeights(userId);
      setState(() {
        userId = userId;
      });
    });
    homeBloC.getTargetWeigt().then((tagWeight) {
      setState(() {
        targetWeight = tagWeight;
      });
    });
  }

  @override
  void dispose() {
    homeBloC.dispose();
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
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  })
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Target Weight'),
                          Text('$targetWeight Kgs')
                        ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StreamBuilder<ApiResponse<List<Weight>>>(
                      stream: homeBloC.weightListStream,
                      builder: (context, weightSnapShot) {
                        if (weightSnapShot.hasData) {
                          if (weightSnapShot.data.status == Status.LOADING)
                            return CircularProgressIndicator();
                          if (weightSnapShot.data.status == Status.COMPLETED)
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.70,
                              child: ListView.builder(
                                  itemCount: weightSnapShot.data.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 120,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/weight/detail",
                                                  arguments:
                                                      WeightDetailPageArgs(
                                                          weightSnapShot
                                                              .data.data[index],
                                                          User(
                                                              target_weight:
                                                                  targetWeight,
                                                              id: userId),
                                                          this.homeBloC));
                                            },
                                            child: ListTile(
                                              leading: Text(
                                                  '${weightSnapShot.data.data[index].weight}'),
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                    '${weightSnapShot.data.data[index].date_time.toString().split(" ")[0]}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              subtitle: Text(
                                                  '${weightSnapShot.data.data[index].date_time.toString().split(" ")[1]}'),
                                              trailing: Container(
                                                width: 100,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '${weightSnapShot.data.data[index].weight - targetWeight} kgs'),
                                                      Icon(Icons
                                                          .keyboard_arrow_right)
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Divider(height: 10),
                                        ),
                                      ],
                                    );
                                  }),
                            );
                        }
                        return Container();
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
