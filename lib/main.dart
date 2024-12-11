import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/add_message_screen/add_message_screen.dart';
import 'package:tp_flutter/edit_message_screen/edit_message_screen.dart';
import 'package:tp_flutter/error_page.dart';
import 'package:tp_flutter/message_list_screen/message_bloc/message_bloc.dart';
import 'package:tp_flutter/message_list_screen/message_list_screen.dart';
import 'package:tp_flutter/shared/blocs/message_interaction_bloc.dart';
import 'package:tp_flutter/shared/model/message.dart';
import 'package:tp_flutter/shared/services/local_messages_data_source/fake_local_messages_data_source.dart';
import 'package:tp_flutter/shared/services/messages_repository/messages_repository.dart';
import 'package:tp_flutter/shared/services/remote_messages_data_source/fake_messages_data_source.dart';

import 'message_list_screen/message_detail_screen/message_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MessagesRepository(
          remoteDataSource: FakeMessagesDataSource(),
          localMessagesDataSource: FakeLocalMessagesDataSource()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                MessageBloc(
                    messagesRepository: context.read<MessagesRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                MessageInteractionBloc(
                    messagesRepository: context.read<MessagesRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const MessageListScreen(),
            '/addMessageScreen': (context) => const AddMessageScreen(),
          },
          onGenerateRoute: (routeSettings) {
            Widget screen = ErrorPage(errorMessage: "Route invalide");
            final argument = routeSettings.arguments;

            switch (routeSettings.name) {
              case 'messageDetail':
                if (argument is Message) {
                  screen = MessageDetailScreen(message: argument);
                }
                break;
              case 'editMessage':
                if (argument is Message) {
                  screen = EditMessageScreen(messageToEdit: argument);
                }
                break;
            }

            return MaterialPageRoute(builder: (context) => screen);
          },
        ),
      ),
    );
  }
}
