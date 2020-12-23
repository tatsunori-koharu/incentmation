class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '滅菌' },
    { id: 3, name: '洗浄' },
    { id: 4, name: '包装' },
    { id: 5, name: '乾燥' },
    { id: 6, name: '組み立て' },
    { id: 7, name: '保管' },
  ]

  include ActiveHash::Associations
  has_many :articles
  has_many :consultations
  has_many :promotions
  
  end