import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/ui/setting_query/widgets/widget_advanced_search.dart';
import 'package:chat_app/ui/setting_query/widgets/widget_basic_search.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'setting_query_cubit.dart';

class SettingQueryPage extends StatelessWidget {
  const SettingQueryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SettingQueryCubit();
      },
      child: const SettingQueryChildPage(),
    );
  }
}

class SettingQueryChildPage extends StatefulWidget {
  const SettingQueryChildPage({super.key});

  @override
  State<SettingQueryChildPage> createState() => _SettingQueryChildPageState();
}

class _SettingQueryChildPageState extends State<SettingQueryChildPage> {
  late final SettingQueryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(context: context, text: S().settingPageSearchText),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade200
          : Colors.grey.shade900,
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 50, top: 20),
      child: Column(
        children: [
          const BasicSearchWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().highSearchTitlePage,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  S().highSearchContent,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const AdvancedSearchWidget(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
