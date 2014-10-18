class PackagesController < ApplicationController
  include Transformations

  before_action :set_package, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @packages = Package.all
    respond_with(@packages)
  end

  def show
    respond_with(@package)
  end

  def create
    @package = Package.new(package_params)
    @package.save
    respond_with(@package, include: {drugs: {include: :expiration_dates}})
  end

  def update
    @package.update(package_params)
    respond_with(@package)
  end

  def destroy
    @package.destroy
    respond_with(@package)
  end

  private
    def set_package
      @package = Package.find(params[:id])
    end

    def package_params
      # Description of how params come into the API
      transform_drugs params.require(:package).permit(:name, :serial, DRUGS)
    end
end
