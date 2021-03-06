BasecampApp.Models.Task = Backbone.Model.extend({
  urlRoot: "/api/tasks",
  
  assignments: function () {
    this._assignments = this._assignments || new BasecampApp.Collections.AssignedTasks();
    return this._assignments;
  },

  parse: function (payload) {
    if (payload.assignments) {
      this.assignments().set(payload.assignments);
      delete payload.assignments;
    }
    
    if (payload.comments) {
      this.comments().set(payload.comments, { parse: true });
      delete payload.comments;
    }
    return payload;
  },

  comments: function () {
    this._comments = this._comments || new BasecampApp.Collections.Comments();
    return this._comments;
  }
});