class PagesController < ApplicationController

  # FINISH!!!
  def charge
    @amount = 1000

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Tuckered.In (1 Year)',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to "/subscribe"
  end

  # BUILD OUT!
  def charges
  end

  def subscribe
    render :layout => false
  end

  # No longer used...
  def splash
    render :layout => false
  end

end
