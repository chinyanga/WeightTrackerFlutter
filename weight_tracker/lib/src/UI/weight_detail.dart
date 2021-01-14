import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:weight_tracker/src/BLoC/delete_weight_bloc.dart';
import 'package:weight_tracker/src/BLoC/edit_weight_bloc.dart';
import 'package:weight_tracker/src/BLoC/home_bloc.dart';
import 'package:weight_tracker/src/UI/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/src/models/user.dart';
import 'package:weight_tracker/src/models/weight.dart';

class WeightDetailPage extends StatefulWidget {
  final Weight capturedWeightDetails;
  final User initialWeightDetails;
  final HomeBloC weightDetailBloC;
  WeightDetailPage(
      {Key key,
      @required this.capturedWeightDetails,
      @required this.initialWeightDetails,
      @required this.weightDetailBloC})
      : super(key: key);
  @override
  _WeightDetailPageState createState() => _WeightDetailPageState();
}

class _WeightDetailPageState extends State<WeightDetailPage> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("hh:mm a");
  final editWeightDetail = EditWeightBloC();
  final deleteWeightDetail = DeleteWeightBloC();
  int userId = 0;
  int weight = 30;
  int targetWeight = 65;
  DateTime dateTime = DateTime.now();
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();

  @override
  void initState() {
    super.initState();
    print(this.widget.capturedWeightDetails.user_id);
    userId = this.widget.capturedWeightDetails.user_id;
    dateTime = this.widget.capturedWeightDetails.date_time;
    weight = this.widget.capturedWeightDetails.weight;
  }

  @override
  void dispose() {
    deleteWeightDetail.dispose();
    editWeightDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight Detail"),
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
            Text(
                "Target Weight   ${this.widget.initialWeightDetails.target_weight}"),
            Text("Weight   ${this.widget.capturedWeightDetails.weight}"),
            Text(
                "Change   ${(this.widget.capturedWeightDetails.weight - this.widget.initialWeightDetails.target_weight).toString()}"),
            Text("Date   ${dateTime.year}-${dateTime.month}-${dateTime.day}"),
            Text("Time   ${dateTime.hour}: ${dateTime.minute}"),
            Row(
              children: [
                Text('Select Date'),
                Container(
                  width: 250,
                  child: DateTimeField(
                    format: dateFormat,
                    onChanged: (selectedDate) => date = selectedDate,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? date,
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
                  width: 200,
                  child: DateTimeField(
                    format: timeFormat,
                    onChanged: (selectedTime) => time = selectedTime,
                    onShowPicker: (context, currentValue) async {
                      final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? time,
                          ));
                      return DateTimeField.convert(selectedTime);
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
                        max: 200.0,
                        min: 0.0,
                        value: weight.toDouble(),
                        decimals: 1,
                        step: 0.1,
                        onChanged: (w) => weight = w.toInt(),
                      )),
                ],
              ),
              padding: const EdgeInsets.all(16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                        color: AppColors.green,
                        onPressed: () {
                          editWeightDetail
                              .editWeight(Weight(
                                  id: this.widget.capturedWeightDetails.id,
                                  weight: weight.toInt(),
                                  date_time: DateTime(date.year, date.month,
                                      date.day, time.hour, time.minute),
                                  user_id: this
                                      .widget
                                      .capturedWeightDetails
                                      .user_id))
                              .then((_) async {
                            await this
                                .widget
                                .weightDetailBloC
                                .fetchListOfAllUserWeights(userId)
                                .then((_) => Navigator.of(context).pop());
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
                        onPressed: () {
                          print(this.widget.capturedWeightDetails.id);
                          deleteWeightDetail
                              .deleteWeight(
                                  this.widget.capturedWeightDetails.id)
                              .then((_) async {
                            await this
                                .widget
                                .weightDetailBloC
                                .fetchListOfAllUserWeights(userId)
                                .then((_) => Navigator.of(context).pop());
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Text(
                              'Delete',
                              style: TextStyle(color: AppColors.white),
                            )))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
