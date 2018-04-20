class SchoolsController < ApplicationController
    def index
      respond_to do |format|
        format.html
        format.json { render json: SchoolDatatable.new(view_context) }
      end
    end
end
