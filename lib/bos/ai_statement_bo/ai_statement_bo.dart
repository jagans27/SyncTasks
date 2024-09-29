import 'package:hive/hive.dart';

part 'ai_statement_bo.g.dart';

@HiveType(typeId: 2)
class AIStatementBO {
  @HiveField(0)
  String date;
  @HiveField(1)
  String statement;

  AIStatementBO({required this.date, required this.statement});
}
