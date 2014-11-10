# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = window || @

class root.CategoryListView extends Backbone.View

  events:
    'click .btn_new_category'   : 'new_one'
    'submit .form_new_category' : 'create_one'

  initialize: (options) ->
    _.extend(@, options)
    @new_category_el = @$el.find('.template_new_category')

  new_one: () ->
    @new_category_el.slideToggle()

  create_one: () ->
    $form = @$el.find('.form_new_category')
    url = $form.attr('action')

    $.ajax
      url: url,
      type: 'POST',
      dataType: 'json',
      data: $form.serialize(),
      success: (data, status, xhr) =>
        document.location.reload()
      error: (xhr, status, error) =>
        alert(xhr.responseText)
    false
