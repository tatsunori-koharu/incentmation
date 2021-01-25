require 'rails_helper'

RSpec.describe "Articles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article_title = Faker::Lorem.characters(number: 10)
    @article_content = Faker::Lorem.sentence
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
      fill_in 'article_title', with: @article_title
      fill_in 'article_content', with: @article_content
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
      # 投稿した内容のトピックスが存在することを確認する
      expect(page.find('.article-image')['src']).to have_content(@article_image)
      # トピックスにカーソルを合わせると詳細ページへに遷移ボタンがあることを確認する
      expect(
        find(".item ").hover
      ).to have_content('この記事へ')
    end
  end
  context 'トピックスに投稿できないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass(path)
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('新規投稿')
    end
  end
end

RSpec.describe 'Article/edit', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end
  context 'Articleが編集できるとき' do
    it 'ログインユーザーは自分が投稿したトピックスを編集できる' do
      # article1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@article1.user)
      # article1に遷移する
      visit article_path(@article1.id)
      # article1に編集ボタンがある事を確認する
      expect(page).to have_link '編集', href: edit_article_path(@article1)
      # 編集ページへ遷移する
      visit edit_article_path(@article1)
      # すでに投稿済みの内容がフォームに入っている事を確認する
      expect(
        find('#article_title').value
      ).to eq @article1.title
      expect(
        find('#article_content').value
      ).to eq @article1.content
      expect(
        find('#article_category_id').value
      ).to eq "#{@article1.category_id}"
      # 投稿内容を編集する
      fill_in 'article_title', with: "#{@article1.title} + 'アイウエオ' "
      fill_in 'article_content', with: "#{@article1.content} + '中央材料室' "
      attach_file "article[images][]", "app/assets/images/gahag-0041371722-1.png"
      # 編集してもArticleモデルのカウントが変わらない事を確認する
      expect do
        click_button "投稿"
      end.to change { Article.count }.by(0)
      # 詳細ページに遷移した事を確認する
      # expect(current_path).to eq article_path(@aritcle1.id)
      # 一覧ページに遷移する
      visit articles_path
      # 投稿した内容のトピックスが存在することを確認する
      expect(page.find('.article-image')['src']).to have_content(@article_image)
    end
  end
  context 'articleが編集できないとき' do
    it 'ログインユーザーは自分以外が投稿したトピックスの編集画面には遷移できない' do
      # article1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@article1.user)
      # article2に遷移する
      visit article_path(@article2.id)
      # 編集ボタンがない事を確認する
      expect(page).to have_no_link '編集', href: edit_article_path(@article2)
    end
    it 'ログインしていないとarticleの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # トピックス一覧への遷移ボタンがない事を確認する
      expect(page).to have_no_link '最新トピックス', href: articles_path
    end
  end
end
RSpec.describe 'Article/edit', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end
  context 'articleを削除できる' do
    it 'ログインしたユーザーは自らが投稿したトピックスを削除できる' do
      # article1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@article1.user)
      # article1に遷移する
      visit article_path(@article1.id)
      # 編集画面に遷移する
      visit edit_article_path(@article1)
      # 削除ボタンがある事を確認する
      expect(page).to have_link '削除', href: article_path(@article1)
      # 削除するとarticleモデルの数が1つ減る事を確認する
      expect{
        find_link('削除', href: article_path(@article1)).click
        expect(page.driver.browser.switch_to.alert.text).to eq "よろしいですか？"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'トピックスを削除しました'
      }. to change { Article.count }.by(-1)
      # トピックス一覧画面に遷移した事を確認する
      expect(current_path).to eq articles_path
      # article1がない事を確認する
      expect(page.find('.article-image')['src']).to have_no_content(@article_image)
    end
  end
  context 'article1を削除できない' do
    it 'ログインしたユーザーは自分の投稿以外は削除できない' do
      basic_pass(path)
      sign_in(@article1.user)
      # article2に遷移する
      visit article_path(@article2.id)
      # 削除ボタンがない事を確認する
      expect(page).to have_no_link '削除', href: article_path(@article2)
    end
    it 'ログインしていないと削除できない' do
      # トップページにいる
      visit root_path
      # トピックス一覧への遷移ボタンがない事を確認する
      expect(page).to have_no_link '最新トピックス', href: articles_path
    end
  end
end
