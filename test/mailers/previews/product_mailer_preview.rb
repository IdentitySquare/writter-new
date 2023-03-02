# Preview all emails at http://localhost:3000/rails/mailers/product_mailer
class ProductMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/product_mailer/product_updates.html.haml
  def product_updates.html.haml
    ProductMailer.product_updates.html.haml
  end

end
