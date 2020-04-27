
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendarwidget/CalendarElements/Information_About_Event.dart';
import 'package:calendarwidget/consts.dart';

class Calender_Widget extends StatefulWidget {
  Calender_Widget({@required this.main_text});

  final String main_text;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calender_Widget_State();
  }
}

class _Calender_Widget_State extends State<Calender_Widget> {
  static var now = new DateTime.now();
  static int current_year = now.year;
  static int current_month_number = (now.month - 1);
  static int current_day = now.day;

  int month_beginning_week_day = (now.weekday + 7 - current_day % 7) % 7;
  int selected_day = current_day;
  int selected_week_day = now.weekday - 1;
  List<List<int>> days_on_calendar;
  Map<int, int> days_in_month = {0 : 31, 1 : 28, 2 : 31, 3 : 30, 4 : 31, 5 : 30, 6 : 31, 7 : 31, 8 : 30, 9 : 31, 10 : 30, 11 : 31};
  Map<int, String> month_name = {0 : 'January', 1 : 'February', 2 : 'March', 3 : 'April', 4 : 'May', 5 : 'June', 6 : 'July', 7 : 'August', 8 : 'September', 9 : 'October', 10 : 'November', 11 : 'December'};

  List<String> days_of_week = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> times_in_day = ['9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '18:30', '19:00', '19:30', '20:00', '21:00'];
  int selected_time = 0;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getCalendarDays();
    if (current_year % 4 == 0)
    {
      days_in_month[1] = 29;
    }
    else
    {
      days_in_month[1] = 28;
    }
  }
  int get_week_day_from_day(int day) {
    return ((day - 1) % 7 + month_beginning_week_day) % 7;
  }
  void getCalendarDays() {
    List<List<int>> cal = new List<List<int>>();
    for (int i = 0; i < 7; i++)
      {
        cal.add(new List<int>());
      }
    for (int i = 0; i < month_beginning_week_day; i++)
    {
      cal[i % 7].add(0);
    }
    for (int i = month_beginning_week_day; i < month_beginning_week_day + days_in_month[current_month_number]; i++)
    {
      cal[i % 7].add(i - month_beginning_week_day + 1);
    }
    setState(() {
      days_on_calendar = cal;
    });

  }
  Widget getCalendar() {
    return Container(
      padding: EdgeInsets.only(left: 10),
    height: 350,
        width: 600,
        child : ListView.builder(
          scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: selected_week_day == index ? Colors.grey.shade100 : Colors.transparent
            ),

              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(days_of_week[index],
                        style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12
                      ),
                    )
                  ),
                  SizedBox(
                    width: 60, height: 296,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: days_on_calendar[index].length,
                    itemBuilder: (BuildContext ctxt, int ind) {
                      int day = days_on_calendar[index][ind];
                      if (day == 0) {
                        return SizedBox(width: 50, height: 50);
                      }
                      else {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                selected_day = day;
                                selected_week_day = get_week_day_from_day(day);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(day.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: day == selected_day
                                          ? Colors.white
                                          : Colors.black
                                  )
                              ),
                              decoration: BoxDecoration(
                                  color: day == selected_day ? blue : Colors
                                      .transparent,
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      25))
                              ),
                            ));
                      }
                    }
                  ))
                ],
          ));
        },
        itemCount: 7,
    ));
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.all(50),
        elevation: 0,
        color: Colors.white,
        child: Row(
        children: <Widget>[
          Container(
            width: 500,
            height: 674,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.schedule, size: 100,),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: <Widget>[
                            Text('Schedule a lesson',
                              style: TextStyle(
                                  color: blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35
                              ),
                            ),
                            Text(widget.main_text,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14
                              ),
                            )
                          ],
                        )
                      ],
                    )
                ),
                SizedBox(height: 80),
                Container(
                  width: 420,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today, size: 40, color: Colors.amber),
                        SizedBox(width: 20),
                        Text(month_name[current_month_number] + ' ' + current_year.toString(),
                          style: TextStyle(
                              color: blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget> [
                              FloatingActionButton(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.arrow_back_ios, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    current_month_number--;
                                    if (current_month_number == -1)
                                    {
                                      current_month_number = 11;
                                      current_year--;
                                      if (current_year % 4 == 0)
                                      {
                                        days_in_month[1] = 29;
                                      }
                                      else
                                      {
                                        days_in_month[1] = 28;
                                      }
                                    }
                                    current_day = 1;
                                    month_beginning_week_day = (month_beginning_week_day + 35 - days_in_month[current_month_number]) % 7;
                                    selected_day = current_day;
                                    selected_week_day = month_beginning_week_day;
                                    getCalendarDays();
                                    print(current_month_number.toString());
                                  });

                                },
                              ),
                              FloatingActionButton(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    month_beginning_week_day = (month_beginning_week_day + days_in_month[current_month_number]) % 7;
                                    current_month_number++;
                                    if (current_month_number == 12)
                                    {
                                      current_month_number = 0;
                                      current_year++;
                                      if (current_year % 4 == 0)
                                      {
                                        days_in_month[1] = 29;
                                      }
                                      else
                                      {
                                        days_in_month[1] = 28;
                                      }
                                    }
                                    current_day = 1;
                                    selected_day = current_day;
                                    selected_week_day = month_beginning_week_day;
                                    getCalendarDays();
                                    print(month_beginning_week_day.toString());
                                  });

                                },
                              )
                            ]
                          )
                        )
                      ],
                    )
                ),
                SizedBox(height: 40),
                getCalendar()
              ]
          )),
          Container(
            width: 200,
            height: 674,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 20),
                  child: Text('Pick a time',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                    ),
                )),
                SizedBox(
                  width: 300,
                height: 600,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected_time = index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 7),
                            child: Card(
                              color: selected_time == index ? blue : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                                height: 50,
                                child: Text(times_in_day[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: selected_time == index ? Colors.white : Colors.black
                                )
                              )),
                            elevation: 1,
                          )
                        )
                      );
                    },
                  itemCount: times_in_day.length,
                )
                )
              ],
            )
          ),
          Container(
             height: 624,
            width: 400,
            margin: EdgeInsets.only(top: 50, left: 30),
            child: Container(
                width: 350,
                height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                color: blue
              ),
              alignment: Alignment.bottomCenter,

                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          color: Colors.transparent
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30,
                            top: 50,
                            child: Container(
                              width: 290,
                              height: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                                  color: Colors.white70
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Norma Cooper',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: blue
                                      )),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text('Lecturer PhD',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black
                                      ),
                                    )
                                  ],
                                ),
                              )
                            )
                          ),
                          Positioned(
                            top: 80,
                            child: CircleAvatar(
                              radius: 35,
                              child: Container(),
                            ),
                          ),
                          Positioned(
                            top: 87,
                            right: 30,
                            child: FloatingActionButton(child: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey,),
                            elevation: 0,
                                backgroundColor: Colors.transparent,
                            )
                          )
                        ],
                      )
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Information_About_Event(icon: Icons.calendar_today, description: 'Date', info: selected_day.toString() + ' ' + month_name[current_month_number].toString() + ' ' + current_year.toString()),
                          Information_About_Event(icon: Icons.watch_later, description: 'Time', info: times_in_day[selected_time]),
                          Information_About_Event(icon: Icons.schedule, description: 'Duration', info: '45 min'),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: GestureDetector(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      color: Colors.yellow
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 35),
                                        child: Text('join a class',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: blue
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_forward_ios, size: 15, color: blue),
                                      )
                                    ],
                                  ),
                                )
                            ),
                          )
                        ],
                      )
                    ),



                  ],
                )

    )
          )
        ]
        )
    );
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
