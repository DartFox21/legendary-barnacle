import 'package:flutter/material.dart';
import 'package:godartadmin/view_models/login_vm.dart';
import 'package:godartadmin/widgets/buttons/login_btn.dart';
import 'package:godartadmin/widgets/texts/custom_text.dart';
import 'package:provider/src/provider.dart';

import '../navbar_logo.dart';
import '../navigation_bar.dart';

class NavbarDesktop extends StatelessWidget {
  const NavbarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          const NavBarLogo(),
          const SizedBox(
            height: 80,
          ),
          ...NavBar.getDrawerOptions(),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: CustomButton(
                      normal: false,
                      btnColor: Colors.redAccent.withAlpha(60),
                      onPressed: () async {
                        await context.read<LoginVM>().logOut();
                      },
                      child: const CustomText(
                        text: 'Logout',
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
