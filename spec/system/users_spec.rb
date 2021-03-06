require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
    # Basic認証を入力
    basic_pass(path)
    root_path
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('新規登録')
    # 新規登録ページに遷移する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in 'ニックネーム', with: @user.nickname
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: @user.password
    fill_in 'パスワード（確認用）', with: @user.password_confirmation
    find("#user_location_id").find("option[value='2']").select_option
    find("#user_department_id").find("option[value='2']").select_option
    fill_in 'Bed', with: @user.bed
    fill_in '勤務年数', with: @user.service_years
    fill_in 'License', with: @user.license
    fill_in 'Company', with: @user.company
    # サインアップボタンを押すとユーザーモデルのカウントが上がることを確認する
    expect {
      find('input[name="commit"]').click
    }.to change { User.count }.by(1)
    # トップページへ遷移する
    expect(current_path).to eq root_path
    # クリックするとログアウトボタンが表示されることを確認する
    expect(
      find(".user-icon").find(".user-menu").click
    ).to have_content('ログアウト')
    # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('新規登録')
    expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻る' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに遷移する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: ""
      fill_in 'Eメール', with: ""
      fill_in 'パスワード', with: ""
      fill_in 'パスワード（確認用）', with: ""
      find("#user_location_id").find("option[value='1']").select_option
      find("#user_department_id").find("option[value='1']").select_option
      fill_in 'Bed', with: ""
      fill_in '勤務年数', with: ""
      fill_in 'License', with: ""
      fill_in 'Company', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻ることを確認する
      expect(current_path).to eq "/users"
    end
  end
end
RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができること' do
    it '保存されているユーザーの情報と合致すればログインできる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      sign_in(@user)
      # カーソルを合わせてクリックするとログアウトボタンが表示されることを確認する
      expect(
        find(".user-icon").find(".user-menu").click
      ).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができないこと' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'Eメール', with: ""
      fill_in 'パスワード', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end