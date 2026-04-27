# 📔 推し手帳

声優・アイドル・アーティストなど「推し」の活動を記録・管理・共有できるWebアプリです。
母子手帳モチーフの手帳UIで、イベント・グッズ・活動ログをまとめて管理できます。

## スクリーンショット

| トップページ | ダッシュボード | カレンダー |
|:-:|:-:|:-:|
| （LP・4テーマデモ） | （統計・近日イベント） | （FF共有カレンダー） |

## 主な機能

- **推し管理** — 推しをカード形式で登録。カラー・SNSリンク・記念日管理
- **イベント管理** — ライブ・握手会・オンラインイベントなどを記録。チケット代・交通手段・座席も
- **活動ログ** — 現場の感想をMarkdownで記録。セトリ・星評価・費用・画像を添付
- **グッズ管理** — 購入グッズを月別・カテゴリ別に管理。出費を自動集計
- **ダッシュボード** — 今月の出費・参加イベント数・推しごとの統計を一覧表示
- **カレンダー** — 自分のイベント＋相互フォロー（FF）のイベントをFullCalendarで表示
- **フォロー/FF機能** — ユーザー間でフォロー。相互フォロー時にカレンダーを共有
- **通知機能** — フォロー・イベント参加表明・前日リマインダー通知
- **iCal連携** — イベントを.icsでエクスポート、Googleカレンダーに追加
- **4テーマ** — Classic / Girly / Natural / Cool を切り替え可能

## 技術スタック

| カテゴリ | 技術 |
|---------|------|
| バックエンド | Ruby 3.3 / Rails 8.1 |
| フロントエンド | Hotwire (Turbo + Stimulus) / Tailwind CSS v4 |
| リアルタイム | ActionCable (Solid Cable) |
| バックグラウンドジョブ | Solid Queue |
| データベース | PostgreSQL |
| ストレージ | Active Storage |
| テスト | RSpec / FactoryBot / shoulda-matchers |
| デプロイ | Render.com |

## ローカル環境構築

### 必要要件

- Ruby 3.3.x
- PostgreSQL 14+
- Node.js 18+ (Tailwind CSS用)

### セットアップ

```bash
git clone <repo-url>
cd OshiTecho

bundle install
rails db:create db:migrate

bin/dev
```

アプリケーションは http://localhost:3000 で起動します。

### テスト実行

```bash
RAILS_ENV=test rails db:migrate
bundle exec rspec
```

## デプロイ（Render.com）

1. GitHubにリポジトリを作成してpush
2. [Render.com](https://render.com) でNew → Blueprint
3. GitHubリポジトリを選択（render.yaml が自動検出されます）
4. 環境変数を設定:
   - `RAILS_MASTER_KEY`: `config/master.key` の内容
5. デプロイ実行

## ライセンス

MIT
