class ProjectsController < ApplicationController

    def show
        @project = Project.find(params[:id])
        @donation = Donation.new(project_id: @project.id)
    end

end
