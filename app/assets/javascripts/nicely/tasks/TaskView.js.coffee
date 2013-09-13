module 'Nicely.Tasks'

class Nicely.Tasks.TaskView extends Backbone.View
  events: {
    'click #help-button.active': 'offerHelp',
    'click #report-button.active': 'reportTask'
    'click #share-facebook': 'openFacebookLink'

  }

  constructor: (controller, model, options) ->
    @tasksController = controller
    @model = new Nicely.Tasks.Task(model)
    console.log @model.toJSON()
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
    super(options)

  offerHelp: ->
    taskID = @model.get('id')
    @$('#help-button').toggleClass('disabled')
    @$('#help-button').html('Saving offer...')
    @tasksController.newOffer(taskID)

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

