import 'package:flutter_web/gestures.dart';
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
  final TextEditingController controller;

  const TextFormFieldUUR({Key key, this.focusNode, this.labelText = "Text Field", this.obscureText = false, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.indigo.withAlpha(20),
            labelText: labelText,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.indigo)
            )
        ),
      ),
    );
  }

}

class MediumButton extends StatelessWidget {
  final EdgeInsets padding;
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final bool secondary;

  const MediumButton({Key key, this.padding = const EdgeInsets.all(8), this.onPressed, this.child, this.color, this.secondary = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primary = !secondary ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withAlpha(100);
    // TODO: implement build
    return Padding(
      padding: padding,
      child: MaterialButton(
        onPressed: onPressed,
        height: 45,
        elevation: 1.0,
        color: color == null ? primary : color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: ConstrainedBox(
            child: Center(
              child: child,
            ),
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: 150
          ),
        ),
      ),
    );
  }
}

class HyperLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const HyperLink({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RichText(
      text: new TextSpan(
        text: text ?? 'Hyperlink',
        style: new TextStyle(color: Colors.blue,),
        recognizer: new TapGestureRecognizer()
          ..onTap = onTap,
      ),
    );
  }
}

class UURDropDownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T value;
  final ValueChanged<T> onChanged;
  final String hint;

  const UURDropDownButton({Key key, this.items, this.value, this.onChanged, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonHideUnderline(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.indigo.withAlpha(20),
            borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          child: DropdownButton<T>(
            hint: Text("  " + (hint ?? "")),
            value: value,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}