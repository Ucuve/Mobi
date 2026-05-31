import 'package:cli_app/cli_app.dart';
import 'package:command_runner/command_runner.dart';
import 'package:cli_app/src/commands/search_command.dart';
import 'package:cli_app/src/commands/get_article_command.dart';

void main(List<String> arguments) async {
  final errorLogger = initFileLogger('errors');
  final app = CommandRunner(
    onOutput: (String output) async {
      await write(output);
    },
    onError: (Object error) {
      if (error is Error) {
        errorLogger.severe('[Error] ${error.toString()}\n${error.stackTrace}');
        throw error;
      }
      if (error is Exception) {
        errorLogger.warning(error.toString());
      }
    },
  )
    ..addCommand(HelpCommand())
    ..addCommand(SearchCommand(logger: errorLogger))
    ..addCommand(GetArticleCommand(logger: errorLogger));

  app.run(arguments);
}