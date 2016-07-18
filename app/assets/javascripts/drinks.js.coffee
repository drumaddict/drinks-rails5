#Gallery page ajax
jQuery ($) ->
  console.log('DRINKS LOADED')
  # $('#flash-photo-msg').hide()
  apply_drink_filer= ->
    $('.drink-category').each ->
      $this = $(this)
      $this.on 'change', (e) ->
        console.log('SELE')
        console.log('event',e)
        console.log('value',e.target.value)
        # e.preventDefault()
        url= $('.order-form').attr('data-url')
        # console.log(offset, 'offset')
        $.ajax(
          dataType: 'json'
          cache: false
          url: url
          data:
            cat_id: e.target.value
          beforeSend: (xhr) ->
            # $('body').append '<div class="main-loader"></div>'
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
          console.log( 'fail' );
          return
        ).always (data) ->
          console.log( 'always' );
          # $('.main-loader').remove()
          return
        return
      return
  apply_drink_filer()
  $('#drinks').on 'cocoon:after-insert', (e, insertedItem) ->
    apply_drink_filer()
  return
