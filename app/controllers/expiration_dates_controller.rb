class ExpirationDatesController < ApplicationController
  before_action :set_package
  before_action :set_drug
  before_action :set_expiration_date, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @expiration_dates = @drug.expiration_dates
    respond_with(@expiration_dates)
  end

  def show
    respond_with(@package, @drug, @expiration_date)
  end

  def create
    @expiration_date = ExpirationDate.new(expiration_date_params)
    @expiration_date.save
    respond_with(@package, @drug, @expiration_date)
  end

  def update
    @expiration_date.update(expiration_date_params)
    respond_with(@package, @drug, @expiration_date)
  end

  def destroy
    @expiration_date.destroy
    respond_with(@package, @drug, @expiration_date)
  end

  private
    def set_package
      @package = Package.find(params[:package_id])
    end

    def set_drug
      @drug = @package.drugs.find(params[:drug_id])
    end

    def set_expiration_date
      @expiration_date = @drug.expiration_dates.find(params[:id])
    end

    def expiration_date_params
      params.require(:expiration_date).permit(:date, :drug_id).merge(drug_id: params[:drug_id])
    end
end
