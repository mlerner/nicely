module 'Nicely.Tasks'

class Nicely.Tasks.TaskView extends Backbone.View
  events: {
    'click #help-button.active': 'offerHelp',
    'click #report-button.active': 'reportTask'
    'click #share-facebook': 'openFacebookLink'
    'click #revoke-button': 'newHelp'
    'click #delete-button': 'deleteTask'
    'click .red-full-heart': 'userUnlike'
    'click .red-empty-heart': 'userLike'

  }

  constructor: (controller, model, root_path, options) ->
    @tasksController = controller
    @model = new Nicely.Tasks.Task(model)
    @root_path = root_path
    @mapView = new Nicely.Tasks.MapView(@model.toJSON())

    @tasksController.on('offer:success', (data) =>
      @handleOfferSuccess(data)
    )
    @tasksController.on('offer:failure', =>
      @handleOfferFailure()
    )

    @tasksController.on('report:success', =>
      @handleReportSuccess()
    )

    @tasksController.on('report:failure', =>
      @handleReportFailure()
    )

    @tasksController.on('task:revoked', =>
      @handleRevokeSuccess()
    )

    @tasksController.on('task:deleteSuccess', =>
      @handleTaskDeleteSuccess()
    )
    super(options)

  offerHelp: ->
    taskID = @model.get('id')
    @$('#help-button').toggleClass('disabled')
    @$('#help-button').html('Saving offer...')
    @tasksController.newOffer(taskID)

  newHelp: ->
    taskID = @model.get('id')
    @$('#revoke-button').toggleClass('disabled')
    @$('#revoke-button').html('Unassigning task!')
    @tasksController.newHelp(taskID)

  deleteTask: ->
    taskID = @model.get('id')
    @tasksController.deleteTask(taskID)

  reportTask: ->
    taskID = @model.get('id')
    @$('#report-button').toggleClass('disabled')
    @$('#report-button').html('Reporting...')
    @tasksController.reportTask(taskID)

  handleOfferSuccess: ->
    @$('#help-button').html('Help offered')

  # TODO: Implement offer failure to save
  handleOfferFailure: ->
    @$('#report-button').toggleClass('disabled', false)

  handleReportSuccess: ->
    @$('#report-button').html('Reported')

  handleReportFailure: ->
    @$('#report-button').toggleClass('disabled', false)

  handleRevokeSuccess: () ->
    location.reload()

  handleTaskDeleteSuccess: () ->
    location.href = @root_path

  userUnlike: (event) ->
    $clickedHeart = jQuery(event.currentTarget)
    task_id = $clickedHeart.data('taskId')
    $count = $clickedHeart.next().find('p')
    $count.data('count', $count.data('count') - 1)
    $count.html($count.data('count'))
    $clickedHeart.toggleClass('red-full-heart', false)
    $clickedHeart.toggleClass('red-empty-heart', true)
    $.ajax({
      url: "/tasks/#{task_id}/unlike"
      method: "POST"
      data: {
        user_id: tasksController.userID()
      },
    })

  userLike: (event) ->
    $clickedHeart = jQuery(event.currentTarget)
    task_id = $clickedHeart.data('taskId')
    $count = $clickedHeart.next().find('p')
    $count.data('count', $count.data('count') + 1)
    $count.html($count.data('count'))
    $clickedHeart.toggleClass('red-empty-heart', false)
    $clickedHeart.toggleClass('red-full-heart', true)
    $.ajax({
      url: "/tasks/#{task_id}/like"
      method: "POST"
      data: {
        user_id: tasksController.userID()
      },
      success: ->
    })


