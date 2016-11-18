class SettingsController < ApplicationController
    before_action :get_setting, only: [:edit, :update]

    def index
    	authorize :setting, :index?
    	@setting = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
      @settings = Setting.get_all
    end

    def edit
    	authorize :setting, :index?
    end

    def update
    	authorize :setting, :index?
      if @setting.value != params[:setting][:value]
        @setting.value = params[:setting][:value]
        @setting.save
        redirect_to settings_path, notice: 'Setting has updated.'
      else
        redirect_to settings_path
      end
    end

    def get_setting
      @setting = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
    end
end