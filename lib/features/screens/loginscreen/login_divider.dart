import 'package:flutter/material.dart';
class login_divider extends StatelessWidget {
  const login_divider({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: dark ? const Color.fromRGBO(68, 65, 65, 1) : Colors.grey,thickness: 0.5,indent: 60,endIndent: 5,)),
        Text("or sing in with",style: Theme.of(context).textTheme.labelMedium,),
        Flexible(child: Divider(color: dark ? const Color.fromRGBO(68, 65, 65, 1) : Colors.grey,thickness: 0.5,indent: 5,endIndent: 60,))
      ],
    );
  }
}
