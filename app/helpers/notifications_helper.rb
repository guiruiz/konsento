module NotificationsHelper

  #TODO Fix
  def classes_for_notification(notification_read_was)
    if notification_read_was
      classes = 'list-group-item'
    else
      classes = 'list-group-item unread'
    end
  end

  def icon_class_for_notification(notification)
    case notification.notifiable_type
    when 'Comment'
      icon_class = 'fa-comment-o'
    when 'Topic'
      icon_class = 'fa-list'
    when 'TeamInvitation'
      icon_class = 'fa-send-o'
    end
    icon_class
  end

  def message_for_notification(notification)
    case notification.notifiable_type
    when 'Comment'
      message = t 'notification_messages.' + notification.key, topic_title: notification.data['topic_title']
    when 'Topic'
      message = t 'notification_messages.' + notification.key, group_title: notification.data['group_title']
    when 'TeamInvitation'
      message = t 'notification_messages.' + notification.key, team_title: notification.data['team_title']
    end
    puts message
    message
  end

  def link_for_notification(notification)
    if notification.notifiable
      case notification.notifiable_type
      when 'Comment'
        case notification.notifiable.commentable_type
        when 'Topic'
          link = topic_path(notification.notifiable.commentable)
        when 'Proposal'
          link = proposal_path(notification.notifiable.commentable)
        end
      when 'Topic'
        link = topic_path(notification.notifiable)
      when 'TeamInvitation'
        link = accept_team_invitations_path(notification.notifiable.token)
      end
    else
      #TODO Create unavailable notification view
      link = '#'
    end
    link
  end
end
