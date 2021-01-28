require 'rails_helper'

RSpec.describe "Promotions", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @promotion_name = Faker::Lorem.characters(number: 10)
    @promotion_content = Faker::Lorem.sentence
  end
  context '商品に投稿できるとき' do
    it 'ログインユーザーは新規投稿できる' do
      # Basic認証をする
      basic_pass(path)
      visit root_path
      # ログインする
      sign_in(@user)
      # 商品一覧へのリンクがあることを確認する
      expect(page).to have_content('新商品')
      # 商品一覧へ移動する
      visit promotions_path
      # 投稿ページへのリンクがあることを確認する
      expect(page).to have_content('新商品投稿')
      # 投稿ページへ移動する
      visit new_promotion_path
      # フォームに情報を入力する
      fill_in 'promotion_name', with: @promotion_name
      fill_in 'promotion_content', with: @promotion_content
      find("#promotion_category_id").find("option[value='2']").select_option
      attach_file "promotion[images][]", "app/assets/images/gahag-0041371722-1.png"
      attach_file "promotion[move]", "app/assets/images/PXL_20210124_062824863.mp4"
      # 送信するとpromotionモデルのカウントが１上がることを確認する
      expect do
        click_button "投稿"
      end.to change(Promotion, :count).by(1)
      # 商品一覧ページに遷移することを確認する
      expect(current_path).to eq promotions_path
      # 投稿した内容の商品が存在することを確認する
      expect(page.find('.promotion-image')['src']).to have_content(@promotion_image)
      expect(
        find(".item ").hover
      ).to have_content("#{@promotion_name}")
      expect(
        find(".item ").hover
      ).to have_content("#{@promotion_content}")
      # 商品にカーソルを合わせると詳細ページへに遷移ボタンがあることを確認する
      expect(
        find(".item ").hover
      ).to have_content('この記事へ')
      
    end
  end
  context '商品に投稿できないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass(path)
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('新規投稿')
    end
  end
end

RSpec.describe 'promotion/edit', type: :system do
  before do
    @promotion1 = FactoryBot.create(:promotion)
    @promotion2 = FactoryBot.create(:promotion)
  end
  context 'promotionが編集できるとき' do
    it 'ログインユーザーは自分が投稿した商品を編集できる' do
      # promotion1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@promotion1.user)
      # promotion1に遷移する
      visit promotion_path(@promotion1.id)
      # promotion1に編集ボタンがある事を確認する
      expect(page).to have_link '編集', href: edit_promotion_path(@promotion1)
      # 編集ページへ遷移する
      visit edit_promotion_path(@promotion1)
      # すでに投稿済みの内容がフォームに入っている事を確認する
      expect(
        find('#promotion_name').value
      ).to eq @promotion1.name
      expect(
        find('#promotion_content').value
      ).to eq @promotion1.content
      expect(
        find('#promotion_category_id').value
      ).to eq "#{@promotion1.category_id}"
      # 投稿内容を編集する
      fill_in 'promotion_name', with: "#{@promotion1.name} + 'アイウエオ' "
      fill_in 'promotion_content', with: "#{@promotion1.content} + '中央材料室' "
      attach_file "promotion[images][]", "app/assets/images/gahag-0041371722-1.png"
      attach_file "promotion[move]", "app/assets/images/PXL_20210124_062824863.mp4"
      # 編集してもpromotionモデルのカウントが変わらない事を確認する
      expect do
        click_button "投稿"
      end.to change { Promotion.count }.by(0)
      # 一覧ページに遷移する
      visit promotions_path
      # 投稿した内容の商品が存在することを確認する
      expect(page.find('.promotion-image')['src']).to have_content(@promotion_image)
      expect(
        all(".item")[0].hover
      ).to have_content(@promotion_name)
      expect(
        all(".item")[0].hover
      ).to have_content(@promotion_content)
      # 詳細ページに遷移する
      visit promotion_path(@promotion1.id)
      # 詳細ページに投稿が反映されている事を確認する
      expect(page.find('.site-image ')['src']).to have_content(@promotion_image)
      expect(page).to have_content("#{@promotion_name}")
      expect(page).to have_content("#{@promotion_content}")
      expect(page).to have_content(@promotion_category)
      expect(page.find('.move')['src']).to have_content(@promotion_move)
    end
  end
  context 'promotionが編集できないとき' do
    it 'ログインユーザーは自分以外が投稿した商品の編集画面には遷移できない' do
      # promotion1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@promotion1.user)
      # promotion2に遷移する
      visit promotion_path(@promotion2.id)
      # 編集ボタンがない事を確認する
      expect(page).to have_no_link '編集', href: edit_promotion_path(@promotion2)
    end
    it 'ログインしていないとpromotionの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 商品一覧への遷移ボタンがない事を確認する
      expect(page).to have_no_link '最新商品', href: promotions_path
    end
  end
end
RSpec.describe 'promotion/destroy', type: :system do
  before do
    @promotion1 = FactoryBot.create(:promotion)
    @promotion2 = FactoryBot.create(:promotion)
  end
  context 'promotionを削除できる' do
    it 'ログインしたユーザーは自らが投稿した商品を削除できる' do
      # promotion1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@promotion1.user)
      # promotion1に遷移する
      visit promotion_path(@promotion1.id)
      # 編集画面に遷移する
      visit edit_promotion_path(@promotion1)
      # 削除ボタンがある事を確認する
      expect(page).to have_link '削除', href: promotion_path(@promotion1)
      # 削除するとpromotionモデルの数が1つ減る事を確認する
      expect{
        find_link('削除', href: promotion_path(@promotion1)).click
        expect(page.driver.browser.switch_to.alert.text).to eq "よろしいですか？"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content '商品を削除しました'
      }. to change { Promotion.count }.by(-1)
      # 商品一覧画面に遷移した事を確認する
      expect(current_path).to eq promotions_path
      # promotion1がない事を確認する
      expect(
        all(".item")[0]
      ).to have_no_content(@promotion1)
    end
  end
  context 'promotion1を削除できない' do
    it 'ログインしたユーザーは自分の投稿以外は削除できない' do
      basic_pass(path)
      sign_in(@promotion1.user)
      # promotion2に遷移する
      visit promotion_path(@promotion2.id)
      # 削除ボタンがない事を確認する
      expect(page).to have_no_link '削除', href: promotion_path(@promotion2)
    end
    it 'ログインしていないと削除できない' do
      # トップページにいる
      visit root_path
      # 商品一覧への遷移ボタンがない事を確認する
      expect(page).to have_no_link '最新商品', href: promotions_path
    end
  end
end
