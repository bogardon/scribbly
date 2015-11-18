Scribbly.Views.AssetsIndexView = Backbone.View.extend(
  template: JST['assets/index']

  id: "asset-section"

  initialize: ->
    @model = new Scribbly.Collections.Assets()
    @assetViews = []
    @listenTo @model, "add", @addAsset
    @listenTo @model, "remove", @removeAsset

  events:
    'click #upload-content-button': 'onUploadButton'
    'change #upload-asset': 'onFileSelect'

  render: ->
    @$el.append @template(asset: @model)
    @upload = @$el.find("#upload-asset")
    @delegateEvents()
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

  setContentId: (contentId) ->
    @contentId = contentId
    @model.fetch(
      data:
        content_id: @contentId
    )

  removeAsset: (a) ->
    assetView = _.find(
      @assetViews,
      (view) ->
        view.model == a
    )
    assetView.remove()
    assetView.unbind()

  addAsset: (a) ->
    assetView = new Scribbly.Views.AssetListItemView(model: a)
    @assetViews.push assetView
    @$el.find("#asset-list").append assetView.render().$el
)
