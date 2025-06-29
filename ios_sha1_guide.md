# iOS用SHA-1フィンガープリント確認ガイド

## 1. 開発用証明書のSHA-1確認方法

### Xcodeから確認する方法（推奨）

1. **Xcodeでプロジェクトを開く**
   ```bash
   cd /path/to/your/flutter/project
   open ios/Runner.xcworkspace
   ```

2. **Signing & Capabilities設定を確認**
   - Xcodeで `Runner` プロジェクトを選択
   - `Signing & Capabilities` タブを開く
   - Team と Bundle Identifier を確認

3. **証明書情報を確認**
   - Xcode → Preferences → Accounts
   - Apple ID を選択
   - "Manage Certificates..." をクリック
   - 使用している証明書をダブルクリック

### キーチェーンアクセスから確認する方法

1. **キーチェーンアクセスを開く**
   ```bash
   open "/Applications/Utilities/Keychain Access.app"
   ```

2. **開発者証明書を探す**
   - "login" キーチェーンを選択
   - "Certificates" カテゴリを選択
   - "Apple Development" または "iPhone Developer" で始まる証明書を探す

3. **SHA-1を確認**
   - 証明書をダブルクリック
   - "Details" タブを選択
   - "SHA-1 fingerprint" の値をコピー

### ターミナルから確認する方法

#### 方法1: セキュリティコマンドを使用

```bash
# キーチェーン内のすべての証明書を表示
security find-certificate -c "Apple Development" -p | openssl x509 -fingerprint -sha1 -noout

# 特定のチームIDで検索
security find-certificate -c "Apple Development: your@email.com" -p | openssl x509 -fingerprint -sha1 -noout
```

#### 方法2: 証明書ファイルから直接確認

```bash
# .p12ファイルがある場合
openssl pkcs12 -in certificate.p12 -nokeys | openssl x509 -fingerprint -sha1 -noout

# .cerファイルがある場合
openssl x509 -in certificate.cer -fingerprint -sha1 -noout
```

## 2. Flutterプロジェクトから確認

### Bundle Identifierの確認

```bash
# iOS Bundle Identifierを確認
cd your_flutter_project/ios
grep -r "PRODUCT_BUNDLE_IDENTIFIER" Runner.xcodeproj/project.pbxproj
```

### Provisioning Profileの確認

```bash
# Provisioning Profileから証明書情報を確認
security cms -D -i ~/Library/MobileDevice/Provisioning\ Profiles/*.mobileprovision
```

## 3. Firebase Consoleに追加する情報

### 必要な情報
- **Bundle ID**: `Runner.xcodeproj` の `PRODUCT_BUNDLE_IDENTIFIER`
- **App Store ID**: （リリース後に取得）
- **Team ID**: Apple Developer Programのチーム識別子

### Firebase Consoleでの設定手順

1. [Firebase Console](https://console.firebase.google.com/) にアクセス
2. プロジェクトを選択
3. プロジェクト設定（歯車アイコン）をクリック
4. "アプリを追加" → "iOS" を選択
5. Bundle ID を入力
6. `GoogleService-Info.plist` をダウンロード
7. Xcodeの `ios/Runner/` フォルダに追加

## 4. 自動確認スクリプト

以下のスクリプトで現在のiOS設定を確認できます：

```bash
#!/bin/bash
echo "=== iOS Certificate Information ==="

# Bundle Identifier確認
echo "Bundle Identifier:"
grep -A1 "PRODUCT_BUNDLE_IDENTIFIER" ios/Runner.xcodeproj/project.pbxproj | grep -v "PRODUCT_BUNDLE_IDENTIFIER" | sed 's/.*= \(.*\);/\1/' | head -1

# 開発証明書のSHA-1確認
echo -e "\nDevelopment Certificate SHA-1:"
security find-certificate -c "Apple Development" -p 2>/dev/null | openssl x509 -fingerprint -sha1 -noout 2>/dev/null || echo "No development certificate found"

# チームID確認
echo -e "\nTeam ID:"
grep -A1 "DEVELOPMENT_TEAM" ios/Runner.xcodeproj/project.pbxproj | grep -v "DEVELOPMENT_TEAM" | sed 's/.*= \(.*\);/\1/' | head -1

echo -e "\n=== Next Steps ==="
echo "1. Add the Bundle ID to Firebase Console"
echo "2. Download GoogleService-Info.plist"
echo "3. Add the plist file to ios/Runner/ in Xcode"
echo "4. Ensure the certificate SHA-1 matches in Firebase (for APNs if needed)"
```

## 5. トラブルシューティング

### よくある問題

1. **証明書が見つからない**
   - Xcode で "Automatically manage signing" を有効にする
   - Apple Developer Program への登録を確認

2. **Bundle ID の不一致**
   - Firebase Console と Xcode の Bundle ID が一致していることを確認

3. **GoogleService-Info.plist が見つからない**
   - ファイルが `ios/Runner/` フォルダに正しく配置されているか確認
   - Xcode のプロジェクトナビゲーターで Runner フォルダ内に表示されているか確認

### iOS Simulator での注意点

- iOS Simulator では実際の証明書は使用されません
- 実機テストまたはリリースビルドでのみ証明書が重要になります
- Google Sign-In などの認証機能は実機でのテストが推奨されます

## 6. セキュリティのベストプラクティス

- 証明書の秘密鍵は安全に管理する
- 本番用とテスト用の証明書を分ける
- 定期的に証明書の有効期限を確認する
- Team メンバー間での証明書共有方法を統一する
