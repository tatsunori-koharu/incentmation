require 'rails_helper'

RSpec.describe "Articles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
  end
  context 'トピックスに投稿できるとき' do
    it 'ログインユーザーは新規投稿できる' do
      # Basic認証をする
      basic_pass(path)
      visit root_path
      # ログインする
      sign_in(@user)
      # トピックス一覧へのリンクがあることを確認する
      expect(page).to have_content('最新トピックス')
      # トピックス一覧へ移動する
      visit articles_path
      # 投稿ページへのリンクがあることを確認する
      expect(page).to have_content('新規投稿')
      # 投稿ページへ移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'article_title', with: @article.title
      fill_in 'article_content', with: @article.content
      find("#article_category_id").find("option[value='2']").select_option
      # find("#example").find('input[type="file"]').click
      attach_file "article[images][]", "app/assets/images/gahag-0041371722-1.png"
      # find('input[type="file"]').click
      attach_file "article[move]", "app/assets/images/PXL_20210124_062824863.mp4"
      # 送信するとArticleモデルのカウントが１上がることを確認する
      expect do
        click_button "投稿"
      end.to change(Article, :count).by(1)
      # トピックス一覧ページに遷移することを確認する
      expect(current_path).to eq articles_path 
      # トピックスにカーソルを合わせると詳細ページへに遷移ボタンがあることを確認する
      expect(
        find("#a_item-img_1").hover
      ).to have_content('この記事へ')
      # トピックス詳細ページへ移動する
      visit article_path(@article)
      # 投稿した内容のトピックスが存在することを確認する
      expect(page.find('img')['src']).to have_content('app/assets/images/gahag-0041371722-1.png')
      # 投稿した画像と動画が存在することを確認する
      expect(page).to have_selector "video[style='background-image: url(#{@article_move});']"
    end
  end
end
