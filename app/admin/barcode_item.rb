# == Schema Information
#
# Table name: barcode_items
#
#  id         :integer          not null, primary key
#  value      :string
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# (modified 18 June 2016)

ActiveAdmin.register BarcodeItem do

  menu parent: "Inventory", label: "Barcodes"

  permit_params :value, :item_id, :quantity, :return_to_donation_id
  
  filter :item
  filter :quantity
  filter :created_at

  controller do
    def create
      #Rails.logger.info(resource.inspect)
      return_to_donation_id = params["barcode_item"].delete("return_to_donation_id")
      super do |format|
        if return_to_donation_id.present? && resource.valid? && donation = Donation.find(return_to_donation_id)
          donation.track(resource.item, resource.quantity)
          format.html { (redirect_to(donation_path(return_to_donation_id, from: "barcode"), notice: "Added new barcode!") and return)  }
        elsif resource.valid?
          format.html { (redirect_to(new_barcode_item_path, notice: "Added barcode!") and return)  }
        end
      end
    end
  end

  form do |f|
    panel "Instructions" do
      ol do
        li "1. Select the item type (if it's not in the list, you'll need to create a new one"
        li "2. Type in how many of that item there are in the package (for '120 diapers' you would just write '120')"
        li "3. Click in the barcode field first, then scan the barcode with your reader"
      end
    end
    inputs 'Add New Item' do
      f.input :item
      f.input :quantity, label: 'Quantity in the Box'
      if (params[:value].present?)
        f.input :value, as: :hidden, label: "Barcode Entered.", input_html: { value: params[:value] }
      else
        f.input :value, label: 'Scan Barcode'
      end
      #if (params[:return_to_donation_id].present?) then  end
      f.input :return_to_donation_id, as: :hidden, input_html: { value: params[:return_to_donation_id] }
      actions
    end
  end

  index do
    selectable_column
    column 'Item Type', :item
    column "Quantity in the Box", :quantity
    column "Barcode", :value, sortable: false
    actions
  end


end
