class PlacesController < ApplicationController
    def index
        @places = Place.order('created_at DESC')
    end

    def show
        # Load the static maps API key
        file_lines = []
        File.open('secrets.txt','r') do |f|
            f.each_line {|line| file_lines = file_lines + [line.split(':')[1].strip()]}
        end
        @static_map_api_key = file_lines[1]

        @place = Place.find(params[:id])
    end

    def new
        @place = Place.new
    end

    def create
        @place = Place.create_place!(place_params)
        # @place = Place.new(place_params)
        if @place.save
            # puts"@place.latitude: " + @place.latitude.inspect
            flash[:success] = 'Place added!'
            redirect_to root_path
        else
            render 'new'
        end
    end

    private

    def place_params
        params.require(:place).permit(:title, :address, :visited_by)
    end
end