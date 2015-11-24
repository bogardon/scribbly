Scribbly.Views.AssetsIndexView = Backbone.View.extend(
  template: JST['assets/index']

  id: "asset-section"

  initialize: ->
    @collection = new Scribbly.Collections.Assets()
    @assetViews = []
    @listenTo @collection, "add", @addAsset
    @listenTo @collection, "remove", @removeAsset

  events:
    'click #upload-content-button': 'onUploadButton'
    'change #upload-asset': 'onFileSelect'

  render: ->
    @$el.append @template(asset: @model)
    @upload = @$el.find("#upload-asset")

    self = this
    @collection.each (a) ->
      self.addAsset(a)

    this

  onUploadButton: () ->
    @upload.trigger('click')

  onFileSelect: () ->
    file = @upload[0].files[0]
    formData = new FormData()
    formData.append('asset[image][attachment]', file, file.name)
    formData.append('asset[content_id]', @contentId)
    self = this
    @model.create(
      {

      },
      {
        wait: true,
        data: formData,
        processData: false
        contentType: false
        success: ->

      }
    )

  removeAsset: (a) ->
    assetView = _.find(
      @assetViews,
      (view) ->
        view.model == a
    )
    assetView.remove()
    assetView.unbind()
    @assetViews.splice(@assetViews.indexOf(assetView), 1)

  addAsset: (a) ->
    assetView = new Scribbly.Views.AssetListItemView(model: a)
    @assetViews.push assetView
    @$el.find("#asset-list").append assetView.render().$el
)
