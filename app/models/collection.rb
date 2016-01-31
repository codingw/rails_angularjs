class Collection < ActiveRecord::Base
  validates_presence_of :contractno, :kode_cabang

  scope :paid, -> paid = true { where(status: paid) }
  scope :unpaid, -> paid = false { where(status: paid) }
  scope :by_kode_cabang, -> kc = kode_cabang { where(kode_cabang: kc) }
end
