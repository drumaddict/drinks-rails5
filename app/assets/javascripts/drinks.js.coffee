#Gallery page ajax
jQuery ($) ->
  console.log('DRINKS LOADED')
  # $('#flash-photo-msg').hide()
  #
  console.log('SEL_DCa, ', $('.drink-category').value)
  $('.drink-category').each ->
    $this = $(this)
    cat_id =  $this.val()
    sugar_select = $this.parent().parent().find('.sugar-select')
    milk_select = $this.parent().parent().find('.milk-select')
    sm= JSON.parse($('.order-form ').attr('data-milk-sugar'))
    # console.log('sm',sm)
    if  sm[cat_id]['has_sugar'] == true
      sugar_select.attr('disabled',false)
    else
      sugar_select.attr('disabled',true)
    if  sm[cat_id]['has_milk'] == true
      milk_select.attr('disabled',false)
    else
      milk_select.attr('disabled',true)
  apply_drink_filer= ->
    $('.drink-category').each ->
      $this = $(this)
      $this.on 'change', (e) ->
        url= $('.order-form').attr('data-url')
        cat_id =  e.target.value
        sugar_select = $this.parent().parent().find('.sugar-select')
        milk_select = $this.parent().parent().find('.milk-select')
        sm= JSON.parse($('.order-form ').attr('data-milk-sugar'))
        # console.log('sm',sm)
        if  sm[cat_id]['has_sugar'] == true
          sugar_select.attr('disabled',false)
        else
          sugar_select.attr('disabled',true)
        if  sm[cat_id]['has_milk'] == true
          milk_select.attr('disabled',false)
        else
          milk_select.attr('disabled',true)
        $.ajax(
          dataType: 'json'
          cache: false
          url: url
          data:
            cat_id: cat_id
          beforeSend: (xhr) ->
            return
        ).done((data) ->
          console.log(data)
          drink_select = $this.parent().parent().find('.drink-select')
          drink_select.html('')
          $.each data, (i, drink) ->
            console.log(i,'i')
            console.log(drink,'drink')
            console.log($this,'this')
            console.log($this.parent().parent(),'parebn')
            console.log($this.parent().parent().find('.drink-select').attr('class'),'close')
            drink_select.append $('<option>').text(drink.name).attr('value', drink.id)
          return
        ).fail((data) ->
          console.log( 'fail' )
          return
        ).always (data) ->
          console.log( 'always' )
          # $('.main-loader').remove()
          return
        return
      return
  apply_drink_filer()
  $('#drinks').on 'cocoon:after-insert', (e, insertedItem) ->
    apply_drink_filer()
    console.log('')
  return
