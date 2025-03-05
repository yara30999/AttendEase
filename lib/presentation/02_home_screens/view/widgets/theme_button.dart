import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resourses/styles_manager.dart';
import '../../view_model/theme_bloc/theme_bloc.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  void _onThemeChange(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.wb_incandescent_outlined),
              title: FittedBox(
                alignment: AlignmentDirectional.centerStart,
                fit: BoxFit.scaleDown,
                child: Text("Theme", style: Styles.style16Medium()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<ThemeMode>(
                        value: ThemeMode.light,
                        groupValue: context.watch<ThemeBloc>().state.themeMode,
                        onChanged: (value) {
                          _onThemeChange(context);
                        },
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Light', style: Styles.style16Medium()),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<ThemeMode>(
                        value: ThemeMode.dark,
                        groupValue: context.watch<ThemeBloc>().state.themeMode,
                        onChanged: (value) {
                          _onThemeChange(context);
                        },
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("Dark", style: Styles.style16Medium()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
