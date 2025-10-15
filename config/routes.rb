Rails.application.routes.draw do
  # ダッシュボード（ホーム画面）をアプリのルートに設定
  root 'dashboards#show'
end
