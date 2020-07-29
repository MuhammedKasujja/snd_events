import 'package:flutter/cupertino.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:snd_events/utils/app_theme.dart';

class CountryDropdownWidget extends StatelessWidget {
  final Function(String country) onCountySelected;
  final String defaultCountry;

  const CountryDropdownWidget({Key key, @required this.onCountySelected, this.defaultCountry})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CountryPickerDropdown(
        initialValue: this.defaultCountry == null ? 'UG' : this.defaultCountry,
        isExpanded: true,
        dropdownColor: AppTheme.PrimaryDarkColor,
        itemBuilder: (Country country) {
          return Container(
            child: Wrap(
              children: <Widget>[
                CountryPickerUtils.getDefaultFlagImage(country),
                SizedBox(width: 8.0),
                Text("${country.name}",)
              ],
            ),
          );
        },
        onValuePicked: (country) => this.onCountySelected(country.isoCode),
      ),
    );
  }
}
