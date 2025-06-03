import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';
import 'screens/todo_list_screen.dart';

/// TODOアプリケーションのルートウィジェット
/// 
/// アプリケーション全体の設定
/// ChangeNotifierProvider を使用して TodoProvider を提供し、
/// アプリケーション全体でTODOデータの状態管理を可能にする。
/// 
class MyTodo extends StatelessWidget {  // 状態を持たないウェジット
  /// MyTodoのコンストラクタ
  /// [key]はウィジェットの識別に使用される。
  const MyTodo({super.key});

  /// ウィジェットツリーを構築する
  /// 
  /// [context]はビルドコンテキスト
  /// Returns: 構築されたウィジェットツリー
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(    // Flutter の Provider パッケージの一部として、状態管理用のオブジェクトをウィジェットツリーに供給する
      create: (_) => TodoProvider(),  // Providerが使う状態オブジェクトを設定
      child: MaterialApp(                   // GoogleのMaterial Designに準拠したUIや動作の土台を提供するウィジェット
        debugShowCheckedModeBanner: false,  // デバッグバナーを非表示に設定
        home: const TodoListScreen(),       // ホーム画面の設定
      ),
    );
  }
}