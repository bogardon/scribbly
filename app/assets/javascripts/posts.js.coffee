# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  Comment = Backbone.Model.extend {

  }

  postId = location.pathname.split('/').pop()

  CommentList = Backbone.Collection.extend {
    model: Comment,
    initialize: (models, options) ->
      this.postId = options.postId
    ,
    url: () ->
      "/posts/#{this.postId}/comments"
    ,
  }

  Comments = new CommentList([], {postId: postId})

  CommentView = Backbone.View.extend {
    tagName: "li",
    className: "comment-list-item"
    template: _.template($("#comment-template").html()),
    initialize: () ->
      this.listenTo this.model, 'change', this.render
      this.listenTo this.model, 'destroy', this.remove
    ,
    events: {
    }
    render: () ->
      this.$el.html this.template(this.model.toJSON())
      return this
    ,
    clear: () ->
      this.model.destroy()
  }

  CommentSectionView = Backbone.View.extend {
    el: $("#comment-section"),
    initialize: () ->
      this.list = $("#comment-list")
      this.listenTo Comments, 'add', this.addOne
      this.listenTo Comments, 'all', this.render
      Comments.fetch {

      }
    ,
    events: {
      "click a#post-button": "createComment"
    },
    createComment: (e) ->
      textArea = $("#new-comment-field")
      body = textArea.val()
      textArea.val("")

      Comments.create {
        body: body
      }
    ,
    addOne: (comment) ->
      view = new CommentView({model: comment})
      this.list.append(view.render().el)
  }

  CommentsView = new CommentSectionView
