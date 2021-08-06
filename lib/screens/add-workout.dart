import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:calc/components/common/save-button.dart';
import 'package:calc/components/common/toast.dart';
import 'package:calc/core/constants.dart';
import 'package:calc/domain/workout.dart';
import 'package:calc/screens/add-workout-week.dart';

class AddWorkout extends StatefulWidget {
  final WorkoutSchedule workoutSchedule;

  AddWorkout({Key key, this.workoutSchedule}) : super(key: key);

  @override
  _AddWorkoutState createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout>{
  final _fbKey = GlobalKey<FormBuilderState>();

  WorkoutSchedule workout = WorkoutSchedule(weeks: []);

  @override
  void initState() {
    if(widget.workoutSchedule != null) workout = widget.workoutSchedule.copy();
    super.initState();
  }

  void _saveWorkout() {
    if(_fbKey.currentState.saveAndValidate()){
      if(workout.weeks == null || workout.weeks.length == 0){
        buildToast('Please add at least one training week');
        return;
      }

      Navigator.of(context).pop(workout);
    } else {
      buildToast('Ooops! Something is not right');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Workout'),
        actions: <Widget>[
          SaveButton(onPressed: _saveWorkout)
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: bgColorWhite),
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              autovalidate: false,
              child: Column(
                children: <Widget>[

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}