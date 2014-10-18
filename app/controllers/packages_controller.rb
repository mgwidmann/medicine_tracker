class PackagesController < ApplicationController
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
    respond_with(@package)
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
      transform_request params.require(:package).permit(:name, :serial, {drugs: [:name, {expiration_dates: []}]})
    end

    def transform_request(package)
      # Transform the parameters to how Rails is expecting them
      (package[:drugs] || []).map! do |drug|
        (drug[:expiration_dates] || []).map! do |date|
          {date: date}
        end
        drug[:expiration_dates_attributes] = drug.delete(:expiration_dates) if drug[:expiration_dates]
        drug.permit(:name, {expiration_dates_attributes: [:date]})
      end
      package[:drugs_attributes] = package.delete(:drugs) if package[:drugs] # Rename
      package
    end
end
