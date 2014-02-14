module 'Nicely.Tasks'

class Nicely.Tasks.TaskChatView extends Backbone.View

  events: {
    'submit' : 'validate'
  }

  constructor: (chatPath, options) ->
    super(options)
    @messageTemplate = @create_template_for('#message-template')
    @chatPath = chatPath
    PrivatePub.subscribe(@chatPath, (data, channel) =>
      @handleNewMessage(data, channel)
    )
    @scrollBottom()

  validate: ->
    message = @$('#message_content').val()
    if message.length > 0
      true
    else
      false

  clearContents: ->
    console.log 'cleared'
    @$('#message_content').html('')

  handleNewMessage: (data, channel) ->
    @messageContent = @messageTemplate({
      name: data.sender
      content: data.message
      time_ago: data.time_ago
    })
    @$('.messages').append(@messageContent)
    @scrollBottom()

  scrollBottom: ->
    @$('.messages').animate({
      scrollTop: @$('.messages').prop('scrollHeight') - @$('.messages').height()
    })