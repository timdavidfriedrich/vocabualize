import 'package:vocabualize_server/server.dart';

void main(List<String> args) {
  if (args case [final command, ...final commandArgs] when !command.startsWith("-")) {
    runCommand(command, commandArgs);
  } else {
    run(args);
  }
}
