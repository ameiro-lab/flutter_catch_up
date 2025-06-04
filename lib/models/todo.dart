import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)  // Hiveで保存されるデータ型であることを示す。idはアプリ上で一意のキー
class Todo extends HiveObject {

  @HiveField(0) // Hiveで保存されるデータであることを示す。指定した番号は絶対に変えないこと
  String title;

  @HiveField(1)
  bool isDone;

  // コンストラクタ：タイトルを必須とし、完了状態は初期値false
  Todo({
    required this.title,
    this.isDone = false,
  });

  // 完了状態を反転させるメソッド（完了 ⇔ 未完了 を切り替える）
  void toggleDone() {
    isDone = !isDone;
  }
}
