# OshiTecho - CLAUDE.md

## プロジェクト概要
推し活・ファン活動管理Webシステム「OshiTecho（推し手帳）」。
母子手帳をモチーフにした、推し活記録・イベント共有・仲間とのカレンダー共有ができるポートフォリオ用Webアプリ。

## 技術スタック
| 項目 | バージョン・技術 |
|------|----------------|
| Ruby | 3.3.x |
| Rails | 8.0.x |
| DB | PostgreSQL |
| 認証 | Rails 8 Authentication Generator |
| フロント | Hotwire（Turbo + Stimulus） |
| CSS | Tailwind CSS v4（@tailwindcss/rails） |
| バックグラウンドジョブ | Solid Queue |
| リアルタイム | ActionCable + Solid Cable |
| ファイルアップロード | Active Storage |
| ページネーション | Pagy |
| マークダウン | Redcarpet |
| テスト | RSpec + FactoryBot |
| CI | GitHub Actions |
| デプロイ | Render |

## ディレクトリ構成（Rails標準 + 追加）
```
app/
  controllers/
  models/
  views/
  javascript/controllers/   # Stimulusコントローラー
  jobs/                     # Solid Queueジョブ
  channels/                 # ActionCableチャンネル
  components/               # ViewComponent（将来的に）
spec/                       # RSpec
```

## コーディング規約
- Rubyスタイル：StandardRB（rubocop-rails-omakase）
- N+1禁止：bullet gemで検出、必ずincludes/eager_loadを使う
- fat model / skinny controller を基本方針とする
- サービスオブジェクトは複雑なビジネスロジックのみ切り出す（過剰な抽象化禁止）
- ビューはTurbo Framesで部分更新を積極活用する
- コメントは「なぜ」だけ書く。「何をしているか」は書かない

## 環境変数（.envで管理・Gitに含めない）
```
DATABASE_URL=
RAILS_MASTER_KEY=
```

## よく使うコマンド
```bash
# 開発サーバー起動
bin/dev

# マイグレーション
bin/rails db:migrate

# テスト実行
bundle exec rspec

# ルーティング確認
bin/rails routes

# コンソール
bin/rails console
```

## デザイン方針
- **モバイルファースト**: Tailwind はベーススタイルを SP 基準で書き、`md:` / `lg:` で PC 拡張
- **LP構成**: トップページ（/）は未ログイン向けランディングページ。ログイン後は `/dashboard` へリダイレクト
- **テーマUIの位置**: ヘッダーに 🎨 アイコンを常時表示。クリックでドロップダウン表示

## 重要な設計方針
- **公開/非公開**: events, activity_logs に `visibility` カラム（private/public）を持たせる
- **フォロー機能**: follows テーブルで自己結合。FF（相互フォロー）の判定はモデルに実装
- **グッズは完全プライベート**: goods に visibility カラムは不要
- **イベント参加表明**: 公開イベントは誰でも参加表明可能
- **FF限定カレンダー**: フォロー関係があるユーザー同士でイベントカレンダーを共有
- **テーマシステム**: CSS Custom Propertiesで4テーマ定義（classic/girly/natural/cool）。`<html data-theme="...">` にクラス付与して切り替え。ログインユーザーはusers.themeに保存、未ログインはlocalStorage。ApplicationControllerのbefore_actionでDBから読み込み。
- **手帳デザイン**: 罫線・インデックスシール・スタンプ風UIなど手帳らしさをコンポーネント化して全テーマで共有

## やってはいけないこと
- APIキー・シークレットのハードコード禁止
- git push は明示的な指示があるまで行わない
- マイグレーションファイルの編集禁止（新規マイグレーションを作成すること）
