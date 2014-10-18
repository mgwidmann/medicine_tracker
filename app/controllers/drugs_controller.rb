class DrugsController < ApplicationController
  include Transformations

  before_action :set_package
  before_action :set_drug, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @drugs = Drug.all
    respond_with(@drugs, include: :expiration_dates)
  end

  def show
    respond_with(@package, @drug, include: :expiration_dates)
  end

  def create
    @drug = Drug.new(drug_params)
    @drug.save
    respond_with(@package, @drug, include: :expiration_dates)
  end

  def update
    @drug.update(drug_params)
    respond_with(@package, @drug)
  end

  def destroy
    @drug.destroy
    respond_with(@package, @drug)
  end

  private
    def set_package
      @package = Package.find(params[:package_id])
    end

    def set_drug
      @drug = @package.drugs.find(params[:id])
    end

    def drug_params
      transform_expiration_dates params.require(:drug).permit(:name, EXPIRATION_DATES).merge(package_id: params[:package_id])
    end
end
