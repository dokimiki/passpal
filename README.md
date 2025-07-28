# ぱすぱる / PassPal

**ぱすぱる** は、中京大学のポータルサイト **ALBO** と **MaNaBo** を
スマートフォンで快適に扱えるようにする 非公式**ネイティブライク Flutter アプリ** です。
ポータルの主要機能（お知らせ、時間割、課題提出／取消、出席、メールなど）を
シンプルな UI とオフライン耐性を備えた形で再提供し、学修効率を向上させることを目的としています。

ちなみに、「ぱすぱる」はpass(合格)と、Pal(仲間)を掛け合わせたかっこいい名前です！

## 特徴

- MaNaBo・ALBO・Cubics の統合ラッパー
- 課題追加/削除通知・期限前リマインダー
- 出席確認と通知
- 通学バス/電車の時刻表確認機能
- 時間割表示・今日の授業ウィジェット
- 認証状態の自動更新・503メンテナンス検知
- 完全日本語対応・学内SSOとFirebase認証の併用

## 技術構成

- **フレームワーク**: [Flutter](https://flutter.dev/)
- **状態管理**: [Riverpod generator + flutter hooks](https://riverpod.dev/)
- **ネットワーク**: Dio + Cookie管理 + Interceptorチェーン
- **ストレージ**:
  - SecureCredential: `flutter_secure_storage`
  - 設定: `shared_preferences`
- **バックエンド**: Firebase Auth + Pal API
- **データベース**: [drift](https://drift.simonbinder.eu/)

## コピペコマンド

```bash
# コード生成・フォーマットを一気に実行 (どうしてもエラーが出るときに実行)
dart fix --apply && dart format . && dart run build_runner clean && flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

# コード解析実行 (1番目に実行)
dart fix --apply && dart format . && flutter analyze && dart run custom_lint

# テスト実行 (2番目に実行)
flutter test test/core/
```

## 初期化コマンド

### 前提ツール 環境構築(flutter)
[インストール | Flutter Doc JP](https://flutter.ctrnost.com/install/)
[(公式ドキュメント) Install | Flutter](https://docs.flutter.dev/get-started/install)

### セットアップ
```bash
# プロジェクトのクローン
git clone https://github.com/chukyo-passpal/passpal.git
cd passpal

# flutterの初期化
flutter pub get

# Firebaseの初期化
flutterfire configure
```

## コマンドスニペット

### コード生成
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 生成したコードをクリーンアップ
```bash
flutter clean
```

### テスト実行
```bash
flutter test
```

### コードフォーマット
```bash
dart fix --apply
dart format .
```

### コード解析
```bash
flutter analyze && dart run custom_lint
```

### ビルド
```bash
flutter build apk # Android リリースビルド
flutter build ios # iOS リリースビルド
```

### アイコン更新
```bash
flutter pub run flutter_launcher_icons:main
```

### デバッグ実行
```bash
flutter devices # 接続デバイスの確認
flutter run -d <device_id> # デバイス指定で実行
```
