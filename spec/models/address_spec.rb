require 'rails_helper'

describe Address do
  describe '#create' do

    it "postal_code,prefecture_id,city,address,posting_family_name,posting_first_name,posting_family_name_f,posting_first_name_fが存在すれば登録できること" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "postal_codeがない場合は登録できないこと" do
      address = build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    it "prefecture_idがない場合は登録できないこと" do
      address = build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end

    it "cityがない場合は登録できないこと" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end
    
    it "addressがない場合は登録できないこと" do
      address = build(:address, address: nil)
      address.valid?
      expect(address.errors[:address]).to include("を入力してください")
    end

    it "posting_family_nameがない場合は登録できないこと" do
      address = build(:address, posting_family_name: nil)
      address.valid?
      expect(address.errors[:posting_family_name]).to include("を入力してください")
    end

    it "posting_first_nameがない場合は登録できないこと" do
      address = build(:address, posting_first_name: nil)
      address.valid?
      expect(address.errors[:posting_first_name]).to include("を入力してください")
    end

    it "posting_family_name_fがない場合は登録できないこと" do
      address = build(:address, posting_family_name_f: nil)
      address.valid?
      expect(address.errors[:posting_family_name_f]).to include("を入力してください")
    end

    it "posting_first_name_fがない場合は登録できないこと" do
      address = build(:address, posting_first_name_f: nil)
      address.valid?
      expect(address.errors[:posting_first_name_f]).to include("を入力してください")
    end
  end
end