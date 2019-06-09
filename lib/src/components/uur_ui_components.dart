import 'package:flutter_web/material.dart';

class CheckboxWithLabel extends StatelessWidget {
  /// Called when the value of the checkbox should change.
  ///
  /// The checkbox passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the checkbox tile with the
  /// new value.
  ///
  /// If null, the checkbox will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  final ValueChanged<bool> onChanged;
  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  final Widget title;
  /// Whether this checkbox is checked.
  ///
  /// This property must not be null.
  final bool value;

  final MainAxisAlignment alignment;

  const CheckboxWithLabel({Key key, this.onChanged, this.title, this.value, this.alignment = MainAxisAlignment.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onChanged != null ? () {onChanged(!value);} : null,
      child: Row(
        mainAxisAlignment: alignment,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Checkbox(
              value: value,
              onChanged: onChanged,
            ),
          ),
          title
        ],
      ),
    );
  }
}

class TextFormFieldUUR extends StatelessWidget {
  final FocusNode focusNode;
  final String labelText;
  final bool obscureText;

  const TextFormFieldUUR({Key key, this.focusNode, this.labelText = "Text Field", this.obscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.indigo.withAlpha(20),
            labelText: labelText,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo)
            )
        ),
      ),
    );
  }

}