import 'package:flutter/material.dart';
// import 'package:flutter_multi_chip_select/flutter_multi_chip_select.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/models/child_conditions.dart';
import 'package:snd_events/states/app_state.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/country_dropdown.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.dart';
import 'package:snd_events/widgets/textfield.with.controller.dart';

class AddCommunityScreen extends StatefulWidget {
  final String userToken;

  const AddCommunityScreen({Key key, @required this.userToken})
      : super(key: key);
  @override
  _AddCommunityScreenState createState() => _AddCommunityScreenState();
}

class _AddCommunityScreenState extends State<AddCommunityScreen> {
  String _name, _desc, _country = 'UG';
  var photo;
  TextEditingController _locationController = TextEditingController();
  List<ChildCondition> childConditions;
  List<int> selectedConditions = [];
  // final _multiSelectKey = GlobalKey<MultiSelectDropdownState>();

  final Geolocator _geolocator = Geolocator();
  Future<void> _onLookupCoordinatesPressed(
      BuildContext context, position) async {
    final List<Placemark> placemarks =
        await Future(() => _geolocator.placemarkFromPosition(position))
            .catchError((onError) {
      AppUtils.showToast("${onError.toString()}");
      return Future.value(List<Placemark>());
    });

    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      if (mounted) {
        // _countryController.text = pos.isoCountryCode;
        _locationController.text = '${pos.locality}';
      }
    }
  }

  @override
  void initState() {
    _getUserPosition();
    Repository().getChildConditions(token: widget.userToken).then((data) {
      // print("Conditions: $data");
      if (mounted)
        setState(() {
          childConditions = data;
        });
    });
    super.initState();
  }

  _getUserPosition() async {
    await _geolocator.getCurrentPosition().then((pos) {
      _onLookupCoordinatesPressed(context, pos);
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Community"),
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
                      ? Icon(
                          Icons.add_a_photo,
                          size: 50,
                        )
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextfieldWidget(
                        onTextChange: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                        hint: "Name"),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _desc = value;
                        });
                      },
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          labelStyle:
                              TextStyle(color: AppTheme.PrimaryDarkColor)),
                    ),
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
                    TextfieldControllerWidget(
                        controller: _locationController, hint: "City"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Topics",
                          style: TextStyle(
                            color: AppTheme.PrimaryDarkColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    childConditions != null
                        ? _checklistConditions()
                        // ? FlutterMultiChipSelect(
                        //     key: _multiSelectKey,
                        //     label: 'Select Topics',
                        //     elements: List.generate(
                        //         childConditions.length,
                        //         (index) => MultiSelectItem<String>.simple(
                        //             title: childConditions[index].name,
                        //             value:
                        //                 childConditions[index].id.toString())),
                        //     values: [])
                        : Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              backgroundColor: AppTheme.PrimaryDarkColor,
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    SubmitButtonWidget(onPressed: () {
                      if (_validateFields()) {
                        Repository()
                            .addCommunity(
                                token: widget.userToken,
                                name: _name,
                                desc: _desc,
                                //  topics: this._multiSelectKey.currentState.result,
                                topics: selectedConditions,
                                locationDistrict: _locationController.text,
                                country: _country,
                                photo: photo)
                            .then((data) {
                          print('Data: $data');
                          AppUtils.showToast('${data[Constants.KEY_RESPONSE]}');
                          // appState.getMyGroups();
                        }).catchError((onError) {
                          AppUtils.showToast(
                              "Please check your internet connection");
                          print("Error: $onError");
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
    return _name != null &&
        _name.isNotEmpty &&
        _desc != null &&
        _desc.isNotEmpty &&
        _locationController.text != null &&
        _locationController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Widget _checklistConditions() {
    return ListView.builder(
        itemCount: childConditions.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CheckboxListTile(
              activeColor: AppTheme.PrimaryDarkColor,
              title: Text(childConditions[index].name),
              value: selectedConditions.contains(childConditions[index].id),
              onChanged: (val) {
                setState(() {
                  if (selectedConditions.contains(childConditions[index].id)) {
                    selectedConditions.remove(childConditions[index].id);
                  } else {
                    selectedConditions.add(childConditions[index].id);
                  }
                });
                // print(selectedConditions);
              });
        });
  }
}
