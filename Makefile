.PHONY: preview new open

# プレビュー起動
preview:
	npx zenn preview
	open http://localhost:8000

# 新しい記事を作成 (例: make new slug=my-first-post)
new:
	npx zenn new:article --slug $(slug)
