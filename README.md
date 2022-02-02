# Subcriptions pro
### Guest checkout

Subscriptions require a user to be present to allow them to be managed after they are purchased.

Because of this, you must disable guest checkout for orders which contain `subscription_line_items`.

An example would be adding this to the registration page:

```erb
<%# spree/checkout/registration.html.erb %>
<% if Spree::Config[:allow_guest_checkout] && current_order.subscription_line_items.empty? %>
```

This allows guests to add subscriptions to their carts as guests, but forces them to login or create
an account before purchasing them.
