import 'dart:async';
import 'dart:io';
import 'package:command_runner/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:wikipedia/wikipedia.dart';

class SearchCommand extends Command {
  SearchCommand({required this.logger}) {
    addFlag('im-feeling-lucky', help: 'Prints summary of the top article.');
  }

  final Logger logger;

  @override
  String get description => 'Search for Wikipedia articles.';
  @override
  bool get requiresArgument => true;
  @override
  String get name => 'search';
  @override
  String get valueHelp => 'STRING';
  @override
  String get help => 'Prints a list of links to Wikipedia articles.';

  @override
  FutureOr<String> run(ArgResults args) async {
    if (args.commandArg == null || args.commandArg!.isEmpty) {
      return 'Please include a search term';
    }

    final buffer = StringBuffer('Search results:\n');
    try {
      final results = await search(args.commandArg!);

      if (args.flag('im-feeling-lucky')) {
        final title = results.results.first.title;
        final article = await getArticleSummaryByTitle(title);
        buffer.writeln('Lucky you!');
        buffer.writeln(article.titles.normalized.titleText);
        if (article.description != null) buffer.writeln(article.description);
        buffer.writeln(article.extract);
        buffer.writeln('\nAll results:');
      }

      for (var result in results.results) {
        buffer.writeln('${result.title} - ${result.url}');
      }
      return buffer.toString();
    } on HttpException catch (e) {
      logger.warning(e.message);
      return e.message;
    } on FormatException catch (e) {
      logger.warning(e.message);
      return e.message;
    }
  }
}