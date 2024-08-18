import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';

void pickeCountryCode({
  required BuildContext context,
  required void Function(Country) onSelect,
}) =>
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        // optional. Shows phone code before the country name.
        onSelect: onSelect);

class PickCountryCode{
  final String phoneCode;

  PickCountryCode.name(this.phoneCode, this.flagEmoji);

  final String flagEmoji;

}