import 'package:flutter/material.dart';
import 'package:flutter_catch_up/models/widgets/todo_tile.dart';
import 'package:flutter_catch_up/providers/todo_provider.dart';
import 'package:provider/provider.dart';


/// TODOリスト画面のウィジェット定義
/// 
/// TextEditingControllerを使用してテキスト入力を管理し、
/// Provider パターンを通じてTODOデータの状態管理を行う。
/// 
class TodoListScreen extends StatefulWidget {   // 状態を持つウェジット
  const TodoListScreen({super.key});

  /// StatefulWidgetクラスで必須：Stateオブジェクトを作成する（createState≒onMounted）
  /// 
  /// TodoListScreen は「状態を持つウィジェット」なので、
  /// 描画時に Stateオブジェクト（状態管理するオブジェクト≒data/computed）を生成する。
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

/// TodoListScreenの状態を管理するオブジェクトの定義
/// 
/// Stateクラスを継承し、StatefulWidgetの実際の状態と動作を定義する。
/// ※プライベートクラス（クラス名が_で始まる）のため、このファイル外からは直接アクセスできない。
/// 
class _TodoListScreenState extends State<TodoListScreen> {

  // Flutterのテキスト入力欄（TextField）の管理用に、コントローラーを定義する(≒ref)
  final TextEditingController _controller = TextEditingController();  

  /// 新しいTODOアイテムを追加するメソッド
  void _addTodo() {
    // 入力値を取得し、前後の空白を除去
    final text = _controller.text.trim();
    
    // 入力値が空でない場合、
    if (text.isNotEmpty) {
      // Todoを1つ追加する。
      context.read<TodoProvider>().addTodo(text); // context.read<TodoProvider>()はProviderパターンでのデータ取得方法。=>定義したaddTodo()を呼び出している。
      // 入力欄をクリアする。
      _controller.clear();
    }
  }

  /// ウィジェットツリーを構築する
  /// 
  /// StatefulWidgetのStateクラスの抽象メソッドbuildをオーバーライド。
  /// このメソッドはFlutterフレームワークによって自動的に呼び出され、
  /// 状態が変更されるたびに再実行されてUIを更新する。
  /// 
  /// context.watch<TodoProvider>()はProviderパターンでの状態監視方法で、
  /// TodoProviderの状態が変更されるとこのbuildメソッドが自動的に再実行される。
  /// 
  /// [context]はビルドコンテキスト（ウィジェットツリー内での位置情報）
  /// 
  /// Returns: 構築されたウィジェットツリー
  @override
  Widget build(BuildContext context) {

    final todoProvider = context.read<TodoProvider>();  // context.read<TodoProvider>()はProviderパターンでのデータ取得方法

    return FutureBuilder( // 非同期処理（Future） を待ってからUIを出し分ける Flutterの標準ウィジェット
      future: todoProvider.initBoxFuture, // todoProvider#initBoxFuture の完了を待つの意味
      builder: (context, snapshot) {      // builder は非同期処理の進行状況に応じて、UIを構築する関数。snapshot に非同期処理（Future）の現在の状態・結果などが格納される
        // 初期化中は、
        if (snapshot.connectionState == ConnectionState.waiting) {
          // ローディング表示する
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        // 初期化中にエラーが起きた場合、
        } else if (snapshot.hasError) {
          // エラーメッセージを表示
          return Scaffold(
            body: Center(child: Text('初期化エラーが発生しました')),
          );

        // 初期化が成功した場合、
        } else {
          // 状態変更を監視、変化があれば最新のTODOリストを格納し、 build() を再実行する
          final todos = context.watch<TodoProvider>().todos;  // context.watch<TodoProvider>()はProviderパターンで状態を監視し、変更があればUIを再構築するためのデータ取得方法。

          return Scaffold(  // Scaffold は Flutter が提供する、マテリアルデザインの画面レイアウトの骨組みウィジェット
            /// アプリバーの設定
            appBar: AppBar(title: const Text('TODOアプリ')),
            /// ボディの設定
            body: Column(
              children: [
                /// 新規TODOテキストフィールド入力部分
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,  // 定義したコントローラーを設定
                          decoration: const InputDecoration(labelText: '新しいタスク'), // ラベルテキストの設定
                        ),
                      ),
                      // 追加ボタン
                      IconButton(
                        icon: const Icon(Icons.add),  // アイコンを設定
                        onPressed: _addTodo,          // タップ時に定義した_addTodoメソッドを実行
                      ),
                    ],
                  ),
                ),
                /// TODOリスト表示部分
                Expanded(
                  child: ListView.builder(  // ListView.builder は「繰り返し構造（＝for文的処理）」を内部に持ったウィジェット
                    itemCount: todos.length,          // TODOアイテムの総数を設定（＝itemCount 分だけループ処理を実行する）
                    itemBuilder: (context, index) {   // 各ループ処理の本体（＝indexごとにアイテムを格納）
                      return TodoTile(index: index);  // 取得したアイテムで TodoTileウェジット を表示する
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }
    );
  }
}
