# 📔 推し手帳

声優・アイドル・アーティストなど「推し」の活動を記録・管理・共有できるWebアプリです。  
母子手帳モチーフの手帳UIで、イベント・グッズ・活動ログをまとめて管理できます。

![Ruby](https://img.shields.io/badge/Ruby-3.3-CC342D?logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.0-CC0000?logo=rubyonrails)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-336791?logo=postgresql)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-v4-06B6D4?logo=tailwindcss)
![RSpec](https://img.shields.io/badge/RSpec-passing-success)

## 主な機能

| 機能 | 説明 |
|------|------|
| **推し管理** | カード形式で登録。カラー・SNSリンク・記念日管理 |
| **イベント管理** | ライブ・握手会・オンラインイベントなどを記録。チケット代・交通手段・座席も |
| **活動ログ** | 現場の感想をMarkdownで記録。セトリ・星評価・費用・画像を添付 |
| **グッズ管理** | 購入グッズを月別・カテゴリ別に管理。出費を自動集計 |
| **CSV出力** | グッズ・イベント一覧をCSVでダウンロード（フィルター条件を維持） |
| **ダッシュボード** | 今月の出費・参加イベント数・推しごとの統計を一覧表示 |
| **年間レポート** | 月別イベント数・費用グラフ・推し別ランキングを年次で確認 |
| **カレンダー** | 自分のイベント＋相互フォロー（FF）のイベントをFullCalendarで表示 |
| **フォロー/FF機能** | ユーザー間でフォロー。相互フォロー時にカレンダーを共有 |
| **通知機能** | フォロー・イベント参加表明・前日リマインダー通知（Solid Queue） |
| **iCal連携** | イベントを.icsでエクスポート、Googleカレンダーに追加 |
| **4テーマ** | Classic / Girly / Natural / Cool を切り替え可能 |

## 技術スタック

| カテゴリ | 技術 |
|---------|------|
| バックエンド | Ruby 3.3 / Rails 8.0 |
| フロントエンド | Hotwire (Turbo + Stimulus) / Tailwind CSS v4 |
| リアルタイム | ActionCable (Solid Cable) |
| バックグラウンドジョブ | Solid Queue |
| データベース | PostgreSQL |
| ストレージ | Active Storage |
| カレンダーUI | FullCalendar.js (CDN) |
| テスト | RSpec / FactoryBot / shoulda-matchers |
| CI | GitHub Actions |
| デプロイ | Render.com |

## アーキテクチャ上の特徴

- **Turbo Streams** — フォロー/アンフォロー・イベント参加表明をページ遷移なしで即時反映
- **ActionCable** — イベント参加者数をリアルタイム更新（EventParticipationsChannel）
- **Solid Queue** — 前日リマインダー通知ジョブを毎朝8時にスケジュール実行
- **テーマシステム** — CSS Custom Propertiesで4テーマを定義。ログイン中はDB保存、未ログインはlocalStorage
- **FF限定共有** — 相互フォロー（FF）の関係があるユーザーのみカレンダーを共有

## ローカル環境構築

### 必要要件

- Ruby 3.3.x
- PostgreSQL 14+
- Node.js 18+（Tailwind CSS v4用）

### セットアップ

```bash
git clone <repo-url>
cd OshiTecho

bundle install
bin/rails db:create db:migrate

bin/dev
```

アプリケーションは http://localhost:3000 で起動します。

### テスト実行

```bash
RAILS_ENV=test bin/rails db:migrate
bundle exec rspec
```

## デプロイ（Render.com）

1. GitHubにリポジトリを作成してpush
2. [Render.com](https://render.com) でNew → Blueprint
3. GitHubリポジトリを選択（`render.yaml` が自動検出されます）
4. 環境変数を設定:
   - `RAILS_MASTER_KEY`: `config/master.key` の内容
5. デプロイ実行

## ライセンス

MIT
