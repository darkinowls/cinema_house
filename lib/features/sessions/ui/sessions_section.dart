import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sessions/sessions_cubit.dart';
import 'horizontal_session_list_view.dart';

class SessionsSection extends StatelessWidget {
  const SessionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Sessions section", style: TextStyle(fontSize: 18)),
        SizedBox(
          height: 175,
          child: BlocBuilder<SessionsCubit, SessionsState>(
            builder: (context, state) {
              return HorizontalSessionListView(
                  sessions: state.sessions);
            },
          ),
        ),
      ],
    );
  }
}
