class SettlementsController < ApplicationController
  before_action :set_settlement, only: %i[show edit update destroy]

  def index
    @group = Group.find(params[:group_id])
    @settlements = Settlement.where(user: current_user, group_id: @group.id).order(updated_at: :desc)
    @total = Settlement.where(user: current_user, group_id: @group.id).sum(:amount)
  end

  def show
    @group = Group.find(params[:group_id])
    @settlement = Settlement.find(params[:id])
  end

  def new
    @group = Group.find(params[:group_id])
    @settlement = Settlement.new
  end

  def edit; end

  def create
    @settlement = Settlement.new(settlement_params)
    @settlement.user_id = current_user.id
    group = Group.find(params[:group_id])
    @settlement.group_id = group.id

    if @settlement.save
      redirect_to group_settlements_url(group_id: @settlement.group_id),
                  notice: 'Payment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @settlement.update(settlement_params)
      redirect_to settlement_url(@settlement), notice: 'Payment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @settlement.destroy
    redirect_to settlements_url, notice: 'Payment was successfully destroyed.'
  end

  private

  def set_settlement
    @settlement = Settlement.find(params[:id])
  end

  def settlement_params
    params.require(:settlement).permit(:name, :amount)
  end
end
