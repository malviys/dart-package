library dex_generator;

import 'package:build/build.dart';
import 'package:dex_generator/src/data_class_generator.dart';
import 'package:dex_generator/src/enum_class_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder dex(BuilderOptions _) => SharedPartBuilder(
      [
        DataClassGenerator(),
        EnumClassGenerator(),
      ],
      'dex',
    );
