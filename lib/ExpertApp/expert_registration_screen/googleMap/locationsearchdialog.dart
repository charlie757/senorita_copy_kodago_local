import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ScreenRoutes/routes.dart';
import 'controller/googleMapController.dart';

class LocationSearchDialog extends StatelessWidget {
  //final GoogleMapController? mapController;

  //const LocationSearchDialog({});


  @override
  Widget build(BuildContext context) {
    MapController mapController1=MapController();
    final TextEditingController _controller = TextEditingController();
    return Container(
      margin: EdgeInsets.only(top : 150),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      child: /*Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(width: 350,
            child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
            textInputAction: TextInputAction.search,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              hintText: 'search_location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(style: BorderStyle.none, width: 0),
              ),
              hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: 16, color: Theme.of(context).disabledColor,
              ),
              filled: true, fillColor: Theme.of(context).cardColor,
            ),
            style: Theme.of(context).textTheme.headline2?.copyWith(
              color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20,
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await Get.find<MapController>().searchLocation(context, pattern);
          },
          itemBuilder: (context, Prediction suggestion) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Row(children: [
                //Icon(Icons.location_on),
                Expanded(
                  child: Text(
                      suggestion.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Colors.black87, fontSize: 20,
                  )),
                ),
              ]),
            );
          },
          onSuggestionSelected: (Prediction suggestion) {
            print("My location is "+
                suggestion.description!);
            mapController1.locationController.text=suggestion.description.toString();
            Text(
                suggestion.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: Colors.black87, fontSize: 20,
                ));
           Get.toNamed(AppRoutes.googleMap,arguments: suggestion.description.toString());
          },
        )),
      ),*/
      SizedBox(),
    );
  }
}