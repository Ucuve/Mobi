import 'dart:async';
import 'arguments.dart';

class HelpCommand extends Command {
  HelpCommand() {
    addFlag('verbose', abbr: 'v', help: 'Print each command and its options.');
    addOption('command', abbr: 'c', help: 'Print only that command\'s usage.');
  }

  @override
  String get name => 'help';

  @override
  String get description => 'Prints usage information.';

  @override
  FutureOr<Object?> run(ArgResults args) async {
    var usage = runner.usage;
    for (var command in runner.commands) {
      usage += '\n ${command.usage}';
    }
    return usage;
  }
}