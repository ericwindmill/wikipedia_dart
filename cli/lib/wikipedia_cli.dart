/// Contains the classes needed to build an interactive command line application
/// If this wasn't a demo project, this would likely be three separate
/// libraries
/// * The [Console] subdirectory contains classes and functions that make it
///   easy to format and style the output to the terminal. This subdirectory
///   is completely agnostic to this project, and should be a separate library.
/// * The [Command], [Args], and [InteractiveCommandRunner] classes collectively
///   assist with creating interactive command line apps. They are also agnostic
///   to this project.
/// * The rest of the code, namely the classes that implement Command, handle
///   the business logic for this app.
library;

import 'package:cli/src/model/command.dart' show Args, Command;
import 'package:cli/wikipedia_cli.dart' show Console, InteractiveCommandRunner;

export 'src/app.dart';
export 'src/commands/article.dart';
export 'src/commands/help.dart';
export 'src/commands/quit.dart';
export 'src/commands/timeline.dart';
export 'src/console/console.dart';
