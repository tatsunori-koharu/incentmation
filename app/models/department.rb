class Department < ActiveHash::Base 
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '内科' },
    { id: 3, name: '呼吸器内科' },
    { id: 4, name: '消化器内科' },
    { id: 5, name: '循環器内科' },
    { id: 6, name: '小児科' },
    { id: 7, name: '外科' },
    { id: 8, name: '整形外科' },
    { id: 9, name: '形成外科' },
    { id: 10, name: '美容外科' },
    { id: 11, name: '脳神経外科' },
    { id: 12, name: '呼吸器外科' },
    { id: 13, name: '心臓血管外科' },
    { id: 14, name: '循環器外科' },
    { id: 15, name: '小児外科' },
    { id: 16, name: '皮膚科' },
    { id: 17, name: '泌尿器科' },
    { id: 18, name: '産科' },
    { id: 19, name: '婦人科' },
    { id: 20, name: '産婦人科' },
    { id: 21, name: '眼科' },
    { id: 22, name: '耳鼻咽喉科' },
    { id: 23, name: '気管食道科' },
    { id: 24, name: '麻酔科' },
    { id: 25, name: '歯科' },
    { id: 26, name: '歯科口腔外科' },
    { id: 27, name: 'その他' }

  ]

  include ActiveHash::Associations
  has_many :users
end
