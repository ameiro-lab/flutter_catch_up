import 'package:flutter/material.dart';
import '../models/todo.dart';

/// 状態管理クラス
/// Todoリストの状態を管理し、UIに変更を通知する
/// 
/// 継承している ChangeNotifier は「通知可能な状態管理の基本クラス」で
/// notifyListeners() を呼ぶことで、**このProviderに依存しているWidgetたちを再構築（再描画）**できる。
/// 
class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = []; // Todo型のリストを定義

  List<Todo> get todos => _todos; // getter

  // アクションの定義:  Todoを1つ追加し、追加したあとに notifyListeners() でUIを更新する
  void addTodo(String title) {
    _todos.add(Todo(title: title));
    notifyListeners();
  }

  // アクションの定義:  指定されたTodoの状態（完了/未完了）をトグルする
  void toggleTodo(int index) {
    _todos[index].toggleDone();
    notifyListeners();
  }

  // アクションの定義:  指定されたTodoを削除する
  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
