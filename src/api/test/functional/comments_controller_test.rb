require File.expand_path(File.dirname(__FILE__) + "/..") + "/test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest 

  fixtures :all

  def setup
   prepare_request_with_user("Admin","opensuse")
  end

  def test_show_and_post_comments_on_project
    # Testing new comment creation
    post "/webui/comments/project/BaseDistro/new", {:project => "BaseDistro", :title => "This is a title", :body => "This is a body", :user => "Admin"}
    assert_response :success

    # testing empty comments
    post "/webui/comments/project/BaseDistro/new", {:project => "BaseDistro", :title => "This is a title", :user => "Admin"}
    assert_response 403

    # counter test
    get "/webui/comments/project/BaseDistro"
    assert_response :success

    post "/webui/comments/project/BaseDistro/new", {:project => "BaseDistro", :title => "This is a title"}
    assert_response 403
  end

  def test_update_permissions_for_comments_on_project
    reset_auth
    prepare_request_with_user "tom", "thunder"

    put "/webui/comments/project/BaseDistro/update", {:comment_id => 100, :update_type => 'delete', :user => 'tom', :title => "This is a title", :body => "Comment deleted"}
    assert_response 200

    # Test to see if another user can delete a comment he/she is not associated with
    prepare_request_with_user "tom", "thunder"

    put "/webui/comments/project/BaseDistro/update", {:comment_id => 100, :update_type => 'delete', :user => 'Iggy',:project => "BaseDistro", :title => "This is a title", :body => "Comment deleted"}
    assert_response 400

    # Test to see check permission on editing comments

    put "/webui/comments/project/BaseDistro/update", {:comment_id => 100, :update_type => 'edit', :user => 'Iggy',:project => "BaseDistro", :title => "This is a title", :body => "Comment deleted"}
    assert_response 400

    put "/webui/comments/project/BaseDistro/update", {:comment_id => 100, :update_type => 'edit', :user => 'tom',:project => "BaseDistro", :title => "This is a title", :body => "Comment deleted"}
    assert_response 200
  end

  def test_update_permissions_for_comments_on_package
    reset_auth
    prepare_request_with_user "tom", "thunder"

    put "/webui/comments/package/BaseDistro/pack1/update", {:comment_id => 102, :update_type => 'delete', :user => 'tom', :title => "This is a title", :body => "Comment deleted"}
    assert_response 200

    # Test to see if another user can delete a comment he/she is not associated with
    prepare_request_with_user "tom", "thunder"

    put "/webui/comments/package/BaseDistro/pack1/update", {:comment_id => 102, :update_type => 'delete', :user => 'Iggy', :title => "This is a title", :body => "Comment deleted"}
    assert_response 400

    # Test to see check permission on editing comments

    put "/webui/comments/package/BaseDistro/pack1/update", {:comment_id => 102, :update_type => 'edit', :user => 'Iggy', :title => "This is a title", :body => "Comment deleted"}
    assert_response 400

    put "/webui/comments/package/BaseDistro/pack1/update", {:comment_id => 102, :update_type => 'edit', :user => 'tom', :title => "This is a title", :body => "Comment deleted"}
    assert_response 200
  end

  def test_update_permissions_for_comments_on_request
    reset_auth
    prepare_request_with_user "tom", "thunder"

    put "/webui/comments/request/1000/update", {:comment_id => 103, :update_type => 'delete', :user => 'tom', :title => "This is a title", :body => "Comment deleted"}
    assert_response 200

    # Test to see if another user can delete a comment he/she is not associated with
    prepare_request_with_user "tom", "thunder"

    put "/webui/comments/request/1000/update", {:comment_id => 103, :update_type => 'delete', :user => 'Iggy', :title => "This is a title", :body => "Comment deleted"}
    assert_response 400

    # Test to see check permission on editing comments

    put "/webui/comments/request/1000/update", {:comment_id => 103, :update_type => 'edit', :user => 'Iggy', :title => "This is a title", :body => "Comment deleted"}
    assert_response 400

    put "/webui/comments/request/1000/update", {:comment_id => 103, :update_type => 'edit', :user => 'tom', :title => "This is a title", :body => "Comment deleted"}
    assert_response 200
  end

end

