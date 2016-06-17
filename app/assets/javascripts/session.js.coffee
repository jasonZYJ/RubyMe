
#= require shared/utils

root = window || @

class root.UserSessionView extends Backbone.View

  events:
    "click a.rucaptcha-image-box": "reLoadRucaptchaImage"

  reLoadRucaptchaImage: (e) ->
    btn = $(e.currentTarget)
    img = btn.find('img:first')
    currentSrc = img.attr('src')
    img.attr('src', currentSrc.split('?')[0] + '?' + (new Date()).getTime())
    return false

