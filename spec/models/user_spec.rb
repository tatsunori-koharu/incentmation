require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "新規登録" do
    context "新規登録ができること" do
      it "全ての入力をおこなえば新規登録できる" do
        expect(@user).to be_valid
      end
      it "bedが空でも登録できる" do
        @user.bed = nil
        expect(@user).to be_valid
      end
      it "licenseがからでも登録できる" do
        @user.license = nil
        expect(@user).to be_valid
      end
      it "companyが空でも登録できる" do
        @user.company = nil
        expect(@user).to be_valid
      end
    end

    context "新規登録できない" do
      it "nicknameが空では登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "nicknameが重複していると登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.nickname = @user.nickname
        another_user.valid?
        expect(another_user.errors.full_messages).to include('ニックネームはすでに存在します')
      end
      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "emailが重複していると登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it "passwordが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "passwordは5文字以下では登録できない" do
        @user.password = "iii99"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは6文字以上で入力してください")
      end
      it "password_confirmationが空では登録できない" do
        @user.password = "iii999"
        @user.password_confirmation = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "location_idが「ーーー」では登録できない" do
        @user.location_id = "1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Locationは1以外の値にしてください")
      end
      it "service_yearsが空では登録できない" do
        @user.service_years = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("勤務年数を入力してください", "勤務年数は不正な値です")
      end
    end
  end
end
