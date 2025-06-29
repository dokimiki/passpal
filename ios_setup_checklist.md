# iOS Firebase設定チェックリスト

## 現在の状況
- Bundle ID: `app.chukyo-passpal.passpal`
- GoogleService-Info.plist: **不足** ❌
- Firebase Console iOS設定: **未完了** ❌

## 必要な作業

### 1. Firebase Consoleでの設定（Macが無くてもできる）
1. [Firebase Console](https://console.firebase.google.com/) にアクセス
2. プロジェクト `passpal-c55ac` を選択
3. プロジェクト設定（⚙️）→ "アプリを追加" → Apple アイコン
4. 以下の情報を入力：
   - **Bundle ID**: `app.chukyo-passpal.passpal`
   - **App nickname**: PassPal iOS (任意)
   - **App Store ID**: （後で設定可能）

### 2. GoogleService-Info.plist のダウンロード
1. Firebase設定完了後、`GoogleService-Info.plist` をダウンロード
2. ファイルを `ios/Runner/` フォルダに配置
3. Xcodeでプロジェクトに追加（Macでの作業が必要）

### 3. Macでの追加作業（後日実施）
```bash
# プロジェクトを開く
cd /path/to/passpal
open ios/Runner.xcworkspace

# 証明書のSHA-1確認
security find-certificate -c "Apple Development" -p | openssl x509 -fingerprint -sha1 -noout
```

## Google Sign-In 動作に必要な最小設定

### Android（既に完了 ✅）
- SHA-1 追加済み: `C2:A3:1F:09:28:A7:46:A0:B9:0E:92:68:A8:C2:5D:15:48:42:CF:AB`
- google-services.json 配置済み

### iOS（要対応 ❌）
- [ ] Firebase ConsoleでiOSアプリ追加
- [ ] GoogleService-Info.plist ダウンロード
- [ ] Xcodeプロジェクトに plist ファイル追加
- [ ] 開発証明書のSHA-1確認（必要に応じて）

## 優先度

**HIGH**: Firebase Console iOS設定（Macなしでも可能）
**MEDIUM**: GoogleService-Info.plist 配置（Macが必要）
**LOW**: 証明書SHA-1確認（実機テスト時に必要）

## 注意点
- iOS Simulatorでは証明書は不要
- Google Sign-Inの実機テストには適切な証明書設定が必要
- App Storeリリース時は別途Production証明書が必要
