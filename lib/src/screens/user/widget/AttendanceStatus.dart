import 'package:fams/src/shared/styles.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

//전체보기 위젯
Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 10),
        child: Text(headerTitle, style: h4),
      ),
      Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        child: FlatButton(
          onPressed: onViewMore,
          child: Text('전체보기', style: contrastText),
        ),
      )
    ],
  );
}

//출석현황 위젯
Widget AttendanceStatus() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionHeader('출석 현황', onViewMore: () {}),
      Container(
        margin: EdgeInsets.all(10.0),
        color: Color(0xFFffffff),
        child: dropbtn(),
      ),
      Container(
        margin: EdgeInsets.all(10.0),
        color: Color(0xFFffffff),
        child: calendar(),
      ),
    ],
  );
}

// items 리스트를 변경하면 에러뜸 나중에 해결해봄
String dropdownValue = 'One';

@override
Widget dropbtn() {
  return DropdownButton<String>(
    value: dropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(
        color: Colors.black
    ),
    underline: Container(
      height: 2,
      color: Colors.black,
    ),
    onChanged: (String newValue) {
      setState(() {
        dropdownValue = newValue;
      });
    },
    items: <String>['One', 'Two', 'Free', 'Four']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    })
        .toList(),
  );
}
void setState(Null Function() param0) {
  return null;
}


//달력 위젯
final Map<DateTime, List> _selectedDay = {
  DateTime(2019, 4, 3): ['Selected Day in the calendar!'],
  DateTime(2019, 4, 5): ['Selected Day in the calendar!'],
  DateTime(2019, 4, 22): ['Selected Day in the calendar!'],
  DateTime(2019, 4, 24): ['Selected Day in the calendar!'],
  DateTime(2019, 4, 26): ['Selected Day in the calendar!'],
};
Widget calendar() {
  return TableCalendar(
    locale: 'en_US',
    events: _selectedDay,
    initialCalendarFormat: CalendarFormat.month,
    formatAnimation: FormatAnimation.slide,
    startingDayOfWeek: StartingDayOfWeek.sunday,
    availableGestures: AvailableGestures.none,
    availableCalendarFormats: const {
      CalendarFormat.month: 'Month',
    },
    calendarStyle: CalendarStyle(
      weekdayStyle: TextStyle(color: Colors.black),
      weekendStyle: TextStyle(color: Colors.black),
      outsideStyle: TextStyle(color: Colors.grey),
      unavailableStyle: TextStyle(color: Colors.grey),
      outsideWeekendStyle: TextStyle(color: Colors.grey),
    ),
    daysOfWeekStyle: DaysOfWeekStyle(
      dowTextBuilder: (date, locale) {
        return DateFormat.E(locale)
            .format(date)
            .substring(0, 3)
            .toUpperCase();
      },
      weekdayStyle: TextStyle(color: Colors.grey),
      weekendStyle: TextStyle(color: Colors.grey),
    ),
    headerVisible: false,
    builders: CalendarBuilders(
      markersBuilder: (context, date, events, holidays) {
        return [
          Container(
            decoration: new BoxDecoration(
              color: Color(0xFF30A9B2),
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.all(4.0),
            width: 4,
            height: 4,
          )
        ];
      },
      selectedDayBuilder: (context, date, _) {
        return Container(
          decoration: new BoxDecoration(
            color: Color(0xFF30A9B2),
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.all(4.0),
          width: 100,
          height: 100,
          child: Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    ),
  );
}

