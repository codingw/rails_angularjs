class CollectionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  respond_to :json

  def index
    limit = params[:limit] || 10
    if params[:paid] == true
      @collections = Collection.paid
    else
      @collections = Collection.unpaid
    end
    @collecitions = @collections.page(params[:page]).per(limit)
    respond_with @collections
  end

  def show
    @collection = Collection.find_by(contractno: params[:id])
    respond_with @collection
  end

  def create
    @collection = Collection.new collection_params
    if @collection.save
      respond_with @collection
    else
      render json: [message: "failed created collection"]
    end
  end

  def update
    @collection = Collection.find_by(contractno: params[:id])
    if @collection.update_attributes(collection_params)
      respond_with @collection.reload
    else
      render json: [message: "failed update collection"]
    end
  end

  def destroy
    @collection = Collection.find_by(contractno: params[:id])
    if @collection.destroy
      limit = params[:limit] || 10
      if params[:paid] == true
        @collections = Collection.paid
      else
        @collections = Collection.unpaid
      end
      @collecitions = @collections.page(params[:page]).per(limit)
      respond_with @collections
    end
  end

  private
  def collection_params
    # params.fetch(:collection, {}).permit(:contractno, :kode_cabang)
    params.fetch(:collection, {}).permit(
      :id, :area_new3, :area_arm_2, :bran_br_name, :contractno, :kode_cabang, :objtdesc, :bal_prin,
      :arec_appl_no, :day, :bucket, :reqdate, :nama_remedia, :jatuh_tempo_ang_tertunggak, :installment_no,
      :area_collection, :cust_name, :status
    )
  end
end
