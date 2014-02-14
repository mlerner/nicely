module 'Nicely.Feed'

class Nicely.Feed.FeedView extends Backbone.View
  events: {
    'click .red-full-heart': 'userUnlike'
    'click .red-empty-heart': 'userLike'
  }

  constructor: (user_id, options) ->
    @user_id = user_id
    super(options)

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
        user_id: @user_id
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
        user_id: @user_id
      },
      success: ->
    })
