module JQueryMobile
  def within_active_page
    within ".ui-page-active" do
      yield
    end
  end
end

World(JQueryMobile)
