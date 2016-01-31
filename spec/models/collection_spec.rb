require 'spec_helper'

describe Collection do
  it { is_expected.to have_db_column(:area_new3) }
  it { is_expected.to have_db_column(:area_arm_2) }
  it { is_expected.to have_db_column(:bran_br_name) }
  it { is_expected.to have_db_column(:contractno).of_type(:integer) }
  it { is_expected.to have_db_column(:kode_cabang).of_type(:integer) }
  it { is_expected.to have_db_column(:objtdesc) }
  it { is_expected.to have_db_column(:bal_prin).of_type(:float) }
  it { is_expected.to have_db_column(:arec_appl_no).of_type(:integer) }
  it { is_expected.to have_db_column(:days).of_type(:integer) }
  it { is_expected.to have_db_column(:bucket) }
  it { is_expected.to have_db_column(:reqdate).of_type(:datetime) }
  it { is_expected.to have_db_column(:nama_remedia) }
  it { is_expected.to have_db_column(:jatuh_tempo_ang_tertunggak).of_type(:datetime) }
  it { is_expected.to have_db_column(:installment_no).of_type(:integer) }
  it { is_expected.to have_db_column(:area_collection) }
  it { is_expected.to have_db_column(:collector_name) }
  it { is_expected.to have_db_column(:cust_name) }
  it { is_expected.to have_db_column(:status).of_type(:boolean) }

  it { is_expected.to validate_presence_of(:contractno)}
  it { is_expected.to validate_presence_of(:kode_cabang)}

  context 'scoping' do
    let!(:paid_collection) { create :paid_collection }
    let!(:unpaid_collection) { create_list :collection, 2 }
    let!(:unpaid_collection) { create_list :collection, 2, kode_cabang: '123' }

    describe '.paid' do
      it 'show paid data' do
        expect(Collection.paid.count).to eq 1
      end
    end

    describe '.unpaid' do
      it 'show unpaid data' do
        expect(Collection.unpaid.count).to eq 2
      end
    end

    describe '.by_kode_cabang' do
      it 'show data by kode_cabang' do
        expect(Collection.by_kode_cabang('123').count).to eq 2
      end
    end
  end
end
