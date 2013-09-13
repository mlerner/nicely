module 'Nicely.Tasks.TasksController'

class Nicely.Tasks.TasksController extends Nicely.Base
  attributes: {
    userID: null,
    newOfferURL: null,
    newReportURL: null
  }

  constructor: ->
    @initializeAttributes(@attributes)
    super()

  newOffer: (task) ->
    if @newOfferURL()? && @userID()?
      $.ajax(
        url: @newOfferURL(),
        type: "POST",
        data: {
          task_id: task
          user_id: @userID()
        }
        success: (data, status, xhr) =>
          @trigger('offer:success', data)

        error: () =>
          @trigger('offer:failure')
      )

  reportTask: (task) ->
    if @newReportURL()? && @userID()?
      $.ajax(
        url: @newReportURL(),
        type: "POST",
        data: {
          task_id: task
          user_id: @userID()
        }
        success: (data, status, xhr) =>
          @trigger('report:success', data)

        error: () =>
          @trigger('report:failure')
      )

