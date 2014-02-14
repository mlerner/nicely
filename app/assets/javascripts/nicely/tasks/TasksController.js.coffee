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

  newHelp: (task) ->
    if @userID()?
      $.ajax(
        url: "/tasks/#{task}/revoke",
        type: "POST",
        dataType: 'json'
        data: {
          task_id: task
          user_id: @userID()
        }
        success: (data, status, xhr) =>
          if data.success
            @trigger('task:revoked', data)

        error: () =>
          @trigger('task:notrevoked')
      )

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

  deleteTask: (task) ->
    if @userID()?
      $.ajax(
        url: "/tasks/#{task}/delete",
        type: "POST",
        data: {
          user_id: @userID()
        }
        success: (data, status, xhr) =>
          @trigger('task:deleteSuccess', data)

        error: () =>
          @trigger('task:deleteFailure')
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

