#Drink Filtering And milk/sugar options
jQuery ($) ->
  console.log('drinks.js.coffee LOADED')
  handle_milk_sugar_selects = (id,elem)->
    if id
      sugar_select = elem.parent().parent().find('.sugar-select')
      milk_select = elem.parent().parent().find('.milk-select')
      sm= JSON.parse($('.order-form ').attr('data-milk-sugar'))
      if  sm[id]['has_sugar']  == true
        sugar_select.attr('disabled',false)
      else
        sugar_select.val('no_sugar')
        sugar_select.attr('disabled',true)
      if  sm[id]['has_milk'] == true
        milk_select.attr('disabled',false)
      else
        milk_select.val('no_milk')
        milk_select.attr('disabled',true)
  $('.drink-category').each ->
    cat_id =  $(this).val()
    handle_milk_sugar_selects(cat_id,$(this))
  apply_drink_filer= ->
    $('.drink-category').each ->
      $this = $(this)
      $this.on 'change', (e) ->
        url= $('.order-form').attr('data-url')
        cat_id =  e.target.value
        handle_milk_sugar_selects(cat_id,$this)
        $.ajax(
          dataType: 'json'
          cache: false
          url: url
          data:
            cat_id: cat_id
          beforeSend: (xhr) ->
            return
        ).done((data) ->
          drink_select = $this.parent().parent().find('.drink-select')
          drink_select.html('')
          $.each data, (i, drink) ->
            drink_select.append $('<option>').text(drink.name).attr('value', drink.id)
          return
        ).fail((data) ->
          console.log( 'fail' )
          return
        ).always (data) ->
          console.log( 'always' )
          return
        return
      return
  apply_drink_filer()
  $('#drinks').on 'cocoon:after-insert', (e, insertedItem) ->
    apply_drink_filer()
  return
