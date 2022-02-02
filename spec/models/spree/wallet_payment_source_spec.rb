# frozen_string_literal: true

RSpec.describe Spree::WalletPaymentSource do
  describe 'setting it as the default' do
    it 'reports a payment method changed event for subscriptions that use the default payment source' do
      stub_const('SolidusSupport::LegacyEventCompat::Bus', class_spy(SolidusSupport::LegacyEventCompat::Bus))
      user = create(:user)
      subscription = create(:subscription, user: user)
      payment_source = create(:credit_card, user: user)
      wallet_payment_source = user.wallet.add(payment_source)

      user.wallet.default_wallet_payment_source = wallet_payment_source

      expect(SolidusSupport::LegacyEventCompat::Bus).to have_received(:publish).with(
        :'solidus_subscriptions.subscription_payment_method_changed',
        subscription: subscription,
      )
    end
  end
end
