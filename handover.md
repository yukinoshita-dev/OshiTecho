# OshiTecho 引き継ぎ書

最終更新: 2026-04-27

## プロジェクト概要
推し活管理システム（ポートフォリオ）
- Rails 8 / Hotwire / Tailwind CSS v4 / PostgreSQL
- パス: F:/business/My/portfolio/OshiTecho

## 完了済みフェーズ（全タスク完了）

### Phase 1: 基盤構築 ✅
- Rails 8認証、テーマシステム（4テーマ）、LP、ユーザープロフィール

### Phase 2: 推し・イベント機能 ✅
- 推し管理CRUD、イベント管理CRUD、イベント参加表明（Turbo Stream）

### Phase 3: フォロー・カレンダー機能 ✅
- フォロー/アンフォロー（Turbo Stream）、FF限定カレンダー（FullCalendar CDN）

### Phase 4: グッズ・活動ログ・ダッシュボード ✅
- グッズ管理、活動ログ（マークダウン・星評価・複数画像）、ダッシュボード統計

### Phase 5: 通知・リアルタイム機能 ✅
- 通知モデル（ポリモーフィック）、フォロー/参加表明時の通知作成
- NotificationsController（index/mark_all_read）、通知バッジ（Turbo Frame）
- EventReminderJob（Solid Queue・毎朝8時に翌日分）
- ActionCable EventParticipationsChannel（リアルタイム参加者数）

### Phase 6: 品質・デプロイ設定 ✅
- RSpec 48例全合格（shoulda-matchers）
  - モデルスペック: User, Event, Notification
  - リクエストスペック: Follows, EventParticipations, Notifications
- エラーページ（404/422/500）手帳風デザイン
- GitHub Actions CI（lint/security/RSpec）
- render.yaml + bin/render-build.sh（Render.com用）

### Phase 7: iCal/Googleカレンダー連携 ✅
- GET /events/:id/export_ical で.icsダウンロード（icalendar gem）
- イベント詳細にiCalボタン・Googleカレンダーボタン

## 残タスク
- Renderへの初回デプロイ（GitHub連携・環境変数設定・本番マイグレーション）
- README作成
- 購読URL（webcal://）発行（バックログ）

## 重要な技術メモ

### RUBYOPT 問題（Windows + Program Files）
`bundle exec` がRUBYOPTに空白を含むパスを設定しRuby解析エラーになる。
回避策: `ruby -rbundler/setup -e "require 'rspec/core'; ..."`

### Session has_secure_token
Session モデルに `has_secure_token` が必要（ないとtoken NOT NULL制約違反）。追加済み。

### Event transport enum prefix
`enum :transport, {none: 0, ...}, prefix: :transport` → `transport_none?` で参照。

### FullCalendar
importmap非対応（directory-style imports）。CDN Global Bundleで読み込み。

## git log（最近）
```
22f2bfc docs: Tasks.md完了状態を最新化
9263316 feat: Phase7 iCal/Googleカレンダー連携
a1a28ae feat: Phase6-2/6-3 エラーページ・CI・Renderデプロイ設定
d93d553 feat: Phase6 RSpec+FactoryBotテスト実装（48例全合格）
474f112 feat: Phase5-3 ActionCableでリアルタイム参加者数更新
1de02c3 feat: Phase5-2 EventReminderJob + Solid Queueスケジューラ設定
5a1f3cc feat: Phase5-1 通知機能実装
```
