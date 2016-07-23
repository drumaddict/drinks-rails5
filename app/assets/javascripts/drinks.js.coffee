#Drink Filtering And milk/sugar ohhtions
jQuery ($) ->
  console.log('drinks.js.coffee LOADED')
  #Toggle reoccuring days and hour
  toggle_hour_and_days = ()->
    reoccuring_selected = $('.reoccuring').prop('checked')
    # console.log(reoccuring_selected, 'reoccuring selected?')
    if reoccuring_selected
      $('.days').fadeTo(100,1)
      $('.hour').fadeTo(100,1)
    else
      $('.days').fadeTo('slow',0)
      $('.hour').fadeTo('slow',0)
  toggle_hour_and_days()
  $('.reoccuring').click ->
    toggle_hour_and_days()
    return
  $('tr.tt').tooltip()
  handle_milk_sugar_selects = (id,elem)->
    if id
      sugar_select = elem.parent().parent().find('.sugar-select')
      milk_select = elem.parent().parent().find('.milk-select')
      sm= JSON.parse($('.order-form ').attr('data-milk-sugar'))
      if  sm[id]['has_sugar']  == true
        sugar_select.find('option').removeAttr('disabled')
        sugar_select.fadeTo(100,1.0)
        sugar_select.attr('disabled',false)
      else
        sugar_select.find("option:selected").attr('selected', false)
        sugar_select.val('no_sugar')
        sugar_select.find("option[value='no_sugar']").attr('selected', true)
        sugar_select.find(':not(:selected)').attr('disabled','disabled')
        sugar_select.fadeTo('slow',0.4)
      if  sm[id]['has_milk'] == true
        milk_select.find('option').removeAttr('disabled')
        milk_select.fadeTo(100,1.0)
        milk_select.attr('disabled',false)
      else
        milk_select.find("option:selected").attr('selected', false)
        milk_select.val('no_milk')
        milk_select.find("option[value='no_milk']").attr('selected', true)
        milk_select.find(':not(:selected)').attr('disabled','disabled')
        milk_select.fadeTo('slow',0.4)
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
