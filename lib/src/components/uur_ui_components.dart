import 'package:flutter_web/gestures.dart';
import 'package:flutter_web/material.dart';
import 'package:uur_flutter_website/font_awesome/font_awesome_flutter.dart';
import 'package:uur_flutter_website/src/components/uur_icon.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';

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
  final Function validator;

  const TextFormFieldUUR({Key key, this.focusNode, this.labelText = "Text Field", this.obscureText = false, this.controller, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        focusNode: focusNode,
        controller: controller,
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

class TeamCard extends StatelessWidget {
  final Team team;
  final VoidCallback onPressed;

  const TeamCard({Key key, this.team, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: UURIcon(FontAwesomeIcons.robot),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(team.name,style: Theme.of(context).textTheme.headline,),
                        Text(team.number, style: Theme.of(context).textTheme.subhead,)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayBox extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  DisplayBox({this.child, this.borderRadius = 8.0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 45,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            color: Colors.indigo.withAlpha(20)
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

enum ToggleButtonAlign {START, MIDDLE, END}

class ToggleButton extends StatelessWidget {
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

  final Widget child;
  final ToggleButtonAlign buttonAlignment;
  final double radius;

  const ToggleButton({Key key, this.onChanged, this.title, this.value, this.child, this.buttonAlignment, this.radius = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onChanged != null ? () {onChanged(!value);} : null,
      child: InkWell(
        onTap: () => onChanged(!value),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(buttonAlignment == ToggleButtonAlign.START ? buttonAlignment == ToggleButtonAlign.MIDDLE ? 0 : radius : 0),
              topRight: Radius.circular(buttonAlignment == ToggleButtonAlign.START ? buttonAlignment == ToggleButtonAlign.MIDDLE ? 0 : 0 : radius),
              bottomLeft: Radius.circular(buttonAlignment == ToggleButtonAlign.START ? buttonAlignment == ToggleButtonAlign.MIDDLE ? 0 : radius : 0),
              bottomRight: Radius.circular(buttonAlignment == ToggleButtonAlign.START ? buttonAlignment == ToggleButtonAlign.MIDDLE ? 0 : 0 : radius)
            ),
            border: Border(
              top: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              bottom: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              left: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              right: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            ),
            color: Colors.indigo.withAlpha(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: child
            ),
          ),
        ),
      ),
//      Row(
//        mainAxisAlignment: alignment,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(right: 4.0),
//            child: Checkbox(
//              value: value,
//              onChanged: onChanged,
//            ),
//          ),
//          title
//        ],
//      ),
    );
  }
}

class ButtonGroup extends StatelessWidget {
  final List<Widget> children;

  ButtonGroup({this.children});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: children,
      ),
    );
  }
}