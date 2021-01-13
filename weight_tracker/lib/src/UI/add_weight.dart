import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/src/BLoC/add_weight_bloc.dart';
import 'package:weight_tracker/src/BLoC/home_bloc.dart';
import 'package:weight_tracker/src/UI/colors/colors.dart';
import 'package:weight_tracker/src/models/weight.dart';

class AddWeightPage extends StatefulWidget {
  final HomeBloC weightDetailBloC;
  AddWeightPage({Key key, @required this.weightDetailBloC, weightBloC})
      : super(key: key);
  @override
  _AddWeightPageState createState() => _AddWeightPageState();
}

class _AddWeightPageState extends State<AddWeightPage> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("hh:mm a");
  final addWeightBloC = AddWeightBloC();
  int userId = 4;

  @override
  void initState() {
    super.initState();
    this.widget.weightDetailBloC.getUserId().then((userId) {
      setState(() {
        userId = userId;
        print(userId);
      });
    });
  }

  @override
  void dispose() {
    addWeightBloC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capture Weight"),
        actions: [
          IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () => Navigator.of(context).pop())
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Divider(height: 10),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('Select Date'),
                Container(
                  width: 250,
                  child: DateTimeField(
                    format: dateFormat,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Select Time'),
                Container(
                  width: 250,
                  child: DateTimeField(
                    format: timeFormat,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              child: Row(
                children: [
                  Text('Weight'),
                  Container(
                      width: 250,
                      child: SpinBox(
                          max: 300.0,
                          min: 0.0,
                          value: 5.0,
                          decimals: 1,
                          step: 0.1)),
                ],
              ),
              padding: const EdgeInsets.all(16),
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                    color: AppColors.green,
                    onPressed: () {
                      addWeightBloC
                          .addWeight(new Weight(
                              userId: userId,
                              weight: 50,
                              date_time: DateTime.now()))
                          .then((_) async {
                        await this
                            .widget
                            .weightDetailBloC
                            .fetchListOfAllUserWeights(userId);
                        Navigator.of(context).pop();
                      });
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          'Save',
                          style: TextStyle(color: AppColors.white),
                        )))),
            Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                    color: AppColors.red,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.white),
                        )))),
          ],
        ),
      ),
    );
  }
}
