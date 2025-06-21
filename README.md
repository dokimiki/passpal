# ぱすぱる (Passpal) – 中京大学ポータル快適化アプリ

---

## 📚 目的

中京大学のポータルサイト (MaNaBo / ALBO) は PC 前提の UI が多く、スマートフォンでは操作が煩雑です。**ぱすぱる** はポータルの情報を取得し、モバイル UX に最適化して提供する Flutter 製アプリです。

* **情報取得・通知の自動化** — 新規課題やお知らせをプッシュ通知。
* **今日の授業ウィジェット** — ホーム画面から即確認。
* **学内バス時刻表** — キャンパス差分に対応。

---

## ✨ 主な機能 (MVP)

| カテゴリ     | 機能                                                |
| ------------ | --------------------------------------------------- |
| 課題         | 課題一覧取得・追加/削除通知 / 期限 1 日前リマインド |
| 授業         | 時間割取得・表示 / 出席状況チェック (30 秒間隔)     |
| 認証         | 自動ログイン (Shibboleth IdP) / セッション自動更新  |
| 通知         | FCM + Local Notification / 拒否時バナー再許可       |
| ウィジェット | 今日の授業タイムライン (iOS/Android)                |
| バス         | スクールバス時刻表 (キャンパスごと)                 |

### 🚧 将来追加予定

* 学内イベント・部活情報
* MaNaBo メール送受信
* オフライン教材閲覧
* ダークモード など

---

## 🛠️ 技術スタック

| レイヤ          | 主な技術 / ライブラリ                                                    |
| --------------- | ------------------------------------------------------------------------ |
| UI              | **Flutter** 3.x                                                          |
| 状態管理        | **Riverpod** + flutter\_hooks                                            |
| データ層        | dio / html (スクレイピング) / json\_serializable                         |
| ローカル DB     | Isar / Drift (選択可)                                                    |
| Backend & Infra | **Firebase** (Auth, Firestore, Remote Config, FCM, Crashlytics, Storage) |
| CI/CD           | GitHub Actions / Codemagic (Build & Test)                                |

---

## 🏛️ アーキテクチャ

```
┌────────────────────────┐
│        Presentation (UI)│  ← Riverpod Provider       
├────────────────────────┤
│      Domain (UseCase)   │  ← Clean Architecture      
├────────────────────────┤
│     Data (Repository)   │  ← DTO / Parser / Wrapper  
└────────────────────────┘
```

* **Feature‑first x Layer マトリクス構成**。UI と “それ以外” を最上位で分割し、各機能ごとに data / domain / presentation ディレクトリを配置。
* **依存性逆転**: Domain → Data の依存を禁止し、Provider で DI。
* スクレイピングパーサは **バージョン付き**(`v1_courseListParser` 等) でテスト駆動開発 (TDD)。

### データ取得フロー

1. **DataFetch** (dio wrapper) – HTTP(HTML/JSON) 取得
2. **DataParse** – DTO へ変換
3. **Interface** – Entity 生成 (Repository)
4. **Domain** – UseCase が Repository を呼び出し

---

## 📁 ディレクトリ構成 (抜粋)

```
lib/
 ├── core/                # 共通ユーティリティ・DI ルート
 ├── features/
 │    ├── assignments/
 │    │     ├── data/          # DataFetch / DataParse / DTO
 │    │     ├── domain/        # Entity / Repository Interface / UseCase
 │    │     └── presentation/  # Screen / Widget / Provider
 │    ├── timetable/
 │    └── ...
 test/
 docs/adr/                # Architecture Decision Record (MADR)
```

---

## 🚀 セットアップ

### 1. 前提条件

* **Flutter 3.32.x** (`flutter --version`)
* Xcode / Android Studio
* Firebase CLI

### 2. クローン & 依存解決

```bash
git clone https://github.com/dokimiki/passpal.git
cd passpal
flutter pub get
```

### 3. Firebase 設定

1. Firebase Console で iOS & Android アプリを追加。
2. `google-services.json` / `GoogleService-Info.plist` を `./android` / `./ios` 配下に配置。
3. `flutterfire configure` で自動生成。

### 4. .env 生成

```bash
cp .env.example .env
```

### 5. 実行

```bash
flutter run
```

### 6. テスト

```bash
flutter test
```

---

## 🧪 開発フロー

1. **TDD**: テスト → 実装 → リファクタリング。
2. Pull Request には `docs/adr/` の追加または更新を含めること。
3. CI で `flutter analyze` / `flutter test` を通過必須。

---

## 🔒 セキュリティ

* **TLS 証明書ピンニング** (`http_certificate_pinning`) – leaf + backup pin。
* Cookie & HTML キャッシュは `flutter_secure_storage` + AES‑256 暗号化。
* 端末ログアウト時にセキュア情報を完全削除。

---

## 🤝 Contributing

コントリビューションは大歓迎です！

1. Issue を立てて議論
2. `feat/<topic>` ブランチを切る
3. テスト & ADR を追加
4. Pull Request

詳細は [`CONTRIBUTING.md`](CONTRIBUTING.md) を参照してください。

---

> © 2025 Passpal Project. All rights reserved.
