class DrugsController < ApplicationController
  before_action :set_package
  before_action :set_drug, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @drugs = Drug.all
    respond_with(@drugs)
  end

  def show
    respond_with(@package, @drug)
  end

  def create
    @drug = Drug.new(drug_params)
    @drug.save
    respond_with(@package, @drug)
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
      params.require(:drug).permit(:name).merge(package_id: params[:package_id])
    end
end
