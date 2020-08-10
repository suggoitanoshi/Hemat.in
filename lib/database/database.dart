import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';

part 'database.g.dart';

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  IntColumn get amount => integer()();

  TextColumn get category => text()();

  DateTimeColumn get date => dateTime()();
}

class Limits extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get limit => integer()();
}

@UseMoor(tables: [Expenses, Limits])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true)));
  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onUpgrade: (m, from, to) async {
        if (from == 1) {
          await m.createTable(limits);
        }
      });
  Stream<List<Expense>> watchAllExpenses() => select(expenses).watch();

  Future<List<Expense>> getAllExpenses() => select(expenses).get();

  Future<List<Expense>> getThisMonthExpenses(DateTime thisMonth) =>
      (select(expenses)..where((a) => a.date.month.equals(thisMonth.month)))
          .get();

  //Buat jumlah perbulan, panggil aja getThisMonthExpenses terus hasilnya tambahil .date.month.sum()

  Future<List<Expense>> getAllExpensesSum() {
    final expenseSum = expenses.amount.sum();
    final query = select(expenses)..addColumns([expenseSum]);

    return (query).get();
  }

  Future insertExpense(Expense expense) => into(expenses).insert(expense);

  Future deleteExpense(Expense expense) => delete(expenses).delete(expense);

  Future<List<Limit>> getLimit() => select(limits).get();

  Future setLimit(Limit limit) => update(limits).replace(limit);

  Future addLimit(Limit limit) => into(limits).insert(limit);

  @override
  int get schemaVersion => 2;
}
