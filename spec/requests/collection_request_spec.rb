require 'spec_helper.rb'

describe "Looking up collections", js: true do
  context "does not have collections" do
    before { visit '#/collections' }

    it "should does not have content list collections" do
      expect(page).not_to have_selector('tr[ng-show="collections.length"]')
    end
  end

  context "have collections" do
    let!(:collections) { create_list :collection, 2 }
    before { visit '#/collections' }

    it "should have content list collections" do
      expect(page).to have_content("Collections")
      expect(page).to have_content("Kode Cabang")
      expect(page).to have_content("Contract")
    end

    it "should have content collections first" do
      expect(page).to have_selector('tr[ng-show="collections.length"]')
    end
  end
end

