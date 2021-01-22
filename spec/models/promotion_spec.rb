require 'rails_helper'

RSpec.describe Promotion, type: :model do
  before do
    @promotion = FactoryBot.build(:promotion)
  end

  describe "promotion登録" do
    context "promotionの登録ができる" do
      it "nameとcontentを入力すれば登録できる" do
        expect(@promotion).to be_valid
      end
    end
    context "promotionの登録ができない" do
      it "nameが空では登録できない" do
        @promotion.name = nil
        @promotion.valid?
        expect(@promotion.errors.full_messages).to include("商品名を入力してください")
      end
      it "nameが41字以上だと登録できない" do
        @promotion.name = "a" * 41
        @promotion.valid?
        expect(@promotion.errors.full_messages).to include("商品名は40文字以内で入力してください")
      end
      it "contentが空では登録できない" do
        @promotion.content = nil
        @promotion.valid?
        expect(@promotion.errors.full_messages).to include("内容を入力してください")
      end
      it "categoryが「ーーー」なら登録できない" do
        @promotion.category_id = 1
        @promotion.valid?
        expect(@promotion.errors.full_messages).to include("Categoryは[---]意外をお選びください")
      end
    end
  end
end
