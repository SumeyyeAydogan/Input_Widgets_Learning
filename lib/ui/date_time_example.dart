import 'package:flutter/material.dart';

class DateTimeExample extends StatefulWidget {
  DateTimeExample({Key? key}) : super(key: key);

  @override
  State<DateTimeExample> createState() => _DateTimeExampleState();
}

class _DateTimeExampleState extends State<DateTimeExample> {
  late DateTime nowDate;
  late DateTime threeMonthsAgo;
  late DateTime twentyDaysLater;
  late TimeOfDay nowTime;

  @override
  void initState() {
    super.initState();
    nowDate = DateTime.now();
    threeMonthsAgo = DateTime(2023, nowDate.month - 3);
    twentyDaysLater = DateTime(2023, nowDate.month, nowDate.day + 20);
    nowTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Time Example"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: nowDate,
                    firstDate: threeMonthsAgo,
                    lastDate: twentyDaysLater,
                  ).then(
                    (value) {
                      debugPrint(value.toString());
                      debugPrint(value!.add(Duration(days: 20)).toString());
                    },
                  );
                  //future işlemi bittikten sonra then metodu tetikleniyor.
                  //DateTime.parse(String) String ifadeyi datetime'a dönüştürüyor.
                  //date_format veya intl paketini de kullanabilirsin.
                },
                child: const Text("Date"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  showTimePicker(context: context, initialTime: nowTime).then((value) {
                    debugPrint(value!.format(context));
                  });
                },
                child: const Text("Time"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
