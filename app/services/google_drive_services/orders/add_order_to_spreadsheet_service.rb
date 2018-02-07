module GoogleDriveServices
  module Orders
    class AddOrderToSpreadsheetService
      def initialize(order)
        @order = order
        @google_drive_session = GoogleDrive::Session.from_config(ENV["GOOGLE_DRIVE_JSON_FILEPATH"])
      end

      def call
        # Populating the Global spreadsheet
        worksheet = @google_drive_session.spreadsheet_by_key(Orders::Config::SPREADSHEET_KEY_GLOBAL).worksheets[0]
        next_row = worksheet.num_rows + 1
        populate_spreadsheet(worksheet, next_row)

        # Populating the FR spreadsheet if applicable
        if @order.shipping_address.country == 'FR'
          worksheet = @google_drive_session.spreadsheet_by_key(Orders::Config::SPREADSHEET_KEY_FR).worksheets[0]
          next_row = worksheet.num_rows + 1
          populate_spreadsheet(worksheet, next_row)
        end
      end

      private
      def populate_spreadsheet(ws, next_row)
        box         = Product.find_by(sku: "litter-box")
        display_box = Product.find_by(sku: "display-box")

        box_quantity          = @order.order_details.find_by(product_id: box.id).quantity
        display_box_quantity  = @order.order_details.find_by(product_id: display_box.id).quantity

        ws[next_row, 1] = @order.created_at.strftime("%m-%d-%Y")
        # ws[next_row, 2] = @order.user.fullname
        ws[next_row, 2] = @order.shipping_address.designation
        ws[next_row, 3] = @order.shipping_address.country_name
        ws[next_row, 4] = box_quantity
        ws[next_row, 5] = display_box_quantity
        ws[next_row, 6] = @order.total_price_ht
        ws[next_row, 7] = box.unit_price
        ws[next_row, 8] = display_box.unit_price
        # Column 9 used for transport price
        ws[next_row, 10] = @order.user.phone_number
        ws[next_row, 11] = @order.user.fullname
        ws[next_row, 12] = @order.user.email
        ws[next_row, 13] = @order.observations
        ws[next_row, 14] = @order.first_order? ? "yes" : "no"
        ws.save
      end
    end
  end
end
