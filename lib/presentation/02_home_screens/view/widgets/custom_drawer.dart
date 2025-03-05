import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/constant_manager.dart';
import '../../../resourses/styles_manager.dart';
import 'language_button.dart';
import 'logout_button_bloc_consumer.dart';
import 'theme_button.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(
        height: double.infinity,
        width: MediaQuery.sizeOf(context).width * .7,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Material(
                color: Theme.of(context).primaryColor,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 60),
                  child: Center(
                    child: SafeArea(
                      child: Text(
                        AppConstants.AttendEase,
                        style: Styles.style35Bold(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            const SliverToBoxAdapter(child: ThemeButton()),
            const SliverToBoxAdapter(child: Divider(color: ColorsManager.grey)),
            const SliverToBoxAdapter(child: LanguageButton()),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(child: SizedBox(height: 10)),
                  Divider(color: ColorsManager.grey),
                  SizedBox(height: 5),
                  LogoutButtonBlocConsumer(),
                  SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
