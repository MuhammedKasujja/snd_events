import 'package:flutter/material.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/country_dropdown.dart';
import 'package:snd_events/widgets/datepicker.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.dart';
import 'package:snd_events/widgets/textfield.with.controller.dart';
import 'package:snd_events/widgets/timepicker.dart';
import 'package:geolocator/geolocator.dart';

class AddEventScreen extends StatefulWidget {
  final String userToken;

  const AddEventScreen({Key key, @required this.userToken}) : super(key: key);
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String theme, speaker, _country = 'UG';
  var photo;
  TextEditingController _districtController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  final Geolocator _geolocator = Geolocator();
  Future<void> _onLookupCoordinatesPressed(
      BuildContext context, position) async {
    final List<Placemark> placemarks =
        await Future(() => _geolocator.placemarkFromPosition(position))
            .catchError((onError) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(onError.toString()),
      ));
      return Future.value(List<Placemark>());
    });

    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      // _countryController.text = pos.isoCountryCode;
      _districtController.text = '${pos.locality}';
      _streetController.text = pos.thoroughfare;
      // setState(() {});
      // final List<String> coords = placemarks
      //     .map((placemark) =>
      //         pos.position?.latitude.toString() +
      //         ', ' +
      //         pos.position?.longitude.toString())
      //     .toList();
    }
  }

  @override
  void initState() {
    _getUserPosition();
    super.initState();
  }

  _getUserPosition() async {
    await _geolocator.getCurrentPosition().then((pos) {
      _onLookupCoordinatesPressed(context, pos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  color: Colors.grey[300],
                  height: 200,
                  width: double.infinity,
                  child: photo == null
                      ? Icon(Icons.add_a_photo, size: 50)
                      : Image.file(photo),
                ),
                onTap: () {
                  AppUtils.getImage().then((image) {
                    setState(() {
                      photo = image;
                    });
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextfieldWidget(
                        onTextChange: (value) {
                          setState(() {
                            theme = value;
                          });
                        },
                        hint: 'Theme'),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Starting",
                        style: TextStyle(
                          color: AppTheme.PrimaryDarkColor,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: DatepickerWidget(
                            controller: _startDateController,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          child: TimepickerWidget(
                            controller: _startTimeController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ending",
                        style: TextStyle(
                          color: AppTheme.PrimaryDarkColor,
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: DatepickerWidget(
                            controller: _endDateController,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          child: TimepickerWidget(
                            controller: _endTimeController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextfieldWidget(
                        onTextChange: (value) {
                          setState(() {
                            speaker = value;
                          });
                        },
                        hint: 'Speaker'),
                    SizedBox(
                      height: 10,
                    ),
                    CountryDropdownWidget(
                      onCountySelected: (country) {
                        print(country);
                        setState(() {
                          _country = country;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextfieldControllerWidget(
                        controller: _districtController, hint: 'District'),
                    SizedBox(
                      height: 5,
                    ),
                    TextfieldControllerWidget(
                        controller: _streetController, hint: 'Building Street'),
                    SizedBox(
                      height: 10,
                    ),
                    SubmitButtonWidget(onPressed: () {
                      if (_validateFields()) {
                        Repository()
                            .addEvent(
                                token: widget.userToken,
                                speaker: speaker,
                                endDate: _endDateController.text,
                                startDate: _startDateController.text,
                                locationDistrict: _districtController.text,
                                buildingStreet: _streetController.text,
                                theme: theme,
                                startTime: _startTimeController.text,
                                endTime: _endTimeController.text,
                                country: _country,
                                file: photo)
                            .then((data) {
                          AppUtils.showToast("${data['response']}");
                          print("Response: $data");
                        });
                      } else {
                        AppUtils.showToast(Constants.HINT_FILL_ALL_FIELDS);
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    return theme != null &&
        theme.isNotEmpty &&
        _startDateController.text != null &&
        _startDateController.text.isNotEmpty &&
        _endDateController.text != null &&
        _endDateController.text.isNotEmpty &&
        speaker != null &&
        speaker.isNotEmpty &&
        _districtController.text != null &&
        _districtController.text.isNotEmpty &&
        _streetController.text != null &&
        _streetController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _districtController.dispose();
    _streetController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}
