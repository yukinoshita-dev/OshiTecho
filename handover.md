# OshiTecho handover

## 概要
推し活・ファン活動を記録・管理・共有できるWebアプリ。
「母子手帳」モチーフの手帳UIで、イベント・グッズ・活動ログを管理。
ポートフォリオ用。

## 技術スタック
- Rails 8 / Hotwire（Turbo + Stimulus）/ PostgreSQL
- Tailwind CSS v4 / FullCalendar.js / Active Storage
- Deploy: Render（Web + PostgreSQL）

## 現在のステータス
**未着手。** 仕様・タスク一覧のみ作成済み。

## 次にやること（Phase 1 から）
1. Rails 8 プロジェクト作成
   ```bash
   rails new oshi_techo --database=postgresql --css=tailwind --skip-test
   ```
2. Gemfile に RSpec / FactoryBot / Pagy / Redcarpet 追加
3. CSS Custom Properties で4テーマ定義（Classic / Girly / Natural / Cool）
4. Rails 8 Authentication Generator 実行

## テーマ一覧
| テーマ | イメージ |
|--------|---------|
| Classic | 革手帳・クリーム×ゴールドブラウン |
| Girly | ほぼ日手帳・ベビーピンク×ピンク |
| Natural | キャンプ日記・オフホワイト×グリーン |
| Cool | ビジネス手帳・ダーク×インディゴ |

## パス
`F:/business/My/portfolio/OshiTecho`

## メモ
- Spec.md に詳細仕様あり / Tasks.md に全タスクあり（Phase 1〜7）
- デプロイ先: Render（render.yaml で定義予定）
