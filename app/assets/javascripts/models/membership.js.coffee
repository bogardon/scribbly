Scribbly.Models.Membership = Backbone.Model.extend(
  user: () ->
    @attributes.user
  urlRoot: '/memberships'
)
