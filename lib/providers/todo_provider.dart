import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo.dart';

/// 状態管理クラス
/// Todoリストの状態を管理し、UIに変更を通知する
/// 
/// 継承している ChangeNotifier は「通知可能な状態管理の基本クラス」で
/// notifyListeners() を呼ぶことで、**このProviderに依存しているWidgetたちを再構築（再描画）**できる。
/// 
class TodoProvider extends ChangeNotifier {

  late Box<Todo> _todoBox;          // HiveBox（ローカルDB）用の変数。非同期処理で開く必要があるためlate
  late Future<void> initBoxFuture;  // 初期化処理 _initBox() の Future を格納しておく変数

  // ゲッターの定義
  List<Todo> get todos => _todoBox.values.toList(); // HiveBox から全データを取得する

  // コンストラクタ：プロバイダーが生成されたときにBoxの初期化処理を開始する。
  // initBoxFuture は FutureBuilder 等で初期化完了を監視するために使う。
  TodoProvider() {
    initBoxFuture = _initBox();
  }

  // 非同期でHiveのBox（todos）を開くメソッド。
  // 開いたBoxはクラス内の変数 _todoBox に保持される。
  Future<void> _initBox() async {
    _todoBox = await Hive.openBox<Todo>('todos'); // HiveBox('todos'とラベル付)を開き、_todoBox に保持する
    notifyListeners();  // Providerを監視しているWidgetに変更を通知する
  }

  // アクションの定義:  Todoを1つ追加し、追加したあとに notifyListeners() でUIを更新する
  void addTodo(String title) {
    final todo = Todo(title: title);
    _todoBox.add(todo);  // Hiveに保存
    notifyListeners();
  }

  // アクションの定義:  指定されたTodoの状態（完了/未完了）をトグルする
  void toggleTodo(int index) {
    final todo = _todoBox.getAt(index);
    if (todo != null) {
      todo.toggleDone();
      todo.save();  // Hiveの保存更新
      notifyListeners();
    }
  }

  // アクションの定義:  指定されたTodoを削除する
  void removeTodo(int index) {
    _todoBox.deleteAt(index);  // Hiveから削除
    notifyListeners();
  }
}
