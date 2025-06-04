import 'package:flutter/material.dart';
import 'package:flutter_catch_up/providers/todo_provider.dart';
import 'package:provider/provider.dart';

/// 個別(1行あたりの)のTODOアイテムのウィジェット定義
/// 
/// 各TODOアイテムの表示、完了状態の切り替え、削除機能を提供する。
/// 
class TodoTile extends StatelessWidget {

  final int index;  // TODOリスト内でのアイテムのインデックス

  /// TodoTileのコンストラクタ
  /// 
  /// [key]はウィジェットの識別に使用される。
  /// [index]は必須パラメータで、TODOリスト内での位置を指定する。
  const TodoTile({super.key, required this.index});

  /// ウィジェットツリーを構築する
  /// 
  /// StatelessWidgetクラスの抽象メソッドbuildをオーバーライド。
  /// 
  /// context.watch<TodoProvider>()を使用してTodoProviderの状態を監視し、
  /// TODOデータが変更されるとこのウィジェットが自動的に再構築する  =>完了状態の変更や削除がリアルタイムでUIに反映される。
  /// 
  /// [context]はビルドコンテキスト（ウィジェットツリー内での位置情報）
  /// 
  /// Returns: 構築されたListTileウィジェット
  @override
  Widget build(BuildContext context) {
    // TodoProviderから指定されたインデックスのTODOアイテムを取得し、状態変更を監視
    final todo = context.watch<TodoProvider>().todos[index];

    return ListTile(
      // TODOのタイトルテキストを表示
      title: Text(
        todo.title,
        style: TextStyle(
          // 完了済みの場合は取り消し線を表示、未完了の場合は通常表示
          decoration: todo.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      // 左側にチェックボックスを配置
      leading: Checkbox(
        // TODOの完了状態をチェックボックスの値として設定
        value: todo.isDone,
        // チェックボックスがタップされた時の処理
        // context.read<TodoProvider>()で一回限りのアクセスを行い、
        // toggleTodoメソッドで指定インデックスのTODOの完了状態を切り替える
        // パラメータの_はコールバック関数の引数（bool値）を使用しないことを示す
        onChanged: (_) => context.read<TodoProvider>().toggleTodo(index),
      ),
      // 右側に削除ボタンを配置
      trailing: IconButton(
        // ゴミ箱アイコンを表示
        icon: const Icon(Icons.delete),
        // ボタンがタップされた時の処理
        // context.read<TodoProvider>()で一回限りのアクセスを行い、
        // removeTodoメソッドで指定インデックスのTODOを削除する
        onPressed: () => context.read<TodoProvider>().removeTodo(index),
      ),
    );
  }
}