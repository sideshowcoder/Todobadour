root = exports ? this

jQuery ($) ->

  class List
    constructor: (@id) ->

    current_list: ->
      $(@id)

    asSortable: ->
      @current_list().sortable update: (event, ui) =>
        $.ajax
          type: 'PUT'
          dataType: 'script'
          data:
            list:
              todos: this.current_list().sortable 'toArray'
      do @current_list().disableSelection

    asBestInPlace: ->
      do $('.best_in_place', @current_list()).best_in_place

    addTodo: (data) ->
      @current_list().prepend(data)
      do @asBestInPlace
      do @asSortable

    removeTodo: (data) ->
      $(data).remove()
      do @asBestInPlace
      do @asSortable

    updateTodo: (data) ->
      try
        d = JSON.parse data
        $("#best_in_place_todo_#{d.id}_title").html d.title
        done = $("#best_in_place_todo_#{d.id}_done")
        tags = done.data('collection')
        if d.done
          done.html tags[1]
        else
          done.html tags[0]
      catch error
        error
      do @asBestInPlace
      do @asSortable

    reorder: (data) ->
      @current_list().replaceWith data
      do @asBestInPlace
      do @asSortable


  if LIST_ID?
    root.list = list = new List '#todo-list'
    do list.asSortable
    faye = new Faye.Client FAYE_URL
    faye.subscribe "/#{LIST_ID}/add", (data) ->
      list.addTodo data
    faye.subscribe "/#{LIST_ID}/remove", (data) ->
      list.removeTodo data
    faye.subscribe "/#{LIST_ID}/update", (data) ->
      list.updateTodo data
    faye.subscribe "/#{LIST_ID}/reorder", (data) ->
      list.reorder data

