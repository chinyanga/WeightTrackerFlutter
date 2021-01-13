import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
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
      @required this.weightDetailBloC,
      weightBloC})
      : super(key: key);
  @override
  _WeightDetailPageState createState() => _WeightDetailPageState();
}

class _WeightDetailPageState extends State<WeightDetailPage> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("hh:mm a");

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
            Text("Target Weight"),
            Text("Change"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                        color: AppColors.green,
                        onPressed: () {},
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
