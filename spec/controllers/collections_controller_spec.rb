require 'spec_helper'

describe CollectionsController do
  let!(:collection) { create :collection }
  let!(:paid_collection) { create :paid_collection }

  describe 'GET /index' do
    context 'when get with nothing params paid' do
      before { get :index, format: :json }
      it { is_expected.to respond_with :ok }
      it { expect(assigns :collections).to include collection }
    end

    context 'when get all data collections with status unpaid' do
      before { get :index, format: :json, paid: false }
      it { is_expected.to respond_with :ok }
      it { expect(assigns :collections).to include collection }
      it { expect(assigns :collections).not_to include paid_collection }
    end

    context 'when get all data collections with status paid' do
      before { get :index, format: :json, paid: true }
      it { is_expected.to respond_with :ok }
      it { expect(assigns :collections).not_to include collection }
      it { expect(assigns :collections).to include paid_collection }
    end
  end

  describe 'GET /show' do
    context 'when collection is not found' do
      before { get :show, format: :json, id: 0 }
      it { is_expected.to respond_with :ok }
      it { expect(assigns :collection).not_to eq collection }
    end

    context 'when collection is found' do
      before { get :show, format: :json, id: collection.contractno }
      it { is_expected.to respond_with :ok }
      it { expect(assigns :collection).to eq collection }
    end
  end

  describe 'PATCH /update' do
    let(:collection_attributes) { attributes_for :collection }
    context 'with valid attributes' do
      before(:each) { patch :update, id: collection.contractno, collection: collection_attributes }
      it { is_expected.to respond_with :ok }
    end

    context 'with invalid attributes' do
      before(:each) { patch :update, id: collection.contractno, collection: collection_attributes.merge(contractno: '') }
      it { should respond_with :ok }
    end
  end

  describe 'DELETE /destroy' do
    let(:auth_headers) { { 'AUTHORIZATION' => 'Token token="foobar"' } }
    before(:each) { delete :destroy, id: collection.contractno, format: :json }
    it { is_expected.to respond_with 204 }
  end
end
