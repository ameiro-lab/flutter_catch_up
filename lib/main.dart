import 'package:flutter/material.dart';
import 'package:flutter_catch_up/models/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main() 内で非同期処理（awaitを使う処理）がある場合、必須の記述

  // モバイル端末内のデータ保存用ディレクトリを取得する =>ここにHiveのデータファイルを置くことで、ユーザーの端末内にデータが永続化される
  final appDocDir = await getApplicationDocumentsDirectory();

  await Hive.initFlutter(appDocDir.path); // Hiveを初期化
  Hive.registerAdapter(TodoAdapter());    // HiveにTodoクラスのアダプターを登録 =>todo.g.dart で自動生成されたクラスを指定する。これによりHiveがTodoクラスのデータを保存・読み込みできるようになる
  runApp(const MyTodo());
}