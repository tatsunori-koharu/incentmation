require 'rails_helper'

RSpec.describe "Consultations", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation_title = Faker::Lorem.characters(number: 10)
    @consultation_content = Faker::Lorem.sentence
  end
  context '相談に投稿できるとき' do
    it 'ログインユーザーは新規投稿できる' do
      # Basic認証をする
      basic_pass(path)
      visit root_path
      # ログインする
      sign_in(@user)
      # 相談一覧へのリンクがあることを確認する
      expect(page).to have_content('最新の相談')
      # 相談一覧へ移動する
      visit consultations_path
      # 投稿ページへのリンクがあることを確認する
      expect(page).to have_content('新規相談')
      # 投稿ページへ移動する
      visit new_consultation_path
      # フォームに情報を入力する
      fill_in 'consultation_title', with: @consultation_title
      fill_in 'consultation_content', with: @consultation_content
      find("#consultation_category_id").find("option[value='2']").select_option
      attach_file "consultation[images][]", "app/assets/images/gahag-0041371722-1.png"
      attach_file "consultation[move]", "app/assets/images/PXL_20210124_062824863.mp4"
      # 送信するとconsultationモデルのカウントが１上がることを確認する
      expect do
        click_button "投稿"
      end.to change(Consultation, :count).by(1)
      # 相談一覧ページに遷移することを確認する
      expect(current_path).to eq consultations_path
      # 投稿した内容の相談が存在することを確認する
      expect(page.find('.consultation-image')['src']).to have_content(@consultation_image)
      expect(
        find(".item ").hover
      ).to have_content("#{@consultation_title}")
      expect(
        find(".item ").hover
      ).to have_content("#{@consultation_content}")
      # 相談にカーソルを合わせると詳細ページへに遷移ボタンがあることを確認する
      expect(
        find(".item ").hover
      ).to have_content('この記事へ')
      
    end
  end
  context '相談に投稿できないとき' do
    it 'ログインしていないと新規相談ページに遷移できない' do
      # トップページに遷移する
      basic_pass(path)
      visit root_path
      # 新規相談ページへのリンクがない
      expect(page).to have_no_content('新規相談')
    end
  end
end

RSpec.describe 'consultation/edit', type: :system do
  before do
    @consultation1 = FactoryBot.create(:consultation)
    @consultation2 = FactoryBot.create(:consultation)
  end
  context 'consultationが編集できるとき' do
    it 'ログインユーザーは自分が投稿した相談を編集できる' do
      # consultation1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@consultation1.user)
      # consultation1に遷移する
      visit consultation_path(@consultation1.id)
      # consultation1に編集ボタンがある事を確認する
      expect(page).to have_link '編集', href: edit_consultation_path(@consultation1)
      # 編集ページへ遷移する
      visit edit_consultation_path(@consultation1)
      # すでに投稿済みの内容がフォームに入っている事を確認する
      expect(
        find('#consultation_title').value
      ).to eq @consultation1.title
      expect(
        find('#consultation_content').value
      ).to eq @consultation1.content
      expect(
        find('#consultation_category_id').value
      ).to eq "#{@consultation1.category_id}"
      # 投稿内容を編集する
      fill_in 'consultation_title', with: "#{@consultation1.title} + 'アイウエオ' "
      fill_in 'consultation_content', with: "#{@consultation1.content} + '中央材料室' "
      attach_file "consultation[images][]", "app/assets/images/gahag-0041371722-1.png"
      attach_file "consultation[move]", "app/assets/images/PXL_20210124_062824863.mp4"
      # 編集してもconsultationモデルのカウントが変わらない事を確認する
      expect do
        click_button "投稿"
      end.to change { Consultation.count }.by(0)
      # 一覧ページに遷移する
      visit consultations_path
      # 投稿した内容の相談が存在することを確認する
      expect(page.find('.consultation-image')['src']).to have_content(@consultation_image)
      expect(
        all(".item")[0].hover
      ).to have_content(@consultation_title)
      expect(
        all(".item")[0].hover
      ).to have_content(@consultation_content)
      # 詳細ページに遷移する
      visit consultation_path(@consultation1.id)
      # 詳細ページに投稿が反映されている事を確認する
      expect(page.find('.site-image ')['src']).to have_content(@consultation_image)
      expect(page).to have_content("#{@consultation_title}")
      expect(page).to have_content("#{@consultation_content}")
      expect(page).to have_content(@consultation_category)
      expect(page.find('.move')['src']).to have_content(@consultation_move)
    end
  end
  context 'consultationが編集できないとき' do
    it 'ログインユーザーは自分以外が投稿した相談の編集画面には遷移できない' do
      # consultation1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@consultation1.user)
      # consultation2に遷移する
      visit consultation_path(@consultation2.id)
      # 編集ボタンがない事を確認する
      expect(page).to have_no_link '編集', href: edit_consultation_path(@consultation2)
    end
    it 'ログインしていないとconsultationの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 相談一覧への遷移ボタンがない事を確認する
      expect(page).to have_no_link '最新の相談', href: consultations_path
    end
  end
end
RSpec.describe 'consultation/destroy', type: :system do
  before do
    @consultation1 = FactoryBot.create(:consultation)
    @consultation2 = FactoryBot.create(:consultation)
  end
  context 'consultationを削除できる' do
    it 'ログインしたユーザーは自らが投稿した相談を削除できる' do
      # consultation1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@consultation1.user)
      # consultation1に遷移する
      visit consultation_path(@consultation1.id)
      # 編集画面に遷移する
      visit edit_consultation_path(@consultation1)
      # 削除ボタンがある事を確認する
      expect(page).to have_link '削除', href: consultation_path(@consultation1)
      # 削除するとconsultationモデルの数が1つ減る事を確認する
      expect{
        find_link('削除', href: consultation_path(@consultation1)).click
        expect(page.driver.browser.switch_to.alert.text).to eq "よろしいですか？"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content '相談を削除しました'
      }. to change { Consultation.count }.by(-1)
      # 相談一覧画面に遷移した事を確認する
      expect(current_path).to eq consultations_path
      # consultation1がない事を確認する
      expect(
        all(".item")[0]
      ).to have_no_content(@consultation1)
    end
  end
  context 'consultation1を削除できない' do
    it 'ログインしたユーザーは自分の投稿以外は削除できない' do
      basic_pass(path)
      sign_in(@consultation1.user)
      # consultation2に遷移する
      visit consultation_path(@consultation2.id)
      # 削除ボタンがない事を確認する
      expect(page).to have_no_link '削除', href: consultation_path(@consultation2)
    end
    it 'ログインしていないと削除できない' do
      # トップページにいる
      visit root_path
      # 相談一覧への遷移ボタンがない事を確認する
      expect(page).to have_no_link '最新の相談', href: consultations_path
    end
  end
end
