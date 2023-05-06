import 'package:cinema_house/core/status.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/locale_keys.g.dart';
import '../../../ui/widgets/result_sign.dart';
import '../cubit/sessions/sessions_cubit.dart';
import 'horizontal_session_list_view.dart';

class SessionsSection extends StatelessWidget {
  const SessionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.sessionsSection.tr(),
                style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            IconButton(
                onPressed: () async {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)))
                      .then((date) => BlocProvider.of<SessionsCubit>(context)
                          .loadByDate(date));
                },
                icon: const Icon(Icons.date_range))
          ],
        ),
        SizedBox(
          height: 175,
          child: BlocBuilder<SessionsCubit, SessionsState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Loader();
              }
              if (state.sessions.isEmpty) {
                return const ResultSign(
                  iconData: Icons.error,
                  text: "No sessions",
                );
              }

              return HorizontalSessionListView(sessions: state.sessions);
            },
          ),
        ),
      ],
    );
  }
}
