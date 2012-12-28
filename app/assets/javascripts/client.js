(function($){
  $(function(){

    var List = function(listId, htmlElementId, websocket){
      this.websocket = websocket;
      this.htmlElementId = htmlElementId;
      this.listId = listId;
    };

    List.prototype.init = function(){
      this.initSortable();
      this.initBestInPlace();
      this.subscribe();
    };

    List.prototype.initSortable = function(){
      that = this;
      $(that.htmlElementId).sortable({
        update: function(event, ui){
          $.ajax({
            type: "PUT",
            dataType: "script",
            data: { list: { todos: $(that.htmlElementId).sortable("toArray") } }
          });
          $(that.htmlElementId).disableSelection();
        }
      });
    };

    List.prototype.initBestInPlace = function(){
      $(".best_in_place", $(this.htmlElementId)).best_in_place();
    };

    List.prototype.addTodo = function(data){
      $(this.htmlElementId).prepend(data);
      this.initBestInPlace();
      this.initSortable();
    };

    List.prototype.removeTodo = function(data){
      $(data).remove();
      this.initBestInPlace();
      this.initSortable();
    };

    List.prototype.updateTodo = function(data){
      try {
        d = JSON.parse(data);
        d.done ? doneClass = "done" : doneClass = "not-done";
        $("#todo-" + d.id).attr("class", doneClass);
        $("#best_in_place_todo_" + d.id + "_title").html(d.title);
        done = $("#best_in_place_todo_" + d.id + "_done");
        tags = done.data('collection');
        d.done ?  done.html(tags[1]) : done.html(tags[0]);
        this.initBestInPlace();
        this.initSortable();
      } catch(err) {
        console.log(err);
        // JSON.parse might throw an error if so inform the user to refresh
        alert("Something went wrong :(! Please refresh the page");
      }
    };

    List.prototype.reorderTodos = function(data){
      $(this.htmlElementId).replaceWith(data);
      this.initBestInPlace();
      this.initSortable();
    };

    List.prototype.subscribe = function(){
      var that = this;
      this.websocket.subscribe("/" + this.listId + "/add", function(data){
        that.addTodo(data);
      });
      this.websocket.subscribe("/" + this.listId + "/remove", function(data){
        that.removeTodo(data);
      });
      this.websocket.subscribe("/" + this.listId + "/update", function(data){
        that.updateTodo(data);
      });
      this.websocket.subscribe("/" + this.listId + "/reorder", function(data){
        that.reorder(data);
      });
    };


    // Initialize the app
    var App = function(listId, fayeUrl){
      this.listId = listId;
      this.faye = new Faye.Client(fayeUrl);
    }

    App.prototype.init = function(){
      var list = new List(this.listId, '#todo-list', this.faye);
      list.init();
    };

    if(typeof LIST_ID !== "undefined") {
      var app = new App(LIST_ID, FAYE_URL);
      app.init();
    }
  });
})(jQuery);
