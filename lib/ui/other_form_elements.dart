import 'package:flutter/material.dart';

class OtherFormElements extends StatefulWidget {
  const OtherFormElements({Key? key}) : super(key: key);

  @override
  State<OtherFormElements> createState() => _OtherFormElementsState();
}

class _OtherFormElementsState extends State<OtherFormElements> {
  bool checkBoxState = false;
  String sehir = "";
  bool switchState = false;
  double sliderDeger = 10;
  String selectedColor = "Kirmizi";
  List<String> cities = ["Ankara", "Bursa", "Istanbul", "Trabzon"];
  String selectedCity = "Ankara";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Other Form Elements"),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            value: checkBoxState,
            onChanged: (selected) {
              setState(() {
                checkBoxState = selected!;
              });
            },
            title: const Text("CheckBox Title"),
            subtitle: const Text("CheckBox subtitle"),
            activeColor: Colors.red,
            secondary:
                const Icon(Icons.add), //secondary ile genelde ikonlar koyulur.
            selected:
                true, // varsayılan değer için ve yazının rengini de kırmızı yaptı
          ),
          RadioListTile<String>(
            value: "Ankara",
            groupValue: sehir,
            onChanged: ((deger) {
              setState(() {
                sehir = deger!;
                debugPrint("secilen deger $deger");
              });
            }),
            title: const Text("Ankara"),
            subtitle: const Text("Radio subtitle"),
          ),
          RadioListTile<String>(
            value: "Bursa",
            groupValue: sehir,
            onChanged: ((deger) {
              setState(() {
                sehir = deger!;
                debugPrint("secilen deger $deger");
              });
            }),
            title: const Text("Bursa"),
            subtitle: const Text("Radio subtitle"),
          ),
          RadioListTile<String>(
            value: "İstanbul",
            groupValue: sehir,
            onChanged: ((deger) {
              setState(() {
                sehir = deger!;
                debugPrint("secilen deger $deger");
              });
            }),
            title: const Text("İstanbul"),
            subtitle: const Text("Radio subtitle"),
          ),
          SwitchListTile(
            value: switchState,
            onChanged: ((deger) {
              setState(() {
                switchState = deger;
              });
            }),
            title: const Text("Switch title"),
            subtitle: const Text("Switch subtitle"),
            secondary: const Icon(Icons.refresh),
          ),
          Slider(
            value: sliderDeger,
            onChanged: ((value) {
              setState(() {
                sliderDeger = value;
                debugPrint("slider degeri: $value");
              });
            }),
            min: 10,
            max: 20,
            divisions: 20, //kac aralıga bolunsun
            label: sliderDeger.toString(),
          ),
          DropdownButton<String>(
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.red,
                    ),
                    Text("Kirmizi"),
                  ],
                ),
                value: "Kirmizi",
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.blue,
                    ),
                    Text("Mavi"),
                  ],
                ),
                value: "Mavi",
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.green,
                    ),
                    Text("Yesil"),
                  ],
                ),
                value: "Yesil",
              ),
            ],
            onChanged: ((selectedValue) {
              setState(() {
                selectedColor = selectedValue!;
              });
            }),
            hint: Text("Seçiniz"),
            value: selectedColor,
          ),
          DropdownButton<String>(
              items: cities
                  .map((e) => DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(e),
                        ),
                        value: e,
                      ))
                  .toList(),
              onChanged: (s) {
                setState(() {
                  selectedCity = s!;
                });
              },
              value: selectedCity,),
        ],
      ),
    );
  }
}
