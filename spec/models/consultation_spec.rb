require 'rails_helper'

RSpec.describe Consultation, type: :model do
  before do
    @consultation = FactoryBot.build(:consultation)
  end

  describe "consultation登録" do
    context "consultationの登録ができる" do
      it "titleとcontentを入力すれば登録できる" do
        expect(@consultation).to be_valid
      end
    end
    context "consultationの登録ができない" do
      it "titleが空では登録できない" do
        @consultation.title = nil
        @consultation.valid?
        expect(@consultation.errors.full_messages).to include("タイトルを入力してください")
      end
      it "titleが41字以上だと登録できない" do
        @consultation.title = "a" * 41
        @consultation.valid?
        expect(@consultation.errors.full_messages).to include("タイトルは40文字以内で入力してください")
      end
      it "contentが空では登録できない" do
        @consultation.content = nil
        @consultation.valid?
        expect(@consultation.errors.full_messages).to include("内容を入力してください")
      end
      it "categoryが「ーーー」なら登録できない" do
        @consultation.category_id = 1
        @consultation.valid?
        expect(@consultation.errors.full_messages).to include("Categoryは[---]意外をお選びください")
      end
    end
  end
end
