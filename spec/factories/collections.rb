FactoryGirl.define do
  factory :collection do
    area_new3 { Faker::Lorem.sentence(1) }
    area_arm_2 { Faker::Lorem.sentence(1) }
    bran_br_name { Faker::Lorem.sentence(1) }
    contractno { Faker::Number.number(3) }
    kode_cabang { Faker::Number.number(3) }
    objtdesc { Faker::Lorem.sentence(5) }
    bal_prin 1.5
    arec_appl_no 1
    days 10
    bucket { Faker::Lorem.sentence(1) }
    reqdate { Faker::Date.backward(14) }
    nama_remedia { Faker::Name.name }
    jatuh_tempo_ang_tertunggak { Faker::Date.forward(23) }
    installment_no { Faker::Number.number(4) }
    area_collection { Faker::Lorem.sentence(2) }
    collector_name { Faker::Name.name }
    cust_name  { Faker::Name.name }
    status 0

    factory :paid_collection do
      after(:create) do |collection, evaluator|
        collection.update(status: true)
      end
    end
  end

end
