class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :area_new3
      t.string :area_arm_2
      t.string :bran_br_name
      t.integer :contractno
      t.integer :kode_cabang
      t.string :objtdesc
      t.float :bal_prin
      t.integer :arec_appl_no
      t.integer :days
      t.string :bucket
      t.datetime :reqdate
      t.string :nama_remedia
      t.datetime :jatuh_tempo_ang_tertunggak
      t.integer :installment_no
      t.string :area_collection
      t.string :collector_name
      t.string :cust_name
      t.boolean :status, default: false

      t.timestamps null: false
    end
  end
end
