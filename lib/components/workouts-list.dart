import 'package:calc/domain/workout.dart';
import 'package:flutter/material.dart';

class WorkoutsList extends StatefulWidget{

  @override
  _WorkoutsListState createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {

  @override
  void initState(){
    clearFilter();
    super.initState();
  }

  final workouts = <Workout>[
    Workout(title: 'test1',author: 'test12',description: 'test13',level: 'beginner'),
    Workout(title: 'test2',author: 'test22',description: 'test23',level: 'intermediate'),
    Workout(title: 'test3',author: 'test32',description: 'test33',level: 'advanced'),
    Workout(title: 'test4',author: 'test42',description: 'test43',level: 'beginner'),
    Workout(title: 'test5',author: 'test52',description: 'test53',level: 'intermediate'),
  ];

  var filterOnlyMyWorkouts = false;
  var filterTitle = '';
  var filterTitleController = TextEditingController();
  var filterLevel = 'Any Level';

  var filterText = '';
  var filterHeight = 0.0;

  List<Workout> filter() {
    setState(() {
      filterText = filterOnlyMyWorkouts ? 'My Workouts' : 'All workouts';
      filterText += '/' + filterLevel;
      if (filterTitle.isNotEmpty) filterText += '/' + filterTitle;
      filterHeight = 0;
    });

    var list = workouts;
    return list;
  }

  List<Workout> clearFilter() {
    setState(() {
      filterText = 'All workouts/Any Level';
      filterOnlyMyWorkouts = false;
      filterTitle = '';
      filterLevel = 'Any Level';
      filterTitleController.clear();
      filterHeight = 0;
    });

    var list = workouts;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var workoutsList = Expanded(
      child: Container(
        child: ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, i){
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(50, 65, 85, 0.9)
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.fitness_center,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(width: 1, color: Colors.white24)
                          )
                      ),
                    ),
                    title: Text(workouts[i].title, style: TextStyle(color: Theme.of(context).textTheme.headline6.color, fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                    subtitle: Subtitle(context, workouts[i]),
                  ),
                ),
              );
            }
        ),
      ));

    var filterInfo = Container(
      margin: EdgeInsets.only(top: 3, left: 7, right: 7, bottom: 5),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      height: 40,
      child: RaisedButton(
        child: Row(
          children: <Widget>[
            Icon(Icons.filter_list),
            Text(
              filterText,
              style: TextStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            filterHeight = (filterHeight == 0.0 ? 280.0 : 0.0);
          });
        },
      ),
    );
    var levelMenuItems = <String>[
      'Any Level',
      'Beginner',
      'Intermediate',
      'Advanced'
    ].map((String value) {
      return new DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList();
    var filterForm = AnimatedContainer(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Only My Workouts'),
                value: filterOnlyMyWorkouts,
                onChanged: (bool val) => setState(() => filterOnlyMyWorkouts = val)),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Level'),
                items: levelMenuItems,
                value: filterLevel,
                onChanged: (String val) => setState(() => filterLevel = val),
              ),
              TextFormField(
                controller: filterTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (String val) => setState(() => filterTitle = val),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        filter();
                      },
                      child: Text("Apply", style: TextStyle(color: Colors.white)),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        clearFilter();
                      },
                      child: Text("Clear", style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: filterHeight,
    );

    return Column(
      children: <Widget>[
        filterInfo,
        filterForm,
        workoutsList,
      ],
    );
  }
}

Widget Subtitle(BuildContext context, Workout workout){
  var color = Colors.grey;
  double indicatorLevel = 0;
  switch(workout.level){
    case 'beginner':
      color = Colors.green;
      indicatorLevel = 0.33;
      break;
    case 'intermediate':
      color = Colors.yellow;
      indicatorLevel = 0.66;
      break;
    case 'advanced':
      color = Colors.orange;
      indicatorLevel = 1;
  }

  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: LinearProgressIndicator(
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          value: indicatorLevel,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
      SizedBox(
          width: 10
      ),
      Expanded(
        flex: 3,
        child: Text(workout.level, style: TextStyle(color: Theme.of(context).textTheme.headline6.color)),
      )
    ],
  );
}