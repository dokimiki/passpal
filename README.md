# ぱすぱる / PassPal

**ぱすぱる** は、中京大学のポータルサイト **ALBO** と **MaNaBo** を
スマートフォンで快適に扱えるようにする 非公式**ネイティブライク Flutter アプリ** です。
ポータルの主要機能（お知らせ、時間割、課題提出／取消、出席、メールなど）を
シンプルな UI とオフライン耐性を備えた形で再提供し、学修効率を向上させることを目的としています。

ちなみに、「ぱすぱる」はキャンパス、pass(合格)と、パルス(脈拍)、Pal(仲間)を掛け合わせたかっこいい名前です！

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
- **状態管理**: [Riverpod](https://riverpod.dev/)
- **依存注入**: RiverpodベースDI
- **ネットワーク**: Dio + Cookie管理 + Interceptorチェーン
- **ストレージ**:
  - SecureCredential: `flutter_secure_storage`
  - キャッシュ/設定: `shared_preferences`
- **バックエンド**: Firebase Auth + VPS API

## コピペコマンド

```bash
# コード生成・フォーマットを一気に実行 (どうしてもエラーが出るときに実行)
dart fix --apply && dart format . && dart run build_runner clean && flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

# コード解析実行 (1番目に実行)
dart fix --apply && dart format . && flutter analyze

# テスト実行 (2番目に実行)
flutter test test/core/
```

## 初期化コマンド

### 前提ツール 環境構築(flutter)
[インストール | Flutter Doc JP](https://flutter.ctrnost.com/install/)
[(公式ドキュメント) Install | Flutter](https://docs.flutter.dev/get-started/install)

### 前提ツール 環境構築(firebase)
[Flutter アプリに Firebase を追加する](https://firebase.google.com/docs/flutter/setup?hl=ja&platform=android)

```bash
npm install -g firebase-tools

firebase login

dart pub global activate flutterfire_cli
```

### セットアップ
```bash
# プロジェクトのクローン
git clone https://github.com/YOUR_NAME/passpal.git
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
flutter analyze
```

### ビルド
```bash
flutter build apk # Android リリースビルド
flutter build ios # iOS リリースビルド
```

### デバッグ実行
```bash
flutter devices # 接続デバイスの確認
flutter run -d <device_id> # デバイス指定で実行
```

## プロジェクト構成

```
lib/
├── core/               # 共通機能（ネットワーク・認証・エラー管理など）
├── features/           # 機能ごとのディレクトリ（feature-first）
│   ├── assignments/    # 課題管理機能
│   ├── timetable/      # 時間割・授業管理
│   ├── attendance/     # 出席管理
│   ├── news/           # ALBO / MaNaBoお知らせ
│   └── transport/      # バス・電車時刻表
├── main.dart           # アプリ起動エントリ
└── ...
```
